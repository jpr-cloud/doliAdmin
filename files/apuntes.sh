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



soffice
# https://askubuntu.com/questions/1031921/php-mcrypt-package-missing-in-ubuntu-server-18-04-lts
# https://www.linuxhelp.com/questions/e-package-php-mcrypt-has-no-installation-candidate-error-on-ubuntu-20-4-1

php-mcrypt
sudo apt install -y php php-pear php-dev libmcrypt-dev
sudo pecl install mcrypt
printf 'extension=mcrypt.so\n' >> /etc/php/7.4/mods-available/mcrypt.ini
phpenmod mcrypt

sudo apt update
sudo apt install -y systemd-timesyncd git gzip zip zstd memcached ncdu duc iotop acl ufw sudo
sudo apt install -y mariadb-server mariadb-client
sudo apt install -y apache2 apache2-bin lynx
sudo apt install -y php php-cli libapache2-mod-php php-fpm php-gd php-imap php-json php-ldap php-mysql php-curl php-memcached php-imagick php-geoip php-intl php-xml php-zip php-bz2 php-ssh2 php-mbstring php-dev php-soap libmcrypt-dev
sudo apt install -y php-readline php-xmlrpc
sudo apt install -y php-pear ghostscript
sudo apt install -y watchdog cpulimit libapache2-mpm-itk libapache2-mod-apparmor apparmor apparmor-profiles apparmor-utils rkhunter chkrootkit
sudo apt install -y bind9
sudo apt install -y spamc spamassassin clamav clamav-daemon
sudo apt install -y fail2ban
sudo apt install -y libreoffice-common libreoffice-writer
sudo apt install -y mailutils postfix



systemctl start fail2ban && systemctl status fail2ban


systemctl start spamassassin





50SERVER='/etc/mysql/mariadb.conf.d/50-server.cnf'

sed -i 's/bind-address            = 127.0.0.1/bind-address            = 0.0.0.0/g' $50SERVER
sed -i 's/#max_connections        = 100/max_connections        = 500/g' $50SERVER
sed -i 's/SEARCH_REGEX/REPLACEMENT/g' $50SERVER
sed -i 's/SEARCH_REGEX/REPLACEMENT/g' $50SERVER
sed -i 's/SEARCH_REGEX/REPLACEMENT/g' $50SERVER
sed -i 's/SEARCH_REGEX/REPLACEMENT/g' $50SERVER
sed -i 's/SEARCH_REGEX/REPLACEMENT/g' $50SERVER
sed -i 's/SEARCH_REGEX/REPLACEMENT/g' $50SERVER
sed -i 's/SEARCH_REGEX/REPLACEMENT/g' $50SERVER
sed -i 's/SEARCH_REGEX/REPLACEMENT/g' $50SERVER


touch phpmail.log