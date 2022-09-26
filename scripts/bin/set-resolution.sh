#!/bin/sh

#Resolution
xrandr --newmode "1368x912-60.00"  103.00  1368 1448 1592 1816  912 915 925 947 -hsync +vsync
xrandr --addmode eDP1 1368x912-60.00
xrandr --output eDP1 --mode 1368x912-60.00