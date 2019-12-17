#!/bin/bash

[ "$1" != "start" ] && exit 0

apt update
apt install mc xmlstarlet cron net-tools ipset iptables dnsutils dnsmasq tor tor-geoipdb

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

curl --output /tmp/100-redirect.sh  --insecure https://raw.githubusercontent.com/kravenrus/Keenetic_Debian_Unblock/master/ndm/netfilter.d/100-redirect.sh

chmod +x /tmp/100-redirect.sh