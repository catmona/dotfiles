#!/bin/bash

if [[ $1 == "off" ]]; then
    eww update tgl-bluetooth=false
    rfkill block bluetooth

elif [[ $1 == "on" ]]; then
    eww update tgl-bluetooth=true
    rfkill unblock bluetooth
    
fi