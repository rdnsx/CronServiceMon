# CronServiceMon
Script to monitor a service like wireguard and start if not running.

# How to use

Switch user to root:<br>
```sudu su``` 

Clone this repository:<br>
```git clone https://github.com/rdnsx/CronServiceMon.git``` 

Open Crontab:<br>
```crontab -e```


Add the following into crontab and replace <...> with the WireGuard Server IP adress.<br> 
```* * * * * /root/monitor_wireguard_tunnel.sh <WIREGUARD SERVER IP>```
