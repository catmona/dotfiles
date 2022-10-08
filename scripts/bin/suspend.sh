#!/usr/bin/env bash

iptsd-reset-sensor &

~/bin/touchpad-setup.sh &

betterlockscreen -l dim &