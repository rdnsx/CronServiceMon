#!/bin/bash

echo
echo "RDNSX System Provisioning"
sleep 3
echo
echo "Updating system"
echo
sleep 2

#Update OS & clean
apt update && apt upgrade -y && apt autoremove -y

echo
echo "Installing WireGuard"
sleep 3
echo

#Install WireGuard
apt install wireguard -y
echo
echo "Generating keys"
sleep 3
wg genkey | sudo tee /etc/wireguard/private.key
sudo chmod go= /etc/wireguard/private.key
sudo cat /etc/wireguard/private.key | wg pubkey | sudo tee /etc/wireguard/public.key

#Enable Wirequard
systemctl enable wireguard.service

#Copy wg-quick config
cp wg0.conf /etc/wireguard/

# Promts to enter Wireguard client IP and inserts it to wg0.conf line 3
# e.g.: 10.0.73.8/24
echo "Enter Wireguard IP/Subnet:"
read WGIP
sed -i '3i\Address = '"$WGIP" /etc/wireguard/wg0.conf

# Inserts the PrivateKey to wg0.conf line 4
PKEY=`cat /etc/wireguard/private.key`
sed -i '4i\PrivateKey = '"$PKEY" /etc/wireguard/wg0.conf

# Shows public.key
echo "Here is these clients public key:"
echo 
cat /etc/wireguard/public.key
echo
pause

# Setup WireGuard monitoring service
echo
echo "Setup WireGuard Monitoring"
sleep 3
cp monitor_wg_tunnel.sh /etc/wireguard/
chmod +x /etc/wireguard/monitor_wg_tunnel.sh
#Set crontab
(crontab -l 2>/dev/null; echo "* * * * * /monitor_wireguard_tunnel.sh 192.168.1.1") | crontab -
