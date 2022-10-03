#!/bin/bash


# --- open control center ---
eww open --toggle control-center


# --- update storage variables ---
current=$(/usr/sbin/btrfs fi usage / 2>/dev/null | grep 'Free (estimated)' | grep -o -P '\d*\.\d*' | head -1)
total=$(/usr/sbin/btrfs fi usage / 2>/dev/null | grep 'Device size' | grep -o -P '\d*\.\d*')

free=$(echo "($current / $total) * 100" | bc -l)

used=$(echo "($current / $total) * 100 - 100" | bc -l)
used=${used#-}

eww update storage-free-perc=$free
eww update storage-used-perc=$used


# --- bluetooth ---
if [[ $(rfkill | grep bluetooth | grep -c " blocked") == 1 ]]; then
    eww update tgl-bluetooth=false
else
    eww update tgl-bluetooth=true
fi


# --- redshift ---
if [[ $(pidof redshift) == "" ]]; then
    eww update tgl-nightlight=false
else
    eww update tgl-nightlight=true
fi


# --- do not disturb ---
if [[ $(awesome-client 'naughty = require("naughty") return naughty.is_suspended()' | grep -c "false") == 1 ]]; then
    eww update tgl-dnd=false
else
    eww update tgl-dnd=true
fi


# --- muted ---
if [[ $(pactl get-source-mute 0 | grep -c "yes") == 1 ]]; then
    eww update tgl-mute=false
else
    eww update tgl-mute=true
fi


# --- music ---
# ~/.config/eww/scripts/music-control.sh title
# ~/.config/eww/scripts/music-control.sh artist
# ~/.config/eww/scripts/music-control.sh playing


# --- sliders ---
vol=$(awk -F"[][]" '/Left:/ { print $2 }' <(amixer sget Master))
mic=$(awk -F"[][]" '/Left:/ { print $2 }' <(amixer sget Capture))
bright=$(xbacklight)

eww update vol="${vol::-1}"
eww update rec="${mic::-1}"
eww update bright="$bright"


# --- profile stuff ---
up=$(uptime -p)
pkgs=$(checkupdates | wc -l)

eww update uptime="$up"
eww update pkgs="$pkgs"


# --- weather ---
mapfile -t warr <<< "$(curl "wttr.in/?format=%c\n%C\n%t\n%f\n")"
warr[2]=${warr[2]#+}
warr[3]=${warr[3]#+}

eww update weather-emoji="${warr[0]}"
eww update weather-curr=`echo ${warr[1]} | tr '[:upper:]' '[:lower:]'`
eww update weather-act="${warr[2]::-1}"
eww update weather-feel="${warr[3]::-1}"
