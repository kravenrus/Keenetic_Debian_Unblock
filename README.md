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
curl --output /opt/bin/bashbot.sh --insecure https://raw.githubusercontent.com/ryzhovau/telegram-bot-bash/master/opt/bin/bashbot.sh
curl --output /opt/bin/JSON.sh --insecure https://raw.githubusercontent.com/ryzhovau/telegram-bot-bash/master/opt/bin/JSON.sh
curl --output /opt/etc/init.d/S51bashbot  --insecure https://raw.githubusercontent.com/ryzhovau/telegram-bot-bash/master/opt/etc/init.d/S51bashbot
chmod +x /opt/bin/bashbot.sh
chmod +x /opt/bin/JSON.sh
chmod +x /opt/etc/init.d/S51bashbot
```
* Insert bot's token to access the HTTP API to `TOKEN` constant at `/opt/bin/bashbot.sh`
* Run bot by typing:
```
/opt/etc/init.d/S51bashbot start
```

Have fun!
