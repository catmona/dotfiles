#!/bin/bash

if [[ $1 != "" ]]; then
    amixer --quiet set Master $1%
    eww update vol=$1
fi