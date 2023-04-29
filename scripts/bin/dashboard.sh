#!/bin/bash


# --- open control center ---
eww -c ~/.config/eww/dashboard open --toggle control-center

if [[ $(eww -c ~/.config/eww/dashboard windows | grep -c "*control-center") == 0 ]]; then
    echo "closing early!"
    exit
fi

# --- update storage variables ---
current=$(/usr/sbin/btrfs fi usage / 2>/dev/null | grep 'Free (estimated)' | grep -o -P '\d*\.\d*' | head -1)
total=$(/usr/sbin/btrfs fi usage / 2>/dev/null | grep 'Device size' | grep -o -P '\d*\.\d*')

free=$(echo "($current / $total) * 100" | bc -l)

used=$(echo "($current / $total) * 100 - 100" | bc -l)
used=${used#-}

eww -c ~/.config/eww/dashboard update storage-free-perc=$free
eww -c ~/.config/eww/dashboard update storage-used-perc=$used


# --- bluetooth ---
if [[ $(rfkill | grep bluetooth | grep -c " blocked") == 1 ]]; then
    eww -c ~/.config/eww/dashboard update tgl-bluetooth=false
else
    eww -c ~/.config/eww/dashboard update tgl-bluetooth=true
fi


# --- redshift ---
if [[ $(pidof redshift) == "" ]]; then
    eww -c ~/.config/eww/dashboard update tgl-nightlight=false
else
    eww -c ~/.config/eww/dashboard update tgl-nightlight=true
fi


# --- do not disturb ---
if [[ $(awesome-client 'naughty = require("naughty") return naughty.is_suspended()' | grep -c "false") == 1 ]]; then
    eww -c ~/.config/eww/dashboard update tgl-dnd=false
else
    eww -c ~/.config/eww/dashboard update tgl-dnd=true
fi


# --- muted ---
if [[ $(pactl get-source-mute 0 | grep -c "yes") == 1 ]]; then
    eww -c ~/.config/eww/dashboard update tgl-mute=false
else
    eww -c ~/.config/eww/dashboard update tgl-mute=true
fi


# --- music ---
# ~/.config/eww -c ~/.config/eww/dashboard/scripts/music-control.sh title
# ~/.config/eww -c ~/.config/eww/dashboard/scripts/music-control.sh artist
# ~/.config/eww -c ~/.config/eww/dashboard/scripts/music-control.sh playing


# --- sliders ---
vol=$(awk -F"[][]" '/Left:/ { print $2 }' <(amixer sget Master))
mic=$(awk -F"[][]" '/Left:/ { print $2 }' <(amixer sget Capture))
bright=$(xbacklight)

eww -c ~/.config/eww/dashboard update vol="${vol::-1}"
eww -c ~/.config/eww/dashboard update rec="${mic::-1}"
eww -c ~/.config/eww/dashboard update bright="$bright"


# --- profile stuff ---
up=$(uptime -p)
#pkgs=$(checkupdates | wc -l)

eww -c ~/.config/eww/dashboard update uptime="$up"
#eww -c ~/.config/eww/dashboard update pkgs="$pkgs"


# --- weather ---
mapfile -t warr <<< "$(curl 'wttr.in/?format=%c\n%C\n%t\n%f\n')"
warr[2]=${warr[2]#+}
warr[3]=${warr[3]#+}

eww -c ~/.config/eww/dashboard update weather-emoji="${warr[0]}"
eww -c ~/.config/eww/dashboard update weather-curr="$(echo ${warr[1]} | tr '[:upper:]' '[:lower:]')"
eww -c ~/.config/eww/dashboard update weather-act="${warr[2]::-1}"
eww -c ~/.config/eww/dashboard update weather-feel="${warr[3]::-1}"
