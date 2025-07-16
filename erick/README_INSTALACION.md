# SellYourSaas - Guía de Instalación

## 📋 Resumen

Este proyecto permite instalar SellYourSaas de forma automatizada usando Ansible. Puedes instalar:

1. **Ambos servidores juntos** (instalación completa)
2. **Solo el servidor Master** (administración central)
3. **Solo el servidor Deployment** (para instancias de clientes)

## 🏗️ Arquitectura

### Servidor Master
- **Función**: Panel de administración, base de datos central, NFS server
- **Servicios**: Dolibarr principal, MariaDB, Apache, NFS, Fail2ban
- **Acceso**: `https://admin.tudominio.com` y `https://myaccount.tudominio.com`

### Servidor Deployment  
- **Función**: Alojar instancias de clientes
- **Servicios**: Apache multi-instancia, NFS client, Fail2ban
- **Acceso**: `https://cliente1.instancias.com`, `https://cliente2.instancias.com`, etc.

## ⚙️ Configuración Previa

### 1. Verificación Previa (IMPORTANTE)
Antes de instalar, ejecuta las verificaciones:

```bash
# Verificar configuración y conectividad
ansible-playbook -i hosts.cfg pre_install_check.yml
```

### 2. Editar Variables
Modifica `group_vars/all.yml` con tus datos:

```yaml
# IPs de tus servidores
master_server:
  ip: "192.168.1.2"          # ← Cambiar por tu IP
  hostname: "main"
  domain: "jpyrsa.com.mx"     # ← Cambiar por tu dominio
  fqdn: "main.jpyrsa.com.mx"

deployment_server:
  ip: "192.168.1.3"          # ← Cambiar por tu IP  
  hostname: "deploy"
  domain: "a1.jpyrsa.com.mx" # ← Dominio para instancias
  fqdn: "deploy.jpyrsa.com.mx"

# Credenciales
database:
  root_password: "tu_password_root"     # ← Cambiar
  user: "sellyoursaas"
  password: "tu_password_usuario"       # ← Cambiar
  main_db: "dolibarr_main"              # ← Base principal

system_users:
  app_admin: "admin"
  passwords:
    admin: "tu_password_admin"          # ← Cambiar

# SSH (IMPORTANTE: Cambiar por tus claves reales)
ssh_config:
  port: 2222

ssh_keys:
  admin_public: "ssh-rsa TU_CLAVE_PUBLICA_ADMIN"  # ← Cambiar
  root_public: "ssh-rsa TU_CLAVE_PUBLICA_ROOT"    # ← Cambiar

notifications:
  email: "admin@tudominio.com"          # ← Cambiar
```

### 3. Configurar SSH
Asegúrate de poder conectarte por SSH a tus servidores:

```bash
# Generar clave SSH si no tienes
ssh-keygen -t rsa -b 4096 -C "admin@tudominio.com"

# Copiar clave a servidores
ssh-copy-id usuario@192.168.1.2
ssh-copy-id usuario@192.168.1.3

# Agregar tu clave pública al archivo group_vars/all.yml
cat ~/.ssh/id_rsa.pub  # Copiar esta salida a ssh_keys.admin_public
```

## ✅ Verificación Previa

**OBLIGATORIO:** Ejecutar antes de la instalación:

```bash
# Verificar configuración y conectividad
ansible-playbook -i hosts.cfg pre_install_check.yml
```

Este comando verifica:
- ✅ Variables obligatorias definidas
- ✅ Conectividad SSH con servidores  
- ✅ Versión de Ubuntu compatible
- ✅ Memoria RAM suficiente (mín. 2GB)
- ✅ Espacio en disco suficiente (mín. 20GB)
- ✅ Acceso sudo configurado

## 🚀 Opciones de Instalación

### Opción 1: Instalación Completa (Master + Deployment)

```bash
# Instalar ambos servidores
ansible-playbook -i hosts.cfg site.yml
```

### Opción 2: Solo Servidor Master

```bash
# Instalar solo master
ansible-playbook -i hosts_master_only.cfg install_master_only.yml
```

### Opción 3: Solo Servidor Deployment

```bash
# Instalar solo deployment (requiere master ya instalado)
ansible-playbook -i hosts_deploy_only.cfg install_deploy_only.yml
```

### Opción 4: Instalación Paso a Paso

#### Primero el Master:
```bash
ansible-playbook -i hosts_master_only.cfg install_master_only.yml
```

#### Después el Deployment:
```bash
ansible-playbook -i hosts_deploy_only.cfg install_deploy_only.yml
```

## 📁 Estructura de Archivos

```
doliAdmin/
├── group_vars/all.yml                 # Variables centrales
├── hosts.cfg                          # Inventario completo
├── hosts_master_only.cfg             # Solo master
├── hosts_deploy_only.cfg             # Solo deployment
├── site.yml                          # Instalación completa
├── install_master_only.yml           # Solo master
├── install_deploy_only.yml           # Solo deployment
└── playbooks/
    ├── shared/                        # Configuraciones comunes
    ├── master/                        # Específico del master
    └── deploy/                        # Específico del deployment
```

## 🔧 Después de la Instalación

### Accesos Principales

**Master Server:**
- Panel Admin: `https://admin.tudominio.com`
- Portal Cliente: `https://myaccount.tudominio.com`
- SSH: `ssh admin@192.168.1.2 -p 2222`

**Deployment Server:**
- SSH: `ssh admin@192.168.1.3 -p 2222`
- Instancias: `https://cliente.instancias.com`

### Crear Primera Instancia

En el servidor deployment:
```bash
# Conectarse al deployment
ssh admin@192.168.1.3 -p 2222

# Crear instancia de prueba
sudo /var/www/scripts/create_instance.sh cliente001 cliente001.instancias.com instance_cliente001
```

### Gestión de Instancias

```bash
# Crear instancia
/var/www/scripts/create_instance.sh [nombre] [dominio] [bd_nombre]

# Eliminar instancia  
/var/www/scripts/delete_instance.sh [nombre] [dominio]

# Gestionar Virtual Host
/var/www/scripts/manage_vhost.sh {create|delete} [nombre] [dominio]
```

## 📊 Monitoreo y Logs

### Logs Importantes

**Master:**
- Monitoreo: `/var/log/service_monitor.log`
- Backups: `/var/log/backup.log`
- Apache: `/var/log/apache2/`

**Deployment:**
- Monitoreo: `/var/log/service_monitor_deploy.log`
- Instancias: `/var/log/instances_monitor.log`
- Creación: `/var/log/instance_creation.log`

### Scripts de Monitoreo

Los scripts se ejecutan automáticamente vía cron:
- **Master**: Monitoreo cada 5 min, backup diario 2:00 AM
- **Deployment**: Monitoreo cada 3 min, verificación instancias cada 10 min

## 🔒 Seguridad

- **SSH**: Puerto cambiado a 2222, solo acceso por clave
- **Fail2ban**: Protección automática contra ataques
- **SSL**: Certificados automáticos con Let's Encrypt
- **Firewall**: Solo puertos necesarios abiertos
- **Backups**: Automáticos y cifrados

## 🆘 Resolución de Problemas

### Antes de Instalar
```bash
# Si fallan las verificaciones previas
ansible-playbook -i hosts.cfg pre_install_check.yml

# Verificar conectividad manual
ssh admin@192.168.1.2 -p 2222
ssh admin@192.168.1.3 -p 2222
```

### Verificar Estado de Servicios

**Master:**
```bash
systemctl status apache2 mariadb fail2ban nfs-kernel-server
```

**Deployment:**
```bash
systemctl status apache2 fail2ban
```

### Verificar Conectividad

```bash
# Desde deployment, probar conexión con master
ping 192.168.1.2
mysql -h192.168.1.2 -usellyoursaas -p -e "SELECT 1"
```

### Verificar NFS

```bash
# En deployment, verificar montaje NFS
mount | grep nfs
ls -la /var/www/nfs_backup/
```

### Logs de Errores

```bash
# Ver logs de Ansible durante instalación
ansible-playbook -i hosts.cfg site.yml -vvv

# Ver logs del sistema
journalctl -f
tail -f /var/log/apache2/error.log
```

## 📞 Soporte

- **Documentación**: Ver carpeta `documentation/`
- **Logs**: Revisar `/var/log/` en ambos servidores
- **Email**: Las alertas se envían al email configurado
- **Archivo resumen**: Se genera `INSTALACION_COMPLETADA.md` después de instalar

---

## ⚡ Comandos Rápidos

```bash
# 1. VERIFICAR ANTES DE INSTALAR (OBLIGATORIO)
ansible-playbook -i hosts.cfg pre_install_check.yml

# 2. INSTALACIONES
# Instalación completa
ansible-playbook -i hosts.cfg site.yml

# Solo master
ansible-playbook -i hosts_master_only.cfg install_master_only.yml

# Solo deployment
ansible-playbook -i hosts_deploy_only.cfg install_deploy_only.yml

# 3. VALIDAR DESPUÉS DE INSTALAR
ansible-playbook -i hosts.cfg validate_installation.yml

# 4. VERIFICACIONES
# Verificar sintaxis
ansible-playbook --syntax-check -i hosts.cfg site.yml

# Modo dry-run (sin cambios)
ansible-playbook --check -i hosts.cfg site.yml

# Verbose (más información)
ansible-playbook -i hosts.cfg site.yml -vvv
```
