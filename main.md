# Archivos

## master

- [X] hostname del **master** (Se asigna en hetzner al crear el host)
- [X] Asígnación del nombre **master.j-cloud.mx** en DNS Hetzner
- [ ] /etc/hosts (revisar después de la re instalación)
- [ ] SSH and sudo
- [ ] `adduser myunixlogin`
- [ ] default shell `ln -fs /bin/bash /usr/bin/sh`
- [ ] Fix permission on `/etc/ssh/sshd_config` `chmod go-rw /etc/ssh/sshd_config`
- [ ] create `/etc/ssh/sshd_config.d/sellyoursaas.conf`
- [ ] edit `/etc/ssh/sshd_config`
- [ ] reiniciar `systemctl restart sshd`
- [ ] editar `/etc/sudoers`
- [ ] cerear `/etc/sudoers.d/myunixlogin`
- [ ] establecer permisos `chmod a-w /etc/sudoers.d/myunixlogin` `chmod o-r /etc/sudoers.d/myunixlogin`
- [ ] Define or redefine the password for root, admin. `passwd root` `passwd admin`
- [] [Para producción](https://github.com/DoliCloud/SellYourSaas/blob/master/doc/Documentation%20SellYourSaas%20-%20Master%20and%20Deployment%20Servers%20-%20EN.asciidoc#deletion-of-information-files-at-login)
- [ ] Creation of working directories (BOITH)
- [ ] Getting files of Dolibarr and SellYourSaas application
- [ ] Creation of sellyoursaas.conf with credentials `chown root.admin /etc/sellyoursaas.conf && chmod g-wx /etc/sellyoursaas.conf&& chmod o-rwx /etc/sellyoursaas.conf`
- [ ] Create a file `/etc/sellyoursaas-public.conf`

### Installing the nfs share

- [ ] `mkdir -p /home/admin/wwwroot/dolibarr_documents/sellyoursaas/spam`
- [ ] `chown -R admin. dolibarr_documents`
- [ ] `sudo apt -y install nfs-kernel-server`
- [ ] Editar `/etc/exports`
- [ ] `/etc/default/nfs-kernel-server` comment out this line: `RPCMOUNTDOPTS=--manage-gids`, add this instead: `RPCMOUNTDOPTS="--port 33333 --no-nfs-version 3"`
- [ ] `systemctl restart nfs-config  && systemctl restart nfs-kernel-server && rpcinfo -p`
- [ ] Validar los cambios en NFS

### más

- [ ] Installation of packages (both)
- [ ] `apt remove unattended-upgrades`
- [ ] modify `/etc/login.defs`
- [ ] modify `/etc/apache2/conf-enabled/security.conf`

**Apache web server configuration**

- [ ] habilitar los módulos `a2enmod actions alias asis auth_basic auth_digest authn_anon authn_dbd authn_dbm authn_file authz_dbm authz_groupfile authz_host authz_owner authz_user autoindex cache cgid cgi charset_lite dav_fs dav dav_lock dbd deflate dir dump_io env expires ext_filter file_cache filter headers http2 ident include info ldap mem_cache mime mime_magic negotiation reqtimeout rewrite setenvif speling ssl status substitute suexec unique_id userdir usertrack vhost_alias mpm_itk mpm_prefork php7.4`

- [ ] Enable apache configurations to work with MPM_PREFORK and MPM_ITK: `a2enconf charset localized-error-pages other-vhosts-access-log security`
- [ ] Create the file `/etc/apache2/.htpasswd` con el siguiente comando `htpasswd -cm /etc/apache2/.htpasswd admin`

**Installation of unix watchdog (optional)**

- [ ] `ln -fs /home/admin/wwwroot/dolibarr_sellyoursaas/scripts/repair.ksh /usr/sbin/repair`
- [ ] `systemctl enable watchdog && systemctl start watchdog`

### Installation of fail2ban 

- [ ] create a `/etc/fail2ban/jail.local` file with this content
- [ ] fail2ban (deploy) all servers
- [ ] fail2ban (master)
- [ ] `grep logpath /etc/fail2ban/jail.local | cut -d= -f2 | grep '^ /'|sort|uniq|xargs touch`
- [ ] create the logfiles 
- [ ] Relaunch fail2ban with `systemctl start fail2ban && systemctl status fail2ban` and check errors into `/var/log/fail2ban.log`

**Test spamassassin**

- [ ]  (create a file /tmp/testspam)[https://github.com/DoliCloud/SellYourSaas/blob/master/doc/Documentation%20SellYourSaas%20-%20Master%20and%20Deployment%20Servers%20-%20EN.asciidoc#test-spamassassin]
- [ ] (Test and setup of ClamAV) [https://github.com/DoliCloud/SellYourSaas/blob/master/doc/Documentation%20SellYourSaas%20-%20Master%20and%20Deployment%20Servers%20-%20EN.asciidoc#test-and-setup-of-clamav]


**Installation of Afick**

- [ ] Install afick.pl tool from the debian package found on afick web site. `wget -O afick.deb https://sourceforge.net/projects/afick/files/afick/3.7.0/afick_3.7.0-1ubuntu_all.deb/download && dpkg -i afick.deb`
- [ ] Edit  /etc/afick.conf

### Setup mariadb (galera and MaxScale)

- [ ] Agustar el service
- [ ] crear password para root `UPDATE mysql.user SET authentication_string = PASSWORD('p123p123') WHERE User='root'; FLUSH PRIVILEGES;`
- [ ] Create a user sellyoursaas to control databases of user instances
- [ ] Create galera main node

**MAXscale**

- [ ] Download `wget https://dlm.mariadb.com/3310075/MaxScale/22.08.7/packages/ubuntu/focal/x86_64/maxscale-22.08.7-1.ubuntu.focal.x86_64.deb`
- [ ] Installing MariaDB MaxScale
- [ ] addin maxscale user
- [ ] configuring `/etc/maxscale.cnf`

### Setup of PHP

- [ ] Setting permissons 

```bash
chmod -Rv 733 /dev/shm /var/lib/php/sessions
chmod +t /dev/shm /var/lib/php/sessions
```

- [ ] Define size of upload and session options
- [ ] Disable some functions (optionnal)
- [ ] Add a wrapper PHP for the mail() function

### Setup of logrotate

- [ ] Edit `/etc/logrotate.conf`
- [ ] Modify the `/etc/logrotate.d/apache2`
- [ ] Create a file `/etc/logrotate.d/logrotate_admin_log`
- [ ] Create a file `/etc/logrotate.d/logrotate_sellyoursaas_log`

### Setup of journalctl

### Install certbot (for LetsEncrypt SSL certificates)

- [ ] Edit the file `/etc/systemd/journald.conf` to define the max size for systemd journals.

### Install certbot (for LetsEncrypt SSL certificates)

- [ ] install snapd `apt install snapd -y`
- [ ] Install certbot `snap install --classic certbot`
- [ ] Prepare the Certbot command `ln -s /snap/bin/certbot /usr/bin/certbot`

### Installation of Cron tasks

- [ ] user root
- [ ] user admin

### Installation of Dolibarr framework

- [ ] Create a symbolic link called sellyoursaas `sudo -u admin ln -fs /home/admin/wwwroot/dolibarr_sellyoursaas /home/admin/wwwroot/dolibarr/htdocs/custom/sellyoursaas`
- [ ] Create a symbolic link called source into directory myaccount `sudo -u admin ln -fs /home/admin/wwwroot/dolibarr/htdocs /home/admin/wwwroot/dolibarr/htdocs/custom/sellyoursaas/myaccount/source`
- [ ] Create a symbolic link called master.inc.php into directory myaccount  `sudo -u admin ln -fs /home/admin/wwwroot/dolibarr/htdocs/master.inc.php /home/admin/wwwroot/dolibarr/htdocs/custom/sellyoursaas/myaccount`
- [ ] Disable default `a2dissite 000-default`
- [ ] Enable the site `a2ensite admin.j-cloud.mx`
- [ ] Enable the site `a2ensite myaccount.j-cloud.mx`
- [ ] Create certificate for admin and myaccount using `certbot --apache`
- [ ] Restart apache `systemctl restart apache2`


## deploy

- [ ] hostname **deploy** (Se asigna en hetzner al crear el host)
- [ ] /etc/hosts
- [ ] Asígnación del nombre master.j-cloud.mx en DNS Hetzner

### NFS  /mnt/diskhome

- [ ] mkdir `/mnt/diskhome`
- [ ] mkdir `/mnt/diskbackup`
- [ ] Leer las instrucciones de como montar el volúmen desde hetzner


- [ ] SSH and sudo
- [ ] `adduser myunixlogin`
- [ ] default shell `ln -fs /bin/bash /usr/bin/sh`
- [ ] Fix permission on `/etc/ssh/sshd_config` `chmod go-rw /etc/ssh/sshd_config`
- [ ] create `/etc/ssh/sshd_config.d/sellyoursaas.conf`
- [ ] edit `/etc/ssh/sshd_config`
- [ ] reiniciar `systemctl restart sshd`
- [ ] Copiar id_rsa* de main a deploy
- [ ] Agregar el contenido de id_rsa.pub de root y admin en el archivo `authorized_key`s en deploy
- [ ] ¿Te puedes conectar desde admin a deploy usando `ssh admin@192.168.1.3` y ssh `root@192.168.1.3`?
- [ ] editar `/etc/sudoers`
- [ ] Create a file `/etc/sudoers.d/myunixlogin`
- [ ] establecer permisos `chmod a-w /etc/sudoers.d/myunixlogin && chmod o-r /etc/sudoers.d/myunixlogin`
- [ ] Define or redefine the password for root, admin. `passwd root` `passwd admin`
- [ ] [Para producción](https://github.com/DoliCloud/SellYourSaas/blob/master/doc/Documentation%20SellYourSaas%20-%20Master%20and%20Deployment%20Servers%20-%20EN.asciidoc#deletion-of-information-files-at-login)


### Modification of `/etc/skel`

- [ ] `mkdir /etc/skel/.ssh`
- [ ] crear **authorized_keys_support** `sudo touch /etc/skel/.ssh/authorized_keys_support`
- [ ] `sudo chmod -R go-rwx /etc/skel/.ssh`
- [ ] Agregar las id_rsa.pub de admin y root en `nano /etc/skel/.ssh/authorized_keys_support`
- [ ] `mkdir /etc/skel/.ssh`
- [ ] `printf '[client]\nprotocol=tcp\n' >> /etc/skel/.my.cnf`

- [ ] Add at the end of **/etc/bash.bashrc**  `alias psld='ps -fax -eo user:12,pid,ppid,pcpu,pmem,vsz:12,size:12,tty,start_time:6,utime,time,context,cmd'`

### Creation of working directories

- [ ] `mkdir /mnt/diskbackup/backup`
- [ ] Create directory `/mnt/diskbackup/backup` usando `mkdir /mnt/diskhome/backup && chown admin /mnt/diskhome/backup && ln -fs /mnt/diskhome/backup /mnt/diskbackup/backup`

- [ ] Create the other directories on the deployment server

```bash
mkdir /home/jail; mkdir /mnt/diskhome/home;

mkdir /mnt/diskbackup/archives-test; mkdir /mnt/diskbackup/archives-paid
mkdir -p /home/admin/wwwroot/dolibarr_documents/sellyoursaas/spam;
chown admin.root /mnt/diskbackup/backup /mnt/diskbackup/archives-test /mnt/diskbackup/archives-paid
ln -fs /mnt/diskhome/home /home/jail/home
ln -fs /mnt/diskbackup/backup /home/jail/backup
ln -fs /mnt/diskbackup/archives-test /home/jail/archives-test
ln -fs /mnt/diskbackup/archives-paid /home/jail/archives-paid
```

### Getting files of Dolibarr and SellYourSaas application

- [ ] **Under the admin account** `cd /home/admin/wwwroot && git clone https://github.com/Dolibarr/dolibarr dolibarr --branch 17.0.1 && chown -R admin.admin /home/admin/wwwroot/dolibarr`
- [ ] **Under the admin account install the sources of SellYourSaas**: `cd /home/admin/wwwroot && git clone https://github.com/dolicloud/sellyoursaas dolibarr_sellyoursaas`
- [ ] Creation of sellyoursaas.conf with credentials `touch /etc/sellyoursaas.conf && chown root.admin /etc/sellyoursaas.conf && chmod g-wx /etc/sellyoursaas.conf&& chmod o-rwx /etc/sellyoursaas.conf`
- [ ] Create a file `/etc/sellyoursaas-public.conf`

> CUIADO: Se debe de crear la base de datos, 
> `CREATE USER 'sellyoursaas'@'ip.server.deployment' IDENTIFIED BY 'p123p123';`
> `GRANT CREATE TEMPORARY TABLES, DELETE, INSERT, SELECT, UPDATE ON nom_de_base_dolibarr_master.* TO 'sellyoursaas'@'%';`
> `FLUSH PRIVILEGES`;

- [ ] Create also an empty directory: `mkdir -p /etc/sellyoursaas.d`

### NFS - Installing the nfs share

- [ ] `sudo apt install nfs-common -y`
- [ ] `sudo mount -t nfs 192.168.1.2:/home/admin/wwwroot/dolibarr_documents/sellyoursaas /home/admin/wwwroot/dolibarr_documents/sellyoursaas`
- [ ] `umount /home/admin/wwwroot/dolibarr_documents/sellyoursaas`
- [ ] Add the line to the /etc/fstab file to have automatic reboot mounting`192.168.1.2:/home/admin/wwwroot/dolibarr_documents/sellyoursaas /home/admin/wwwroot/dolibarr_documents/sellyoursaas  nfs  defaults 0 0`
- [ ] `mount -a`

### Deploy the public key of master admin on deployment admin account

- [ ] On the deployment servers, copy the public and private key of the master’s ssh admin account to /home/admin/.ssh/id_rsa_sellyoursaa
- [ ] Create and edit `/home/admin/.ssh/config`

### Installation of system and application components (dep)

- [ ] Installation of packages (both)
- [ ] Disabling automatic update `sudo apt remove -y unattended-upgrades`
- [ ] modify `/etc/login.defs`
- [ ] modify `/etc/apache2/conf-enabled/security.conf`

### DNS On deployment servers

- [ ] Create a file `/etc/bind/a1.j-cloud.mx.hosts`

### Apache web server configuration

- [ ] habilitar los módulos `a2enmod actions alias asis auth_basic auth_digest authn_anon authn_dbd authn_dbm authn_file authz_dbm authz_groupfile authz_host authz_owner authz_user autoindex cache cgid cgi charset_lite dav_fs dav dav_lock dbd deflate dir dump_io env expires ext_filter file_cache filter headers http2 ident include info ldap mem_cache mime mime_magic negotiation reqtimeout rewrite setenvif speling ssl status substitute suexec unique_id userdir usertrack vhost_alias mpm_itk mpm_prefork php7.4`
- [ ] Enable apache configurations to work with MPM_PREFORK and MPM_ITK: `a2enconf charset localized-error-pages other-vhosts-access-log security`
- [ ] Create the directory of the configuration files of the virtual hosts of the instances. `cd /etc/apache2 && mkdir sellyoursaas-available sellyoursaas-online sellyoursaas-offline && ln -fs /etc/apache2/sellyoursaas-online /etc/apache2/sellyoursaas-enabled`
- [ ] Add the directive to take into account the directory for the virtual hosts of the user instances in the config `/etc/apache2/apache2.conf`
- [ ] Add directives to define the default error log in `/etc/apache2/conf-enabled/other-vhosts-access-log.conf`

- [ ] reiniciar apache `systemctl restart apache2`
- [ ] Add the directive to take into account the directory for the virtual hosts of the user instances in the config `/etc/apache2/apache2.conf`
- [ ] Add directives to define the default error log in `/etc/apache2/conf-enabled/other-vhosts-access-log.conf`

**Installation of unix watchdog (optional)**

- [ ] `ln -fs /home/admin/wwwroot/dolibarr_sellyoursaas/scripts/repair.ksh /usr/sbin/repair`
- [ ] `systemctl enable watchdog && systemctl start watchdog`
- [ ] Installation of the instance deployment agent

### Installation of the Apache watchdog

- [ ] [Leer](https://github.com/DoliCloud/SellYourSaas/blob/master/doc/Documentation%20SellYourSaas%20-%20Master%20and%20Deployment%20Servers%20-%20EN.asciidoc#installation-of-the-instance-deployment-agent)

### Installation of the instance deployment agent

- [ ] Agent installation and activation in `/home/admin/wwwroot/dolibarr_sellyoursaas/scripts/remote_server_launcher.sh` by creating a link `ln -fs /home/admin/wwwroot/dolibarr_sellyoursaas/scripts/remote_server_launcher.sh /etc/init.d/remote_server_launcher`
- [ ] To use systemd create a file `/etc/systemd/system/remote-server-launcher.service`
- [ ] Verificar `systemctl daemon-reload && systemctl enable remote_server_launcher && systemctl is-enabled remote_server_launcher && systemctl status remote_server_launcher`
- [ ] Activate the service `systemctl enable remote-server-launcher.service && systemctl start remote-server-launcher.service && systemctl status remote-server-launcher.service && systemctl stop remote-server-launcher.service`

### Installation of fail2ban

- [ ] create a `/etc/fail2ban/jail.local` file with this content
- [ ] fail2ban (deploy)
- [ ] fail2ban (deploy) all servers
- [ ] `grep logpath /etc/fail2ban/jail.local | cut -d= -f2 | grep '^ /'|sort|uniq|xargs touch`
- [ ] Relaunch fail2ban and check errors into /var/log/fail2ban.log
- [ ] create the logfiles como root `touch /var/log/phpmail.log && touch /var/log/phpsendmail.log && touch /var/log/daemon.log`

- [ ] create the logfiles como admin
`touch /home/admin/wwwroot/dolibarr_documents/dolibarr_register.log && touch /home/admin/wwwroot/dolibarr_documents/dolibarr.log`

- [ ] Relaunch fail2ban with `systemctl start fail2ban && systemctl status fail2ban` and check errors into `/var/log/fail2ban.log`

### Add a wrapper PHP for the mail() function

echo >> /home/admin/wwwroot/dolibarr_documents/sellyoursaas/spam/blacklistmail;
echo >> /home/admin/wwwroot/dolibarr_documents/sellyoursaas/spam/blacklistip;
echo >> /home/admin/wwwroot/dolibarr_documents/sellyoursaas/spam/blacklistfrom;
echo >> /home/admin/wwwroot/dolibarr_documents/sellyoursaas/spam/blacklistcontent;

- [ ] Modify the file php.ini (the one for apache and the one for cli) with:
- [ ] Create the files phpmail.log and phpsendmail.log:
- [ ] Create a directory for blacklist files used by phpsendmail.php

### Setup of logrotate dep

- [ ] `root syslog` to `/etc/logrotate.conf`
- [ ] `Modify the /etc/logrotate.d/apache2` rotate 365
- [ ] Create a file /etc/logrotate.d/logrotate_admin_log
- [ ] Create a file /etc/logrotate.d/logrotate_sellyoursaas_log

### Setup of journalctl 2

- [ ] Edit the file `/etc/systemd/journald.conf` to define the max size for systemd journals.
- [ ] restart the service `systemctl start systemd-journald`

### Let¿s encrypt 2

- [ ] Install certbot (for LetsEncrypt SSL certificates) `sudo apt install -y snapd && sudo snap install --classic certbot && sudo ln -fs /snap/bin/certbot /usr/bin/certbot`

#### Create a wildcard SSL certificate for user instances

[how-to-create-let-s-encrypt-wildcard-certificates-with-certbot](https://www.digitalocean.com/community/tutorials/how-to-create-let-s-encrypt-wildcard-certificates-with-certbot)

- [ ] En DNS Hetzner, crear el host wildcard *.a1.j-cloud.mx, apuntando al servidor deployment

### Installation of Cron tasks On deployment servers

- [ ] Terminado

## cron master and deployment root

You must have inside the cron of user root

- [ ] hecho
```bash
# 47 2 ** */root/certbot-auto renew --no-self-upgrade > /var/log/letsencrypt/certbot-auto_renew.log 2>&1
10 0* ** /home/admin/wwwroot/dolibarr/htdocs/custom/sellyoursaas/scripts/backup_mysql_system.sh confirm >/home/admin/logs/backup_mysql_system.log 2>&1
00 4 ** */home/admin/wwwroot/dolibarr/htdocs/custom/sellyoursaas/scripts/perms.ksh >/home/admin/logs/perms.log
40 15* ** /home/admin/wwwroot/dolibarr/htdocs/custom/sellyoursaas/scripts/backup_backups.sh confirm none --delete >/home/admin/logs/backup_backups.log 2>&1
00 9 ** */home/admin/wwwroot/dolibarr/htdocs/custom/sellyoursaas/scripts/batch_detect_evil_instances.php test 86400 > /home/admin/logs/batch_detect_evil_instances.log 2>&1
# 40 4 4 * * /home/admin/wwwroot/dolibarr/htdocs/custom/sellyoursaas/scripts/clean.sh confirm
```

### Installation of Dolibarr framework

- [ ] Comop admin `ln -fs /home/admin/wwwroot/dolibarr_sellyoursaas /home/admin/wwwroot/dolibarr/htdocs/custom/sellyoursaas`
- [ ] Comop admin `ln -fs /home/admin/wwwroot/dolibarr/htdocs /home/admin/wwwroot/dolibarr/htdocs/custom/sellyoursaas/myaccount/source`
- [ ] Comop admin `ln -fs /home/admin/wwwroot/dolibarr/htdocs/master.inc.php /home/admin/wwwroot/dolibarr/htdocs/custom/sellyoursaas/myaccount`
- [ ] Create a file `/home/admin/wwwroot/dolibarr/htdocs/conf/conf.php`

### Installation of Geoip2

- [ ] `mkdir /home/admin/tools/maxmind/ -p && cd /home/admin/tools/maxmind/`
- [ ] `wget https://cdn.jsdelivr.net/npm/geolite2-country@1.0.2/GeoLite2-Country.mmdb.gz`
- [ ] `gunzip GeoLite2-Country.mmdb.gz`
- [ ] `chmod -R o-w /home/admin/tools/maxmind`

### Installation or update of plugin SellYourSaas


**Test spamassassin**

- [ ]  (create a file /tmp/testspam)[https://github.com/DoliCloud/SellYourSaas/blob/master/doc/Documentation%20SellYourSaas%20-%20Master%20and%20Deployment%20Servers%20-%20EN.asciidoc#test-spamassassin]
- [ ] (Test and setup of ClamAV) [https://github.com/DoliCloud/SellYourSaas/blob/master/doc/Documentation%20SellYourSaas%20-%20Master%20and%20Deployment%20Servers%20-%20EN.asciidoc#test-and-setup-of-clamav]

**Installation of Afick**

- [ ] Install afick.pl tool from the debian package found on afick web site. `wget -O afick.deb https://sourceforge.net/projects/afick/files/afick/3.7.0/afick_3.7.0-1ubuntu_all.deb/download && dpkg -i afick.deb`
- [ ] Edit  /etc/afick.conf

### Setup of Mysql or Mariadb

TODO

=============================

## Configuraciones

### SSH and sudo

```bash
groupadd admin; useradd -m -s /usr/bin/bash -g admin admin;
mkdir /home/admin/logs; chown root.admin /home/admin/logs; chmod 770 /home/admin/logs;
mkdir /mnt/diskbackup; chown admin.admin /mnt/diskbackup
mkdir /home/admin/backup; chown admin.admin /home/admin/backup;
mkdir /home/admin/backup/conf; chown admin.admin /home/admin/backup/conf;
mkdir /home/admin/backup/mysql; chown admin.admin /home/admin/backup/mysql;
mkdir /home/admin/wwwroot; chown admin.admin /home/admin/wwwroot
```

### Modification of `/etc/skel`

```bash
sudo mkdir /etc/skel/.ssh
sudo touch /etc/skel/.ssh/authorized_keys_support
sudo chmod -R go-rwx /etc/skel/.ssh
```

Agregar las llaves de admin, root y las de tu computadora en `/etc/skel/.ssh/authorized_keys_support`

### Creation of working directories (BOTH)

```bash
mkdir -p /mnt/{diskbackup,diskhome}/backup && chown admin /mnt/diskhome/backup;
ln -fs /mnt/diskhome/backup /mnt/diskbackup/backup
```

### Creation of working directories (deploy)

```bash
mkdir /home/jail; mkdir /mnt/diskhome/home;

mkdir /mnt/diskbackup/archives-test; mkdir /mnt/diskbackup/archives-paid
mkdir -p /home/admin/wwwroot/dolibarr_documents/sellyoursaas/spam;
chown admin.root /mnt/diskbackup/backup /mnt/diskbackup/archives-test /mnt/diskbackup/archives-paidln -fs /mnt/diskhome/home /home/jail/home
ln -fs /mnt/diskbackup/backup /home/jail/backup
ln -fs /mnt/diskbackup/archives-test /home/jail/archives-test
ln -fs /mnt/diskbackup/archives-paid /home/jail/archives-paid
```

### Getting files of Dolibarr and SellYourSaas application

```bash
cd /home/admin/wwwroot
git clone https://github.com/Dolibarr/dolibarr dolibarr --branch 17.0.1
chown -R admin.admin /home/admin/wwwroot/dolibarr

cd /home/admin/wwwroot
git clone https://github.com/dolicloud/sellyoursaas dolibarr_sellyoursaas
```

### NFS Shares

#### NFS Shares - main

Validar los cambios

```bash
exportfs -v -a #(to validate new entries to add)
exportfs -v -r #(to validate new entries to remove)
exportfs
systemctl enable nfs-kernel-server && systemctl restart nfs-kernel-server && systemctl status nfs-kernel-server
exportfs
```

#### Enabling  the nfs share - deploy

```bash
sudo apt install nfs-common
sudo mount -t nfs 192.168.1.2:/home/admin/wwwroot/dolibarr_documents/sellyoursaas /home/admin/wwwroot/dolibarr_documents/sellyoursaas
sudo umount /home/admin/wwwroot/dolibarr_documents/sellyoursaas
```

### Installation of packages (both)

soffice
# https://askubuntu.com/questions/1031921/php-mcrypt-package-missing-in-ubuntu-server-18-04-lts
# https://www.linuxhelp.com/questions/e-package-php-mcrypt-has-no-installation-candidate-error-on-ubuntu-20-4-1

```bash
sudo apt install -y \
ntp git gzip zip zstd memcached ncdu duc iotop acl ufw sudo \
mariadb-server mariadb-client \
apache2 apache2-bin lynx

sudo apt install -y \
php php-cli libapache2-mod-php php-fpm php-gd \
php-imap php-json php-ldap php-mysql php-curl \
php-memcached php-imagick php-geoip  \
php-intl php-xml php-zip php-bz2 php-ssh2 \
php-mbstring php-soap php-readline php-xmlrpc \
php-pear watchdog cpulimit libapache2-mpm-itk

sudo apt install -y \
libapache2-mod-apparmor apparmor apparmor-profiles \
apparmor-utils rkhunter chkrootkit bind9 \
spamc spamassassin clamdscan clamav-daemon \
fail2ban  libreoffice-common libreoffice-writer \
mailutils postfix

# php-mcrypt
sudo apt install -y php php-pear php-dev libmcrypt-dev
sudo pecl install mcrypt
printf 'extension=mcrypt.so\n' >> /etc/php/7.4/mods-available/mcrypt.ini
phpenmod mcrypt

```

### Create the directory of the configuration files of the virtual hosts of the instances.

cd /etc/apache2
mkdir sellyoursaas-available sellyoursaas-online sellyoursaas-offline
ln -fs /etc/apache2/sellyoursaas-online /etc/apache2/sellyoursaas-enabled

### Installation and activation of the apache watchdogs provided in `/home/admin/wwwroot/dolibarr_sellyoursaas/scripts/`


```bash
ln -fs /home/admin/wwwroot/dolibarr_sellyoursaas/scripts/apache_watchdog_launcher1.sh /etc/init.d/apache_watchdog_launcher1
ln -fs /home/admin/wwwroot/dolibarr_sellyoursaas/scripts/apache_watchdog_launcher2.sh /etc/init.d/apache_watchdog_launcher2
ln -fs /home/admin/wwwroot/dolibarr_sellyoursaas/scripts/apache_watchdog_launcher3.sh /etc/init.d/apache_watchdog_launcher3
ln -fs /home/admin/wwwroot/dolibarr_sellyoursaas/scripts/smtp_watchdog_launcher1.sh /etc/init.d/smtp_watchdog_launcher1
systemctl daemon-reload

systemctl enable apache_watchdog_launcher1;
systemctl is-enabled apache_watchdog_launcher1;
systemctl status apache_watchdog_launcher1;

systemctl enable apache_watchdog_launcher2;
systemctl is-enabled apache_watchdog_launcher2;
systemctl status apache_watchdog_launcher2;

systemctl enable apache_watchdog_launcher3;
systemctl is-enabled apache_watchdog_launcher3;
systemctl status apache_watchdog_launcher3;

systemctl enable smtp_watchdog_launcher1;
systemctl is-enabled smtp_watchdog_launcher1;
systemctl status smtp_watchdog_launcher1;
```

### Agent installation and activation in `/home/admin/wwwroot/dolibarr_sellyoursaas/scripts/remote_server_launcher.sh` by creating a link b

```bash
ln -fs /home/admin/wwwroot/dolibarr_sellyoursaas/scripts/remote_server_launcher.sh /etc/init.d/remote_server_launcher
systemctl daemon-reload
systemctl enable remote_server_launcher
systemctl is-enabled remote_server_launcher
systemctl status remote_server_launcher
```

### fail2ban (deploy)

```bash
cd /etc/fail2ban/filter.d
ln -fs /home/admin/wwwroot/dolibarr_sellyoursaas/etc/fail2ban/filter.d/email-dolibarr-ruleskoblacklist.conf
ln -fs /home/admin/wwwroot/dolibarr_sellyoursaas/etc/fail2ban/filter.d/email-dolibarr-ruleskoquota.conf
ln -fs /home/admin/wwwroot/dolibarr_sellyoursaas/etc/fail2ban/filter.d/email-dolibarr-rulesko.conf
ln -fs /home/admin/wwwroot/dolibarr_sellyoursaas/etc/fail2ban/filter.d/email-dolibarr-rulesall.conf
ln -fs /home/admin/wwwroot/dolibarr_sellyoursaas/etc/fail2ban/filter.d/email-dolibarr-rulesadmin.conf
ln -fs /home/admin/wwwroot/dolibarr_sellyoursaas/etc/fail2ban/filter.d/web-accesslog-limit403.conf
ln -fs /home/admin/wwwroot/dolibarr_sellyoursaas/etc/fail2ban/filter.d/web-dolibarr-rulespassforgotten.conf
ln -fs /home/admin/wwwroot/dolibarr_sellyoursaas/etc/fail2ban/filter.d/web-dolibarr-rulesbruteforce.conf
ln -fs /home/admin/wwwroot/dolibarr_sellyoursaas/etc/fail2ban/filter.d/web-dolibarr-ruleslimitpublic.conf
ln -fs /home/admin/wwwroot/dolibarr_sellyoursaas/etc/fail2ban/filter.d/web-dolibarr-rulesregisterinstance.conf
```

### fail2ban (deploy) all servers

```bash
cd /etc/fail2ban/jail.d
ln -fs /home/admin/wwwroot/dolibarr_sellyoursaas/etc/fail2ban/jail.d/email-dolibarr-ruleskoblacklist.conf
ln -fs /home/admin/wwwroot/dolibarr_sellyoursaas/etc/fail2ban/jail.d/email-dolibarr-ruleskoquota.conf
ln -fs /home/admin/wwwroot/dolibarr_sellyoursaas/etc/fail2ban/jail.d/email-dolibarr-rulesko.conf
ln -fs /home/admin/wwwroot/dolibarr_sellyoursaas/etc/fail2ban/jail.d/email-dolibarr-rulesall.conf
ln -fs /home/admin/wwwroot/dolibarr_sellyoursaas/etc/fail2ban/jail.d/email-dolibarr-rulesadmin.conf
ln -fs /home/admin/wwwroot/dolibarr_sellyoursaas/etc/fail2ban/jail.d/web-accesslog-limit403.conf
```

### fail2ban (master)

```bash
cd /etc/fail2ban/jail.d
ln -fs /home/admin/wwwroot/dolibarr_sellyoursaas/etc/fail2ban/jail.d/web-dolibarr-rulespassforgotten.conf
ln -fs /home/admin/wwwroot/dolibarr_sellyoursaas/etc/fail2ban/jail.d/web-dolibarr-rulesbruteforce.conf
ln -fs /home/admin/wwwroot/dolibarr_sellyoursaas/etc/fail2ban/jail.d/web-dolibarr-ruleslimitpublic.conf
ln -fs /home/admin/wwwroot/dolibarr_sellyoursaas/etc/fail2ban/jail.d/web-dolibarr-rulesregisterinstance.conf

touch /home/admin/wwwroot/dolibarr_documents/dolibarr.log
touch /var/log/phpsendmail.log
touch /home/admin/wwwroot/dolibarr_documents/dolibarr_register.log
touch /var/log/daemon.log

systemctl start fail2ban && systemctl status fail2ban

```

#### Setup of Mysql or Mariadb

TODO

## Setup of DNS server for domains served by the Deployment servers
On deployment servers


