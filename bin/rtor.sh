#!/bin/bash

[ "$1" != "start" ] && exit 0

while true; do {
    
	sleep 1h

    PREVIP=`cat "/tmp/previp.txt"`
    IP="$(ndmq -p 'show interface' -x | xmlstarlet sel -t -m '//interface[link="up"][state="up"][global="yes"][defaultgw="yes"]' -v 'address' -n)"

    if [ "$PREVIP" != "$IP" ]; then
	    sleep 60
        echo "$(ndmq -p 'show interface' -x | xmlstarlet sel -t -m '//interface[link="up"][state="up"][global="yes"][defaultgw="yes"]' -v 'address' -n)" >/tmp/previp.txt
		
	    /etc/init.d/tor restart
		
		tgbot.sh "<b>\[RTOR\]</b> IP адрес был изменен!%0AСервис Tor был перезапущен скриптом."
    fi
} &>/dev/null; done