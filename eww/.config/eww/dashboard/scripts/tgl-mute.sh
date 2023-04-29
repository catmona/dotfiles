#!/bin/bash

#[ "$UID" -eq 0 ] || exec sudo bash "$0" "$@"

if [[ $1 == "off" ]]; then
    eww update tgl-mute=false
    pactl set-source-mute 0 1

elif [[ $1 == "on" ]]; then
    eww update tgl-mute=true
    pactl set-source-mute 0 0

fi