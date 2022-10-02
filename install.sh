#!/bin/bash

#Update OS
apt update && apt upgrade -y

#Install WireGuard
apt install wireguard -y

#Enable Wirequard
systemctl enable wireguard.service

#Copy wg-quick config
cp wg0.conf /etc/wireguard/

#Set crontab
(crontab -l 2>/dev/null; echo "* * * * *./monitor_wireguard_tunnel.sh 192.168.1.1") | crontab -
