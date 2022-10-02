#!bin/bash

#Update OS
apt update && apt upgrade -y

#Install WireGuard
apt install wireguard -y

#Copy wg-quick config

#Copy monitoring script

#Enable Wirequard
systemctl enable wireguard.service

