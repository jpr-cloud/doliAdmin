# Como ordenar las playbooks

Me guiaré en el TOC del documento oficial

mkdir -p roles/nombre/{handlers,tasks,templates}

mkdir -p roles/apache/{handlers,tasks,templates}

mkfs.ext4 -F  /dev/disk/by-id/scsi-0HC_Volume_102911745

mkdir /mnt/diskhome

mount -o discard,defaults /dev/disk/by-id/scsi-0HC_Volume_102911745 /mnt/diskhome

echo "/dev/disk/by-id/scsi-0HC_Volume_102911745 /mnt/diskhome ext4 discard,nofail,defaults 0 0" >> /etc/fstab

## Adding the hard disk for data (home of user instances and home of backups)

Titulo | task | master | deploy
-|-|-|-
Mount disk | mount |  ⛔ | ✅
Optimize the memory for a lot of inode and dentry | slabtop  | ⛔ | ✅

## Elementos no manuales

Titulo | task | master | deploy | Revisado | notas
-|-|-|-|- |-
Modify the default shell to use bash | default_shell | ⛔ | ✅ |-|-
Optimize the memory for a lot of inode and dentry | slabtop | ⛔ | ✅|-|-
Min for password | min_for_password | ✴️ | ✅|-|-
Unix personal sysadmin account _{jpyrsaadmin}_ | sysadmin_account | ✴️ | ✅|-|-
Unix admin account _{admin}_ | sysadmin_account | ✅ | ✅  |-|-
myunixlogin | myunixlogin | ⛔ | ✅|-|-
SSH setup | ssh_setup | ✴️ | ✅|-|-

Nota: **root, admin and mylastnamefirstname deben tener su propia llave**

Titulo | task | master | deploy | nota
-|-|-|-|-
Deletion of information files at login | del_info_login | ✴️ | ✅ | -
Creation or modification of /etc/skel directory template | skel_template | ⛔ | ✅ | -
Add alias | deploy_alias | ⛔ | ✅ | -
Added support for IP v6 | na | na | na | -
Addition of a swap  | na | na | na | -
Addition of a filesystem for logs () | na | ✴️  | ✅ | depende de la configuración de apache
Creation of working directories | working_dir | ✅  | ✅ | depende de la configuración de apache
Getting files of Dolibarr and SellYourSaas application | dolibarr_SellYourSaas | ✅  | ✅ | depende de la configuración de apache
Creation of /.conf with credentials = /etc/sellyoursaas.conf | conf_with_credentials | ✅  | ✅ | El archivo /etc/sellyoursaas.conf es diferente para main y deploy
Installing the nfs share | nfs_share_master | ✅ | ⛔ | -
Installing the nfs share | nfs_share_deploy | ⛔ | ✅ | -
Deploy the public key of master admin on deployment admin accoun | na | ✅  | ✅ | -
/home/admin/.ssh/id_rsa_sellyoursaas| na | ⛔ | ✅ | -
Installation of system and application components| packages | ✅  | ✅ | -
Disabling automatic update| nattended-upgrades | ✅  | ✅ | -
Max size increase UID| increase_UID | ⛔ | ✅ | -
/etc/apache2/mods-enabled/mpm_itk.conf| mpm_itk_conf | ⛔ | ✅ | -
Apache web server configuration | na | ✅  | ✅ | -
Enable apache modules  | apache_modules | ✅  | ✅ | -
Remove this not usefull apache modules | usefull_apache_modules | ✅  | ✅ | agregar a2dismod mcrypt
Create the directory of the configuration files of the virtual hosts of the instances. | virtual_hosts_of_the_instances | ⛔ | ✅ | -
/etc/apache2/.htpasswd | na | ✅ | ⛔ | -
admin.mysaasdomainname.com.conf| vh_admin.mysaasdomainname.com | ✅ | ⛔ | -
myaccount.mysaasdomainname.com.conf| vh_amyaccount.mysaasdomainname.com.conf | ✅ | ⛔ | -
Timeout of server launches| db_Timeout of server launches | ✅  | ✅ | -
Firewall | na | na | na | - ?????
Installation of unix watchdog (optional) | na | ✴️ | ✴️ | -
Installation of the Apache watchdog | Apache_watchdog | ⛔ | ✅ | -
Installation of the instance deployment agent| deployment_agent | ⛔ | ✅ | -
Installation of fail2ban | na | ⛔ | ✅  | Miscelanea, es decir que este punto tiene configuraciones específicas para cada servidor
Test spamassassin | test_spamassassin | ✅  | ✅ | -
Test and setup of ClamAV | test_ClamAV | ✅ | ✅ | -
Afick | Afick | ✅  | ✅ | -
Setup of cpulimit (optional) | cpulimit | ✅  | ✅ | -
Setup of /etc/security/limits.conf (optional)| limits | ⛔ | ✅| -
Setup of Postfix | na | na | na | Este paso lo hacemos con el proveedor externo
Setup of Mysql or Mariadb bind-address | Mariadb_bind-address | ✅ | ⛔| -
Setup of Mysql or Mariadb mysql.service | mysql.service | ⛔ | ✅ | -
Setup of Mysql or Mariadb mysql root password | mysql_root_password | ✅ | ✅ | -
MySQL Secure the root account | Mysql_secure_root_account | ✅ | ✅ | -
MySQL grant access localy to the login sellyoursaas | Mysql_login_sellyoursaas | ✅ | ✅ | -
MySQL Create a user to login, for remote administration (optional) | Mysql_remote_login_admin | ✅ | ✅ | -
MySQL Create a user for supervision (optional) | Mysql_supervision_login | ✅ | ✅ | -
Setup of AppArmor| AppArmor | ⛔ | ✅ | -
Jailkit configuration (optional)| Jailkit | ⛔ | ✅ | -
Allow generation of PNG thumbs from PDFs | allow_png_gen | ⛔ | ✅ | -
Setup of PHP | setup_php | x | ✅  | Miscelanea, es decir que este punto tiene configuraciones específicas para cada servidor
Setup of logrotate | logrotate | ✅ | ✅ | -
Setup of journalctl | journalctl | ✅ | ✅ | -
Create a wildcard SSL certificate for user instances | ssl_certs_wildcard | ⛔ | ✅ | -
Installation of Cron tasks | cron_task_master | ✅ | ⛔ | -
Installation of Cron tasks | cron_task_deplpy | ⛔ | ✅ | -
Installation of Dolibarr framework | Dolibarr_framework | ✅ | ✅ | -
Installation of Dolibarr framework master | Dolibarr_framework | ✅ | ✅ | Miscelanea
Installation of Geoip2| Geoip2 | ✅ | ⛔| -

Installation or update of plugin SellYourSaas **Instalación Manual**

Titulo | task | master | deploy | Comantarios
-|-|-|-
Installation of DataDog (optional for supervision) | manual | ✴️ | ✴️ | Es un servicio externo
Added support for IP v6 | na | na | na | -

Setup of DNS server for domains served by the Master server **Lo haremos manual para entender el funcionamiento o usar el DNS de hetzner**
