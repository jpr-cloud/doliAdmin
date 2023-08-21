# Archivos

## master

- [ ] hostname del **main** (Se asigna en hetzner al crear el host)
- [ ] Asígnación del nombre main.jpyrsa.com.mx en DNS Hetzner
- [ ] /etc/hosts (revisar después de la re instalación)
- [ ] SSH and sudo
- [ ] `adduser myunixlogin`
- [ ] default shell `ln -fs /bin/bash /usr/bin/sh`
- [ ] Fix permission on `/etc/ssh/sshd_config` `chmod go-rw /etc/ssh/sshd_config`
- [ ] create `/etc/ssh/sshd_config.d/sellyoursaas.conf`
- [ ] edit `/etc/ssh/sshd_config`
- [ ] reiniciar `systemtl restart sshd`
- [ ] editar `/etc/sudoers`
- [ ] cerear `/etc/sudoers.d/myunixlogin`
- [ ] establecer permisos `chmod a-w /etc/sudoers.d/myunixlogin` `chmod o-r /etc/sudoers.d/myunixlogin`
- [ ] Define or redefine the password for root, admin. `passwd root` `passwd admin`
- [ ] [Para producción](https://github.com/DoliCloud/SellYourSaas/blob/master/doc/Documentation%20SellYourSaas%20-%20Master%20and%20Deployment%20Servers%20-%20EN.asciidoc#deletion-of-information-files-at-login)
- [ ] Creation of working directories (BOITH)
- [ ] Creation of working directories (deploy)
- [ ] Getting files of Dolibarr and SellYourSaas application
- [ ] Creation of sellyoursaas.conf with credentials `chown root.admin /etc/sellyoursaas.conf && chmod g-wx /etc/sellyoursaas.conf&& chmod o-rwx /etc/sellyoursaas.conf`
- [ ] Create a file `/etc/sellyoursaas-public.conf`

### Installing the nfs share

- [ ] `sudo apt install nfs-kernel-server`
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
- [ ] Create the directory of the configuration files of the virtual hosts of the instances.
- [ ] Create the file `/etc/apache2/.htpasswd` con el siguiente comando `htpasswd -cm /etc/apache2/.htpasswd admin`
- [ ]
- [ ]
- [ ]
- [ ]
- [ ]


### Installation of fail2ban 

- [ ] create a `/etc/fail2ban/jail.local` file with this content
- [ ] fail2ban (deploy) all servers
- [ ] fail2ban (master)
- [ ] `grep logpath /etc/fail2ban/jail.local | cut -d= -f2 | grep '^ /'|sort|uniq|xargs touch`
- [ ] Relaunch fail2ban with `systemctl status fail2ban` and check errors into `/var/log/fail2ban.log`  


## deploy

- [ ] hostname **deploy** (Se asigna en hetzner al crear el host)
- [ ] /etc/hosts
- [ ] Asígnación del nombre main.jpyrsa.com.mx en DNS Hetzner
- [ ] SSH and sudo
- [ ] `adduser myunixlogin`
- [ ] default shell `ln -fs /bin/bash /usr/bin/sh`
- [ ] Fix permission on `/etc/ssh/sshd_config` `chmod go-rw /etc/ssh/sshd_config`
- [ ] create `/etc/ssh/sshd_config.d/sellyoursaas.conf`
- [ ] edit `/etc/ssh/sshd_config`
- [ ] reiniciar `systemtl restart sshd`
- [ ] editar `/etc/sudoers`
- [ ] establecer permisos `chmod a-w /etc/sudoers.d/myunixlogin` `chmod o-r /etc/sudoers.d/myunixlogin`
- [ ] Define or redefine the password for root, admin. `passwd root` `passwd admin`
- [ ] [Para producción](https://github.com/DoliCloud/SellYourSaas/blob/master/doc/Documentation%20SellYourSaas%20-%20Master%20and%20Deployment%20Servers%20-%20EN.asciidoc#deletion-of-information-files-at-login)
- [ ] Modification of `/etc/skel`
- [ ] Add at the end of **/etc/bash.bashrc**  `alias psld='ps -fax -eo user:12,pid,ppid,pcpu,pmem,vsz:12,size:12,tty,start_time:6,utime,time,context,cmd'`
- [ ] Creation of working directories (BOTH)
- [ ] Creation of working directories (deploy)
- [ ] Getting files of Dolibarr and SellYourSaas application
- [ ] Creation of sellyoursaas.conf with credentials `chown root.admin /etc/sellyoursaas.conf && chmod g-wx /etc/sellyoursaas.conf&& chmod o-rwx /etc/sellyoursaas.conf`
- [ ] Create a file `/etc/sellyoursaas-public.conf`

### NFS

- [ ] Enabling  the nfs share - deploy
- [ ] `mount -a`

### Deploy the public key of master admin on deployment admin account

- [ ] On the deployment servers, copy the public and private key of the master’s ssh admin account to /home/admin/.ssh/id_rsa_sellyoursaa

### continuamos

- [ ] Installation of packages (both)
- [ ] `apt remove unattended-upgrades`
- [ ] modify `/etc/login.defs`
- [ ] modify `/etc/apache2/conf-enabled/security.conf`

**Apache web server configuration**

- [ ] habilitar los módulos `a2enmod actions alias asis auth_basic auth_digest authn_anon authn_dbd authn_dbm authn_file authz_dbm authz_groupfile authz_host authz_owner authz_user autoindex cache cgid cgi charset_lite dav_fs dav dav_lock dbd deflate dir dump_io env expires ext_filter file_cache filter headers http2 ident include info ldap mem_cache mime mime_magic negotiation reqtimeout rewrite setenvif speling ssl status substitute suexec unique_id userdir usertrack vhost_alias mpm_itk mpm_prefork php7.4`

- [ ] Enable apache configurations to work with MPM_PREFORK and MPM_ITK: `a2enconf charset localized-error-pages other-vhosts-access-log security`
- [ ] Create the directory of the configuration files of the virtual hosts of the instances. `cd /etc/apache2 && mkdir sellyoursaas-available sellyoursaas-online sellyoursaas-offline && ln -fs /etc/apache2/sellyoursaas-online /etc/apache2/sellyoursaas-enabled`
- [ ] `ln -fs /etc/apache2/sellyoursaas-online /etc/apache2/sellyoursaas-enabled`
- [ ] reiniciar apache systemctl `restart apache2`
- [ ] Add the directive to take into account the directory for the virtual hosts of the user instances in the config `/etc/apache2/apache2.conf`
- [ ] Add directives to define the default error log in `/etc/apache2/conf-enabled/other-vhosts-access-log.conf`

### Installation of the Apache watchdog (deploy)

- [ ] Installation of the Apache watchdog (deploy)

### Installation of the instance deployment agent

- [ ] Agent installation and activation in `/home/admin/wwwroot/dolibarr_sellyoursaas/scripts/remote_server_launcher.sh` by creating a link b
- [ ] To use systemd create a file `/etc/systemd/system/remote-server-launcher.service`
- [ ] Activate the service `systemctl enable remote-server-launcher.service && systemctl start remote-server-launcher.service && systemctl status remote-server-launcher.service && systemctl stop remote-server-launcher.service`

### Installation of fail2ban

- [ ] create a `/etc/fail2ban/jail.local` file with this content
- [ ] fail2ban (deploy)
- [ ] fail2ban (deploy) all servers
- [ ] fail2ban (master)
- [ ] `grep logpath /etc/fail2ban/jail.local | cut -d= -f2 | grep '^ /'|sort|uniq|xargs touch`
- [ ] Relaunch fail2ban and check errors into /var/log/fail2ban.log
- [ ]

### Setup of Mysql or Mariadb

TODO

=============================


# Configuraciones

## SSH and sudo

```bash
groupadd admin; useradd -m -s bash -g admin admin;
mkdir /home/admin/logs; chown root.admin /home/admin/logs; chmod 770 /home/admin/logs;
mkdir /mnt/diskbackup; chown admin.admin /mnt/diskbackup
mkdir /home/admin/backup; chown admin.admin /home/admin/backup;
mkdir /home/admin/backup/conf; chown admin.admin /home/admin/backup/conf;
mkdir /home/admin/backup/mysql; chown admin.admin /home/admin/backup/mysql;
mkdir /home/admin/wwwroot; chown admin.admin /home/admin/wwwroot
```

## Modification of `/etc/skel`

```bash
sudo mkdir /etc/skel/.ssh
sudo touch /etc/skel/.ssh/authorized_keys_support
sudo chmod -R go-rwx /etc/skel/.ssh
```

Agregar las llaves de admin, root y las de tu computadora en `/etc/skel/.ssh/authorized_keys_support`

## Creation of working directories (BOTH)

mkdir /mnt/diskbackup/backup
mkdir /mnt/diskhome/backup; chown admin /mnt/diskhome/backup;
ln -fs /mnt/diskhome/backup /mnt/diskbackup/backup

## Creation of working directories (deploy)

```bash
mkdir /home/jail; mkdir /mnt/diskhome/home;

mkdir /mnt/diskbackup/archives-test; mkdir /mnt/diskbackup/archives-paid
mkdir -p /home/admin/wwwroot/dolibarr_documents/sellyoursaas/spam;
chown admin.root /mnt/diskbackup/backup /mnt/diskbackup/archives-test /mnt/diskbackup/archives-paidln -fs /mnt/diskhome/home /home/jail/home
ln -fs /mnt/diskbackup/backup /home/jail/backup
ln -fs /mnt/diskbackup/archives-test /home/jail/archives-test
ln -fs /mnt/diskbackup/archives-paid /home/jail/archives-paid
```

## Getting files of Dolibarr and SellYourSaas application

```bash
cd /home/admin/wwwroot
git clone https://github.com/Dolibarr/dolibarr dolibarr --branch 17.0.1
chown -R admin.admin /home/admin/wwwroot/dolibarr

cd /home/admin/wwwroot
git clone https://github.com/dolicloud/sellyoursaas dolibarr_sellyoursaas
```

## NFS Shares

### NFS Shares - main

Validar los cambios

```bash
exportfs -v -a #(to validate new entries to add)
exportfs -v -r #(to validate new entries to remove)
exportfs
systemctl enable nfs-kernel-server && systemctl restart nfs-kernel-server && systemctl status nfs-kernel-server
exportfs
```

### Enabling  the nfs share - deploy

```bash
sudo apt install nfs-common
sudo mount -t nfs 192.168.1.2:/home/admin/wwwroot/dolibarr_documents/sellyoursaas /home/admin/wwwroot/dolibarr_documents/sellyoursaas
sudo umount /home/admin/wwwroot/dolibarr_documents/sellyoursaas
```

## Installation of packages (both)

```bash
sudo apt update
 
sudo apt install -y \
ntp git gzip zip zstd memcached ncdu duc iotop acl ufw sudo \
mariadb-server mariadb-client \
apache2 apache2-bin lynx \
php php-cli libapache2-mod-php php-fpm php-gd \
php-imap php-json php-ldap php-mysqlnd php-curl \
php-memcached php-imagick php-geoip php-mcrypt \
php-intl php-xml php-zip php-bz2 php-ssh2 \
php-mbstring php-soap php-readline php-xmlrpc \
php-pear watchdog cpulimit libapache2-mpm-itk \
libapache2-mod-apparmor apparmor apparmor-profiles \
apparmor-utils rkhunter chkrootkit bind9 \
spamc spamassassin clamdscan clamav-daemon \
fail2ban soffice libreoffice-common libreoffice-writer \
mailutils postfix
```

## Create the directory of the configuration files of the virtual hosts of the instances.

cd /etc/apache2
mkdir sellyoursaas-available sellyoursaas-online sellyoursaas-offline
ln -fs /etc/apache2/sellyoursaas-online /etc/apache2/sellyoursaas-enabled

## Installation and activation of the apache watchdogs provided in `/home/admin/wwwroot/dolibarr_sellyoursaas/scripts/`


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

## Agent installation and activation in `/home/admin/wwwroot/dolibarr_sellyoursaas/scripts/remote_server_launcher.sh` by creating a link b

```bash
ln -fs /home/admin/wwwroot/dolibarr_sellyoursaas/scripts/remote_server_launcher.sh /etc/init.d/remote_server_launcher
systemctl daemon-reload
systemctl enable remote_server_launcher
systemctl is-enabled remote_server_launcher
systemctl status remote_server_launcher
```

## fail2ban (deploy)

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

## fail2ban (deploy) all servers

```bash
cd /etc/fail2ban/jail.d
ln -fs /home/admin/wwwroot/dolibarr_sellyoursaas/etc/fail2ban/jail.d/email-dolibarr-ruleskoblacklist.conf
ln -fs /home/admin/wwwroot/dolibarr_sellyoursaas/etc/fail2ban/jail.d/email-dolibarr-ruleskoquota.conf
ln -fs /home/admin/wwwroot/dolibarr_sellyoursaas/etc/fail2ban/jail.d/email-dolibarr-rulesko.conf
ln -fs /home/admin/wwwroot/dolibarr_sellyoursaas/etc/fail2ban/jail.d/email-dolibarr-rulesall.conf
ln -fs /home/admin/wwwroot/dolibarr_sellyoursaas/etc/fail2ban/jail.d/email-dolibarr-rulesadmin.conf
ln -fs /home/admin/wwwroot/dolibarr_sellyoursaas/etc/fail2ban/jail.d/web-accesslog-limit403.conf
```

## fail2ban (master)

```bash
cd /etc/fail2ban/jail.d
ln -fs /home/admin/wwwroot/dolibarr_sellyoursaas/etc/fail2ban/jail.d/web-dolibarr-rulespassforgotten.conf
ln -fs /home/admin/wwwroot/dolibarr_sellyoursaas/etc/fail2ban/jail.d/web-dolibarr-rulesbruteforce.conf
ln -fs /home/admin/wwwroot/dolibarr_sellyoursaas/etc/fail2ban/jail.d/web-dolibarr-ruleslimitpublic.conf
ln -fs /home/admin/wwwroot/dolibarr_sellyoursaas/etc/fail2ban/jail.d/web-dolibarr-rulesregisterinstance.conf
```

### Setup of Mysql or Mariadb

TODO

## Setup of DNS server for domains served by the Deployment servers
On deployment servers


