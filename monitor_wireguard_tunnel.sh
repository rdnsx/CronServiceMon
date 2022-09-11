#!/bin/bash

target=$1

count=$( ping -c 3 $target | grep icmp* | grep bytes* | wc -l )

if [ $count -eq 0 ]
then

   echo "Tunnel probing FAILED! Restarting WireGuard service!"
   sudo systemctl restart wg-quick@wg0.service

else

   echo "Tunnel probing successfull!"

fi
