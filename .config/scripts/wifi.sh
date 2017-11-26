#!bin/bash

#Fix for netctl "profile is already up" 

#Usage --> . wifi WirelessProfile
#where WirelessProfile is a netctl profile

sudo rfkill block all
sudo rfkill unblock all
sudo netctl restart $1


