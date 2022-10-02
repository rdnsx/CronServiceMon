#!/bin/bash

echo "RDNSX System Provisioning"
sleep 3
echo "Updating system"
sleep 2
#Update OS & clean
apt update && apt upgrade -y && apt autoremove -y

echo "Installing WireGuard"
sleep 3
#Install WireGuard
apt install wireguard -y
wg genkey | sudo tee /etc/wireguard/private.key
sudo chmod go= /etc/wireguard/private.key
sudo cat /etc/wireguard/private.key | wg pubkey | sudo tee /etc/wireguard/public.key
#Enable Wirequard
systemctl enable wireguard.service
#Copy wg-quick config
cp wg0.conf /etc/wireguard/

# Print privatekey and add to wg0.conf
PKEY=`cat /etc/wireguard/private.key`
sed -i '4i\PrivateKey = '"$PKEY" /etc/wireguard/wg0.conf

# Enter Wireguard Client IP and add to wg0.conf
# 10.0.73.?/24
echo "Enter Wireguard IP/Subnet:"
read WGIP
sed -i '3i\Address = '"$WGIP" /etc/wireguard/wg0.conf

echo "Setup WireGuard Monitoring"
sleep 3
cp monitor_wg_tunnel.sh /etc/wireguard/
chmod +x /etc/wireguard/monitor_wg_tunnel.sh
#Set crontab
(crontab -l 2>/dev/null; echo "* * * * * /monitor_wireguard_tunnel.sh 192.168.1.1") | crontab -
