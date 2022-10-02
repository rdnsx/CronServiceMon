# RDNSX - WireGuard Setup Agent
Script to install, setup, monitor and restart wireguard if its not running.

# How to use

Switch user to root:<br>
```sudu su``` 

Clone this repository:<br>
```git clone https://github.com/rdnsx/WireGuard-Setup-Agent.git``` 

Make it executeable:<br>
```chmod +x install.sh```

Run:<br>
```./install.sh```
<br>
# For Troubleshooting

Open Crontab:<br>
```crontab -e```

Add the following into crontab and replace <...> with the WireGuard Server IP adress.<br> 
```* * * * * /root/monitor_wireguard_tunnel.sh <WIREGUARD SERVER IP>```<br>

"* * * * *" runs the script at every minute. If you need to costumize it, check https://crontab.guru/
