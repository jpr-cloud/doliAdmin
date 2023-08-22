sudo apt install -y \
ntp git gzip zip zstd memcached ncdu duc iotop acl ufw sudo \
mariadb-server mariadb-client \
apache2 apache2-bin lynx

sudo apt install -y \
php php-cli libapache2-mod-php php-fpm php-gd \
php-imap php-json php-ldap php-mysql php-curl \
php-memcached php-imagick php-geoip php-mcrypt \
php-intl php-xml php-zip php-bz2 php-ssh2 \
php-mbstring php-soap php-readline php-xmlrpc \
php-pear watchdog cpulimit libapache2-mpm-itk

sudo apt install -y \
libapache2-mod-apparmor apparmor apparmor-profiles \
apparmor-utils rkhunter chkrootkit bind9 \
spamc spamassassin clamdscan clamav-daemon \
fail2ban soffice libreoffice-common libreoffice-writer \
mailutils postfix

# https://askubuntu.com/questions/1031921/php-mcrypt-package-missing-in-ubuntu-server-18-04-lts
# https://www.linuxhelp.com/questions/e-package-php-mcrypt-has-no-installation-candidate-error-on-ubuntu-20-4-1
