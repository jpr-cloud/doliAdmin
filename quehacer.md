# Como ordenar las playbooks

Me guiaré en el TOC del documento oficial

## Adding the hard disk for data (home of user instances and home of backups)

Titulo | task | master | deploy
-|-|-|-
Mount disk | mount |  ⛔ | ✅
Optimize the memory for a lot of inode and dentry | slabtop  | ⛔ | ✅

## Login setup

### Default shell

Titulo | task | master | deploy
-|-|-|-
Modify the default shell to use bash | default_shell | ⛔ | ✅
Optimize the memory for a lot of inode and dentry | slabtop | ⛔ | ✅
Min for password | min_for_password | ✴️ | ✅
Unix personal sysadmin account _{jpyrsaadmin}_ | sysadmin_account | ✴️ | ✅
Unix admin account _{admin}_ | sysadmin_account | ✴️ | ✅
SSH setup | ssh_setup | ✴️ | ✅
Min for password | min_for_password | ⛔ | ✅
Min for password | min_for_password | ⛔ | ✅
Min for password | min_for_password | ⛔ | ✅

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
virtual host file admin.mysaasdomainname.com.con| vh_admin.mysaasdomainname.com | ✅ | ⛔ | -
virtual host file myaccount.mysaasdomainname.com.conf| vh_amyaccount.mysaasdomainname.com.conf | ✅ | ⛔ | -
Timeout of server launches| db_Timeout of server launches | ✅  | ✅ | -
Firewall | na | na | na | - ?????
Installation of unix watchdog (optional) | na | ✴️ | ✴️ | -
Installation of the Apache watchdog | Apache_watchdog | ⛔ | ✅ | -
Installation of the instance deployment agent| deployment_agent | ⛔ | ✅ | -
Installation of fail2ban | na | na | na | -
Added support for IP v6 | na | na | na | -
Added support for IP v6 | na | na | na | -
Added support for IP v6 | na | na | na | -
