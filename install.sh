#!bin/bash

#Update OS
apt update && apt upgrade -y

#Install WireGuard
apt install wireguard -y

#Copy wg-quick config

#Set crontab

(crontab -l 2>/dev/null; echo "* * * * *./ 192.168.1.1") | crontab -

#Enable Wirequard
systemctl enable wireguard.service

