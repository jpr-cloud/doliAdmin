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
ansible-playbook -e 'target=master'install_master_only.yml -v

## Si quieres ejecutar algún playbook en específico, haz lo siguiente
ansible-playbook -e 'target=master' playbooks/shared/spam_clam_config.yml -v
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

El siguiente paso no se si debemos hacerlo, lo pongo por si se necesita después.

```mysql
SET PASSWORD FOR 'root'@'localhost' = PASSWORD('p123p123');
-- For some old versions of mariadb, you may also need to do:
-- UPDATE mysql.user SET authentication_string = PASSWORD('mysqlrootpassword') WHERE user='root';

FLUSH PRIVILEGES;
```

> Secure the root account

```mysql
-- For MariaDb: The plugin is unix_socket and is set by default on Ubuntu OS. Así que no se necesita
-- INSTALL PLUGIN auth_socket SONAME 'auth_socket.so';
SELECT PLUGIN_NAME, PLUGIN_STATUS FROM INFORMATION_SCHEMA.PLUGINS;

ALTER USER 'root'@'localhost' IDENTIFIED BY 'p123p123';

```

Create a user sellyoursaas to control databases of user instances
On the Master server and on each Deployment server, grant access localy to the login sellyoursaas:

```mysql
CREATE USER 'sellyoursaas'@'localhost' IDENTIFIED BY 'p123p123';

GRANT CREATE USER, GRANT OPTION, RELOAD, LOCK TABLES, REPLICATION CLIENT ON *.* TO 'sellyoursaas'@'localhost';

GRANT CREATE, CREATE TEMPORARY TABLES, CREATE VIEW, DROP, DELETE, INSERT, SELECT, UPDATE, ALTER, INDEX, REFERENCES, SHOW VIEW ON *.* TO 'sellyoursaas'@'localhost';

FLUSH PRIVILEGES;

```

Give permission, on the Master server, to the account sellyoursaas for each deployment server, on the database dolibarr (so the mysql client on the deployment server can connect to the database):

```mysql
-- (password is the one into /etc/sellyoursaas.conf of the deployment server)
CREATE USER 'sellyoursaas'@'192.168.178.3' IDENTIFIED BY 'p123p123';
GRANT CREATE TEMPORARY TABLES, DELETE, INSERT, SELECT, UPDATE ON sellyoursaas.* TO 'sellyoursaas'@'92.168.178.3';

FLUSH PRIVILEGES;
```

`git clone https://github.com/jpr-cloud/doliAdmin.git`

### Configuraciones manuales

Una vez configurado el servidor master, hay que ejecutar un par de tareas manualmente, las cuales son:

- [ ] name: "FASE 2.5: Configuración MariaDB en Master"
- [ ] name: "FASE 2.7: Configuración SSL/Certbot en Master"
- [ ] name: "FASE 18: Configuración Geoip2"
- [ ] name: "FASE 19: Usuario personal sysadmin
- [ ] [FALTA] Deploy the public key of master admin on deployment admin account