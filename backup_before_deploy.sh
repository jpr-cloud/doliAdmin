#!/bin/bash

# Script de respaldo previo a la ejecución del playbook master.yml
# Ejecutar antes de aplicar cambios: ./backup_before_deploy.sh

BACKUP_DIR="/tmp/ansible_backup_$(date +%Y%m%d_%H%M%S)"
LOG_FILE="$BACKUP_DIR/backup.log"

echo "=== SCRIPT DE RESPALDO PRE-DEPLOYMENT ===" | tee -a "$LOG_FILE"
echo "Fecha: $(date)" | tee -a "$LOG_FILE"
echo "Directorio de respaldo: $BACKUP_DIR" | tee -a "$LOG_FILE"

# Crear directorio de respaldo
mkdir -p "$BACKUP_DIR"

# Función para hacer respaldo con logging
backup_file() {
    local file="$1"
    local backup_path="$BACKUP_DIR$(dirname "$file")"
    
    if [[ -f "$file" || -d "$file" ]]; then
        echo "Respaldando: $file" | tee -a "$LOG_FILE"
        mkdir -p "$backup_path"
        cp -r "$file" "$backup_path/" 2>/dev/null || echo "Error respaldando $file" | tee -a "$LOG_FILE"
    else
        echo "Archivo no existe: $file" | tee -a "$LOG_FILE"
    fi
}

# Respaldar archivos de configuración críticos
echo "Iniciando respaldo de archivos críticos..." | tee -a "$LOG_FILE"

backup_file "/etc/hostname"
backup_file "/etc/hosts"
backup_file "/etc/sysctl.conf"
backup_file "/etc/bash.bashrc"
backup_file "/etc/pam.d/common-password"
backup_file "/etc/sudoers"
backup_file "/etc/sudoers.d"
backup_file "/etc/ssh/sshd_config"
backup_file "/etc/ssh/sshd_config.d"
backup_file "/etc/apache2"
backup_file "/etc/php"
backup_file "/etc/mysql"
backup_file "/etc/mariadb"
backup_file "/etc/sellyoursaas.conf"
backup_file "/etc/sellyoursaas-public.conf"
backup_file "/etc/sellyoursaas.d"
backup_file "/etc/systemd/system"
backup_file "/etc/cron.d"
backup_file "/etc/crontab"

# Respaldar información del sistema
echo "Respaldando información del sistema..." | tee -a "$LOG_FILE"
hostname > "$BACKUP_DIR/hostname_original"
whoami > "$BACKUP_DIR/current_user"
id > "$BACKUP_DIR/user_id"
groups > "$BACKUP_DIR/user_groups"
ps aux > "$BACKUP_DIR/processes_before"
systemctl list-units --failed > "$BACKUP_DIR/failed_services_before"
systemctl list-units --type=service --state=active > "$BACKUP_DIR/active_services_before"
netstat -tulpn > "$BACKUP_DIR/network_ports_before" 2>/dev/null || ss -tulpn > "$BACKUP_DIR/network_ports_before"
df -h > "$BACKUP_DIR/disk_usage_before"
free -h > "$BACKUP_DIR/memory_usage_before"
uname -a > "$BACKUP_DIR/system_info"
lsb_release -a > "$BACKUP_DIR/os_info" 2>/dev/null || cat /etc/os-release > "$BACKUP_DIR/os_info"

# Respaldar lista de paquetes instalados
echo "Respaldando lista de paquetes..." | tee -a "$LOG_FILE"
dpkg --get-selections > "$BACKUP_DIR/installed_packages"
apt list --installed > "$BACKUP_DIR/apt_installed_packages" 2>/dev/null

# Respaldar configuraciones de usuarios
echo "Respaldando configuraciones de usuarios..." | tee -a "$LOG_FILE"
cp /etc/passwd "$BACKUP_DIR/passwd_backup"
cp /etc/group "$BACKUP_DIR/group_backup"
cp /etc/shadow "$BACKUP_DIR/shadow_backup" 2>/dev/null || echo "No se pudo respaldar /etc/shadow (permisos)" | tee -a "$LOG_FILE"

# Crear script de restauración
cat > "$BACKUP_DIR/restore.sh" << 'EOF'
#!/bin/bash

# Script de restauración automática
# Ejecutar como root: sudo ./restore.sh

BACKUP_DIR="$(dirname "$0")"
LOG_FILE="$BACKUP_DIR/restore.log"

echo "=== RESTAURACIÓN DESDE RESPALDO ===" | tee -a "$LOG_FILE"
echo "Fecha: $(date)" | tee -a "$LOG_FILE"
echo "Directorio de respaldo: $BACKUP_DIR" | tee -a "$LOG_FILE"

# Función para restaurar archivos
restore_file() {
    local backup_path="$1"
    local original_path="$2"
    
    if [[ -f "$backup_path" || -d "$backup_path" ]]; then
        echo "Restaurando: $original_path" | tee -a "$LOG_FILE"
        cp -r "$backup_path" "$(dirname "$original_path")/" 2>/dev/null || echo "Error restaurando $original_path" | tee -a "$LOG_FILE"
    else
        echo "Respaldo no encontrado: $backup_path" | tee -a "$LOG_FILE"
    fi
}

# Restaurar archivos críticos
echo "Restaurando archivos críticos..." | tee -a "$LOG_FILE"

restore_file "$BACKUP_DIR/etc/hostname" "/etc/hostname"
restore_file "$BACKUP_DIR/etc/hosts" "/etc/hosts"
restore_file "$BACKUP_DIR/etc/sysctl.conf" "/etc/sysctl.conf"
restore_file "$BACKUP_DIR/etc/bash.bashrc" "/etc/bash.bashrc"
restore_file "$BACKUP_DIR/etc/pam.d/common-password" "/etc/pam.d/common-password"
restore_file "$BACKUP_DIR/etc/sudoers.d" "/etc/sudoers.d"
restore_file "$BACKUP_DIR/etc/ssh/sshd_config" "/etc/ssh/sshd_config"
restore_file "$BACKUP_DIR/etc/ssh/sshd_config.d" "/etc/ssh/sshd_config.d"
restore_file "$BACKUP_DIR/etc/passwd" "/etc/passwd"
restore_file "$BACKUP_DIR/etc/group" "/etc/group"

# Restaurar hostname original
if [[ -f "$BACKUP_DIR/hostname_original" ]]; then
    original_hostname=$(cat "$BACKUP_DIR/hostname_original")
    hostnamectl set-hostname "$original_hostname"
    echo "Hostname restaurado a: $original_hostname" | tee -a "$LOG_FILE"
fi

# Reiniciar servicios críticos
echo "Reiniciando servicios críticos..." | tee -a "$LOG_FILE"
systemctl restart ssh
systemctl restart systemd-logind

echo "Restauración completada. Revise el log: $LOG_FILE" | tee -a "$LOG_FILE"
echo "IMPORTANTE: Reinicie el servidor para asegurar que todos los cambios se apliquen correctamente."
EOF

chmod +x "$BACKUP_DIR/restore.sh"

echo "=== RESPALDO COMPLETADO ===" | tee -a "$LOG_FILE"
echo "Directorio de respaldo: $BACKUP_DIR" | tee -a "$LOG_FILE"
echo "Log de respaldo: $LOG_FILE" | tee -a "$LOG_FILE"
echo "Script de restauración: $BACKUP_DIR/restore.sh" | tee -a "$LOG_FILE"
echo ""
echo "Para restaurar en caso de problemas, ejecute:"
echo "sudo $BACKUP_DIR/restore.sh"
echo ""
echo "IMPORTANTE: Guarde esta información en un lugar seguro."
