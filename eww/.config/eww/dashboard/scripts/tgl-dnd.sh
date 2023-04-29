#!/bin/bash

if [[ $1 == "off" ]]; then
    eww update tgl-dnd=false
    awesome-client 'naughty = require("naughty") naughty.resume()'

elif [[ $1 == "on" ]]; then
    eww update tgl-dnd=true
    awesome-client 'naughty = require("naughty") naughty.suspend()'
    
fi