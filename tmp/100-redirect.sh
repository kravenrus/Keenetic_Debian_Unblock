#!/bin/sh

[ "$type" == "ip6tables" ] && exit 0

iptables -w -t nat -A PREROUTING -i br0 -p tcp -m set --match-set unblock dst -j REDIRECT --to-port 9141

iptables -w -t nat -I PREROUTING -i br0 -p udp --dport 53 -j DNAT --to 192.168.1.1
iptables -w -t nat -I PREROUTING -i br0 -p tcp --dport 53 -j DNAT --to 192.168.1.1

# PPTP
iptables -t nat -A PREROUTING -i vpn0 -p tcp -m set --match-set unblock dst -j REDIRECT --to-port 9141

# L2TP/IPsec PSK
iptables -t nat -A PREROUTING -i l2tp0 -p tcp -m set --match-set unblock dst -j REDIRECT --to-port 9141

# IPsec Xauth PSK
iptables -t nat -A PREROUTING -i ezcfg0 -p tcp -m set --match-set unblock dst -j REDIRECT --to-port 9141