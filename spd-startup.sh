#!/bin/bash

SPD_DATA=/scprime/meta
SCPRIME=/scprime/app/current
nohup $SCPRIME/spd -d $SPD_DATA -M gctwh &
sleep 5s
SCPRIME_WALLET_PASSWORD=`cat $HOME/.scprime/.seed`
export SCPRIME_WALLET_PASSWORD
$SCPRIME/spc wallet unlock
