#!/bin/sh

#touchpad disable when typing
syndaemon -i 0.5 -t -K -R -d

#enable drag lock
synclient TapAndDragGesture=1 LockedDrags=1 LockedDragTimeout=400

#enable palm detect
synclient PalmDetect=1