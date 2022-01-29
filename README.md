I still haven’t looked into systemd/user option. I did however manage to use this setup in multiple VM’s and my personal Storage Provider without any issues. I’m using Ubuntu Server 20.04, @MMA Streetlight hope this will give you enough details to get you going. 

As said I’m using Ubuntu Server (headless) and there for the CLI software as well. When I download the software I create a soft link for it.

ln -s ScPrime-v1.5.3-linux-amd64 /location/path/current

You can verify if it worked with:

ls -l ScPrime-v1.5.3-Linux-amd64 /location/path/current

I have also create a .seed where I have stored my wallet password (some use their seed), keep in my there are huge risks for doing this. Because anyone with access to you server will also be able to control the funds in your wallet. It’s clearly a personal choice of balancing risk over benefits 

Not going into detail on why this is handy, but when you update the node software you don’t have to change the shellscript as you can point simply to /location/path/current

Now we’ll create the shellscript file:

sudo nano /usr/local/sbin/spd-startup.sh

And enter the following details in the next screen:

#!/bin/bash

SPD_DATA=$HOME/location/path/.scprime

SCPRIME=$HOME/location/path/current

nohup $SCPRIME/spd -d $SPD_DATA -M gctwh &

sleep 5s

SCPRIME_WALLET_PASSWORD=`cat $HOME/location/path/.seed`

export SCPRIME_WALLET_PASSWORD

$SCPRIME/spc wallet unlock


When you close the spd-startup.sh file you will have to make it executable

chmod +x /usr/local/sbin/spd-startup.sh

To create the systemd .service file:

sudo nano /etc/systemd/system/spd-startup.service

Enter the following details in the next screen:

[Unit]
Description=spd startup
Wants=network.target
After=syslog.target network-online.target

[Service]
User=(your user name)
Type=Simple
ExecStart=/bin/bash -c /usr/local/sbin/spd-startup.sh
KillMode=process
Restart=on-failure
RestartSec=30

[Install]
WantedBy=multi-user.target
 (edited)
[3:52 AM]
Run the following commands

sudo systemctl daemon-reload

sudo systemctl enable spd-startup.service

sudo systemctl start spd-startup.service

You can check the status with

sudo systemctl status spd-startup.service
[3:54 AM]
Reboot your Server, watch and see what happens by checking the consensus and wallet status in spc  

I have done this multiple times in a variety of VMs to get familiar with it.
