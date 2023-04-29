#!/bin/bash

if [[ $1 == "pause" ]]; then
    playerctl -p spotify pause

elif [[ $1 == "play" ]]; then
    playerctl -p spotify play

elif [[ $1 == "next" ]]; then
    playerctl -p spotify next

elif [[ $1 == "prev" ]]; then
    playerctl -p spotify previous
fi