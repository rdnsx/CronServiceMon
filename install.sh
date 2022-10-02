#!/bin/bash

echo
echo "###################################"
echo -e "\e[1mRDNSX WireGuard Installation Script\e[22m"
echo "###################################"
sleep 3
echo
echo 
echo -e "\e[1mUpdating system...\e[22m"
echo 
echo
sleep 2
apt update && apt upgrade -y && apt autoremove -y

echo
echo 
echo -e "\e[1mInstalling WireGuard...\e[22m"
echo 
sleep 3
echo
apt install wireguard -y
echo
echo 
echo -e "\e[1mGenerating keys...\e[22m"
echo 
sleep 3
wg genkey | sudo tee /etc/wireguard/private.key
sudo chmod go= /etc/wireguard/private.key
sudo cat /etc/wireguard/private.key | wg pubkey | sudo tee /etc/wireguard/public.key

cp wg0.conf /etc/wireguard/

# Promts to enter Wireguard client IP and inserts it to wg0.conf line 3
# e.g.: 10.0.73.8/24
echo
echo
echo "##############################################"
echo
echo -e "\e[1mPlease enter these WireGuard Client IP/Subnet:\e[22m"
read WGIP
sed -i '3i\Address = '"$WGIP" /etc/wireguard/wg0.conf

# Inserts the PrivateKey to wg0.conf line 4
PKEY=`cat /etc/wireguard/private.key`
sed -i '4i\PrivateKey = '"$PKEY" /etc/wireguard/wg0.conf

# Shows public.key
echo
echo "#################################"
echo -e "\e[1mHere is these clients public key:\e[22m"

sleep 3
echo 
echo 
cat /etc/wireguard/public.key
echo
echo
echo "#################################"
echo
echo
read -p "Press [Enter] to continue..."

# Setup WireGuard monitoring service
echo
echo
echo -e "\e[1mSetup WireGuard Monitoring...\e[22m"
echo
sleep 3
cp monitor_wireguard_tunnel.sh /etc/wireguard/
chmod +x /etc/wireguard/monitor_wireguard_tunnel.sh
#Set crontab
(crontab -l 2>/dev/null; echo "* * * * * /etc/wireguard/monitor_wireguard_tunnel.sh 192.168.1.1") | crontab -

echo
echo "###########"
echo -e "###\e[1mDONE!\e[22m###"
echo "###########"
echo
