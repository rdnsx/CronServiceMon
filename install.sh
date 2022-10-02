#!/bin/bash

#Update OS & clean
apt update && apt upgrade -y && apt autoremove -y

#Install WireGuard
apt install wireguard -y
wg genkey | sudo tee /etc/wireguard/private.key
sudo chmod go= /etc/wireguard/private.key
sudo cat /etc/wireguard/private.key | wg pubkey | sudo tee /etc/wireguard/public.key

#Copy wg-quick config
#cp wg0.conf /etc/wireguard/

chmod +x monitor_wg_tunnel.sh

#Set crontab
(crontab -l 2>/dev/null; echo "* * * * *./monitor_wireguard_tunnel.sh 192.168.1.1") | crontab -

#Enable Wirequard
systemctl enable wireguard.service
