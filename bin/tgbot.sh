#!/bin/bash

#https://api.telegram.org/bot1010779316:AAGMtsLpv4xbWLps50k6ggUIZzy36_DLwgc/sendMessage?chat_id=262695591

API_TOKEN='1010779316:AAGMtsLpv4xbWLps50k6ggUIZzy36_DLwgc' # Токен бота из @BotFather
CHAT_ID='262695591' # ID чата с которым боту предстоит работать @userinfobot
URL='https://api.telegram.org/bot'$API_TOKEN # Глобальная ссылка взаимодействия с ботом
MSG_URL=$URL'/sendMessage?chat_id='$CHAT_ID # Ссылка для отправки сообщения ботом
UPD_URL=$URL'/getUpdates?offset=' # Ссылка для получения сообщения ботом
OFFSET=0 # Счетчик обработанных обновлений
TIMEOUT='&timeout=10' # Интервал обработки обновлений

### Запуск бота, для управления Keenetic

if [ "$1" == "start" ]; then

MSG="<b>\[TGBOT\]</b> Telegram Bot был запущен.%0A<i>Возможно роутер был перезагружен, но это не точно.</i>"

curl -m 600 --socks5 127.0.0.1:9050 -k -s -X POST "$MSG_URL&parse_mode=html&text=$MSG" &>/dev/null # Отправка сообщения ботом при запуске

while true; do {
	RES=$(curl -m 600 --socks5 127.0.0.1:9050 -k -s -X POST $UPD_URL$OFFSET$TIMEOUT)

	TARGET=$(echo $RES | JSON.sh | egrep '\["result",0,"message","chat","id"\]' | cut -f 2)
	OFFSET=$(echo $RES | JSON.sh | egrep '\["result",0,"update_id"\]' | cut -f 2)
	MESSAGE=$(echo $RES | JSON.sh -s | egrep '\["result",0,"message","text"\]' | cut -f 2 | cut -d '"' -f 2)
	USER=$(echo $RES | JSON.sh | egrep '\["result",0,"message","from","username"\]' | cut -f 2 | cut -d '"' -f 2)

	[ -z "$MESSAGE" ] || echo "[$(date +%Y.%m.%d_%H:%M:%S)][$USER] $MESSAGE" >> /var/log/Telegram_Bot.log

	OFFSET=$((OFFSET+1))

	if [ $OFFSET != 1 ]; then
		case $MESSAGE in
			'/start') MSG="tg_say.sh START LOL";; # Настройка действия/вывода для /start
			'/uname') MSG="$(uname -a)";; # Настройка действия/вывода для /uname
			
			'/ip') MSG="<b>\[TGBOT\]</b> На данный момент%0A<i>IP адрес: $(ndmq -p 'show interface' -x | xmlstarlet sel -t -m '//interface[link="up"][state="up"][global="yes"][defaultgw="yes"]' -v 'address' -n)</i>";;
			
			'/update') ndmq -p "interface ISP ip dhcp client release" && sleep 10 &&
			ndmq -p "interface ISP ip dhcp client release" && sleep 60 && echo "$(ndmq -p 'show interface' -x | xmlstarlet sel -t -m '//interface[link="up"][state="up"][global="yes"][defaultgw="yes"]' -v 'address' -n)" >/tmp/previp.txt && /etc/init.d/tor restart &&
			MSG="<b>\[TGBOT\]</b> IP адрес успешно изменен!%0AСервис Tor был перезапущен.%0A<i>Теперь ваш IP: $(ndmq -p 'show interface' -x | xmlstarlet sel -t -m '//interface[link="up"][state="up"][global="yes"][defaultgw="yes"]' -v 'address' -n)</i>";;
			
			'/services') MSG="<b>\[TGBOT\]</b> Информация о доступе%0A==================================%0AНа роутере настроен DDNS, доступ к сервисам можно получить через DNS или IP адрес. Поскольку DDNS может быть не обновлен, доступ к сервисам окажется закрытым. В данной ситации предпочтительно подключение по IP адресу.%0A---------------------------------------------------------------------%0A/services_ip - список IP%0A/services_ddns - список DDNS";;
			'/services_ip') IP="$(ndmq -p 'show interface' -x | xmlstarlet sel -t -m '//interface[link="up"][state="up"][global="yes"][defaultgw="yes"]' -v 'address' -n)" MSG="<b>\[TGBOT\]</b> Доступные сервисы:%0A==================================%0AFTP:%0Aftp://$IP%0A---------------------------------------------------------------------%0AApache:%0Ahttp://$IP%0A---------------------------------------------------------------------%0ADLNA:%0Ahttp://$IP:8200%0A---------------------------------------------------------------------%0ATransmission:%0Ahttp://$IP:9091";;
			'/services_ddns') MSG="<b>\[TGBOT\]</b> Доступные сервисы:%0A==================================%0AFTP:%0Aftp://kravenrus.mykeenetic.net%0Aftp://kravenrus.ddns.net%0A---------------------------------------------------------------------%0AApache:%0Ahttp://kravenrus.mykeenetic.net%0Ahttp://kravenrus.ddns.net%0Ahttps://kravenrus.mykeenetic.net%0Ahttps://kravenrus.ddns.net%0A---------------------------------------------------------------------%0ADLNA:%0Ahttp://kravenrus.mykeenetic.net:8200%0Ahttp://kravenrus.ddns.net:8200%0A---------------------------------------------------------------------%0ATransmission:%0Ahttp://kravenrus.mykeenetic.net:9091%0Ahttp://kravenrus.ddns.net:9091";;
			*) MSG="$MESSAGE";; # Настройка вывод полученного сообщения
		esac
		
	curl -m 600 --socks5 127.0.0.1:9050 -k -s -X POST "$MSG_URL&parse_mode=html&text=$MSG" &>/dev/null # Отправка сообщения ботом
	
	fi

} &>/dev/null; done

else

curl -m 600 --socks5 127.0.0.1:9050 -k -s -X POST "$MSG_URL&parse_mode=html&text=$@" &>/dev/null # Отправка сообщения ботом

fi