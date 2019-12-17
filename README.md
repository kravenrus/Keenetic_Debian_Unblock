# Keenetic_Debian_Unblock

## Installation

* Install [Debian](http://ndm.zyxmon.org/binaries/debian/),
* Install necessary dependencies:
```
apt update
apt install mc xmlstarlet cron net-tools curl ipset iptables dnsutils dnsmasq tor tor-geoipdb
```
* Download binaries and start script:
```
cat /dev/null > /etc/tor/torrc
cat /dev/null > /etc/dnsmasq.conf
cat /dev/null > /chroot-services.list

curl --output /etc/tor/torrc  --insecure https://raw.githubusercontent.com/kravenrus/Keenetic_Debian_Unblock/master/etc/tor/torrc
curl --output /etc/dnsmasq.conf  --insecure https://raw.githubusercontent.com/kravenrus/Keenetic_Debian_Unblock/master/etc/dnsmasq.conf
curl --output /etc/unblock.txt  --insecure https://raw.githubusercontent.com/kravenrus/Keenetic_Debian_Unblock/master/etc/unblock.txt
curl --output /etc/init.d/unblock --insecure https://raw.githubusercontent.com/kravenrus/Keenetic_Debian_Unblock/master/etc/init.d/unblock
curl --output /etc/init.d/runnohup --insecure https://raw.githubusercontent.com/kravenrus/Keenetic_Debian_Unblock/master/etc/init.d/runnohup
curl --output /bin/rtor.sh --insecure https://raw.githubusercontent.com/kravenrus/Keenetic_Debian_Unblock/master/bin/rtor.sh
curl --output /bin/tgbot.sh --insecure https://raw.githubusercontent.com/kravenrus/Keenetic_Debian_Unblock/master/bin/tgbot.sh
curl --output /bin/JSON.sh --insecure https://raw.githubusercontent.com/kravenrus/Keenetic_Debian_Unblock/master/bin/JSON.sh
curl --output /chroot-services.list --insecure https://raw.githubusercontent.com/kravenrus/Keenetic_Debian_Unblock/master/chroot-services.list

chmod +x /etc/init.d/unblock
chmod +x /etc/init.d/runnohup
chmod +x /bin/rtor.sh
chmod +x /bin/tgbot.sh
chmod +x /bin/JSON.sh

/etc/init.d/unblock start
```
* Download the redirect script, give permission to execute:
```
curl --output /tmp/100-redirect.sh  --insecure https://raw.githubusercontent.com/kravenrus/Keenetic_Debian_Unblock/master/tmp/100-redirect.sh

chmod +x /tmp/100-redirect.sh
```
** The steps described above can be automated. To do this, download the installation script, give execute rights and run:**
```
curl --output /tmp/install.sh  --insecure https://raw.githubusercontent.com/kravenrus/Keenetic_Debian_Unblock/master/tmp/install.sh

chmod +x /tmp/install.sh

/tmp/install.sh start
```
**[VERY IMPORTANT] Transfer this file to the /opt/etc/ndm/netfilter.d folder. This path is outside of Debian, so use FTP or SMB to migrate.**
* Connect to the CLI via SSH and run the following commands:
```
opkg dns-override
system configuration save
system reboot
```
* To use only the integrated DNS server, enter:
```
opkg no dns-override
system configuration save
system reboot
```

Have fun!
