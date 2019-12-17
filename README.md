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
curl --output /etc/tor/torrc  --insecure https://raw.githubusercontent.com/kravenrus/Keenetic_Debian_Unblock/master/etc/tor/torrc
curl --output /etc/dnsmasq.conf  --insecure https://raw.githubusercontent.com/kravenrus/Keenetic_Debian_Unblock/master/etc/dnsmasq.conf
curl --output /etc/unblock.txt  --insecure https://raw.githubusercontent.com/kravenrus/Keenetic_Debian_Unblock/master/etc/unblock.txt
curl --output /etc/init.d/unblock --insecure https://raw.githubusercontent.com/kravenrus/Keenetic_Debian_Unblock/master/etc/init.d/unblock
curl --output /bin/rtor.sh --insecure https://raw.githubusercontent.com/kravenrus/Keenetic_Debian_Unblock/master/bin/rtor.sh
curl --output chroot-services.list --insecure https://raw.githubusercontent.com/kravenrus/Keenetic_Debian_Unblock/master/chroot-services.list

chmod +x /etc/init.d/unblock
chmod +x /bin/rtor.sh

/etc/init.d/unblock start
```
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
