# Usage

If you want to restrict access to some IP (to the web admin on Master server or to ssh or mysql to the Deployment servers), you can also create a file `/etc/sellyoursaas.d/-allowed-ip.conf` (http, ssh and mysql) or `/etc/sellyoursaas.d/-allowed-ip-ssh.conf` (ssh only) or `/etc/sellyoursaas.d/*-allowed-ip-mysql.conf*` (mysql only)

# File /etc/sellyoursaas.d/xxx-allowed-ip-zzz.conf

```conf
# User 1
Require ip ip.user.1
# User 2
Require ip ip.user.2
```