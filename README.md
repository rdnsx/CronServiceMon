# CronServiceMon
Script to monitor a service like wireguard and start if not running.

# How to use

sudu su

git clone https://github.com/rdnsx/CronServiceMon.git 

crontab -e


Add the following into crontab and replace <...> with the WireGuard Server IP adress. 

* * * * * /root/monitor_wireguard_tunnel.sh <WIREGUARD SERVER IP>
