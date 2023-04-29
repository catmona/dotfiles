#!/bin/bash

if [[ $1 == "off" ]]; then
    eww update tgl-nightlight=false
    pkill redshift

elif [[ $1 == "on" ]]; then
    eww update tgl-nightlight=true
    redshift &
    
fi