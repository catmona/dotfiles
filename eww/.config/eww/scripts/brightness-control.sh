#!/bin/bash

if [[ $1 != "" ]]; then
    xbacklight -set $1
    eww update bright=$1
fi