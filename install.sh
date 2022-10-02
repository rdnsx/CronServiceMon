#!/bin/bash

echo
echo "###################################"
echo "RDNSX WireGuard Installation Script"
echo "###################################"
sleep 3
echo
echo 
echo "\e[1mUpdating system...\e[0m"
echo 
echo
sleep 2

#Update OS & clean
apt update && apt upgrade -y && apt autoremove -y

echo
echo 
echo "\e[1mInstalling WireGuard...\e[0m"
echo 
sleep 3
echo

#Install WireGuard
apt install wireguard -y
echo
echo 
echo "\e[1mGenerating keys...\e[0m"
echo 
sleep 3
wg genkey | sudo tee /etc/wireguard/private.key
sudo chmod go= /etc/wireguard/private.key
sudo cat /etc/wireguard/private.key | wg pubkey | sudo tee /etc/wireguard/public.key

#Copy wg-quick config
cp wg0.conf /etc/wireguard/

# Promts to enter Wireguard client IP and inserts it to wg0.conf line 3
# e.g.: 10.0.73.8/24
echo
echo
echo "##############################################"
echo
echo "\e[1mPlease enter these WireGuard Client IP/Subnet:\e[0m"
read WGIP
sed -i '3i\Address = '"$WGIP" /etc/wireguard/wg0.conf

# Inserts the PrivateKey to wg0.conf line 4
PKEY=`cat /etc/wireguard/private.key`
sed -i '4i\PrivateKey = '"$PKEY" /etc/wireguard/wg0.conf

# Shows public.key
echo
echo "#################################"
echo "\e[1mHere is these clients public key:\e[0m"

sleep 3
echo 
echo 
cat /etc/wireguard/public.key
echo
echo
echo "#################################"
echo
echo
read -p "\e[1mPress [Enter] to continue...\e[0m"

# Setup WireGuard monitoring service
echo
echo
echo "\e[1mSetup WireGuard Monitoring...\e[0m"
echo
sleep 3
cp monitor_wireguard_tunnel.sh /etc/wireguard/
chmod +x /etc/wireguard/monitor_wireguard_tunnel.sh
#Set crontab
(crontab -l 2>/dev/null; echo "* * * * * /etc/wireguard/monitor_wireguard_tunnel.sh 192.168.1.1") | crontab -

echo
echo "###########"
echo "###\e[1mDONE!\e[0m###"
echo "###########"
echo
