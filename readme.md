# Readme

## Requisitos

- Ubuntu 24 (Ubuntu 22 para abajo no está soportado)
- Ansible `apt install ansible`
- Par de llaves importadas en cada servidor a implementar.

## Instalación del servidor master

Lo sisguientes comandos se pueden ejecutar desde una máquina externa.

```bash
# Clonar este repositorio
git clone https://github.com/jpr-cloud/doliAdmin.git
```

Ajustar los valores en `group_vars/all.yml` y en `hosts.cfg`

```bash
# Instalación del servidor master
ansible-playbook -e 'target=master scope=master' install_master_only.yml -v

## Si quieres ejecutar algún playbook en específico, haz lo siguiente
ansible-playbook -e 'target=master scope=master' playbooks/shared/ufw.yml -v
ansible-playbook -e 'target=deploy scope=deploy' playbooks/shared/ufw.yml -v
```

```bash
# Instalación del servidor deploy
ansible-playbook -e 'target=deploy scope=deploy' install_deploy_only.yml -v

```

### Configurar mariaDB

```bash
# Instalación del servidor master
nano /etc/mysql/mariadb.conf.d/50-server.cnf
# establecer bind-address = 0.0.0.0
bind-address = 0.0.0.0

# reinicara mariadb

systemctl restart mariadb
```

Configurar el usuario y los permisos en la base de datos

```mysql
ALTER USER 'root'@'localhost' IDENTIFIED BY 'ZKym8_B1e87=';

CREATE DATABASE IF NOT EXISTS sellyoursaas;

GRANT CREATE, CREATE TEMPORARY TABLES, CREATE VIEW, DROP, DELETE, INSERT, SELECT, UPDATE, ALTER, INDEX, REFERENCES, SHOW VIEW ON *.* TO sellyoursaas@localhost  IDENTIFIED BY '|2uLBm0}41.I';

GRANT CREATE TEMPORARY TABLES, DELETE, INSERT, SELECT, UPDATE ON sellyoursaas.* TO 'sellyoursaas'@'92.168.178.3' IDENTIFIED BY '|2uLBm0}41.I';
FLUSH PRIVILEGES;
```

### Installation of Geoip2

```bash
mkdir /home/admin/tools/maxmind/ -p
cd /home/admin/tools/maxmind/
wget https://cdn.jsdelivr.net/npm/geolite2-country@1.0.2/GeoLite2-Country.mmdb.gz
gunzip GeoLite2-Country.mmdb.gz 

```

`git clone https://github.com/jpr-cloud/doliAdmin.git`

### Configuraciones manuales

Una vez configurado el servidor master, hay que ejecutar un par de tareas manualmente, las cuales son:

- [ ] name: "FASE 2.5: Configuración MariaDB en Master"
- [ ] name: "FASE 2.7: Configuración SSL/Certbot en Master"
- [ ] name: "FASE 18: Configuración Geoip2"
- [ ] name: "FASE 19: Usuario personal sysadmin
- [ ] [FALTA] Deploy the public key of master admin on deployment admin account
