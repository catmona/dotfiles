#!/bin/bash

sudo rm -r /home/cat/.icons/oomox-kitty/scalable/status
mkdir -p /home/cat/.icons/oomox-kitty/scalable/status
cd /home/cat/.icons/oomox-kitty/scalable/status

ln -s /home/cat/.icons/oomox-kitty/32x32/status/battery-full.svg battery-level-100-symbolic.svg
ln -s /home/cat/.icons/oomox-kitty/32x32/status/battery-full.svg battery-level-90-symbolic.svg

ln -s /home/cat/.icons/oomox-kitty/32x32/status/battery-good.svg battery-level-80-symbolic.svg
ln -s /home/cat/.icons/oomox-kitty/32x32/status/battery-good.svg battery-level-70-symbolic.svg
ln -s /home/cat/.icons/oomox-kitty/32x32/status/battery-good.svg battery-level-60-symbolic.svg

ln -s /home/cat/.icons/oomox-kitty/32x32/status/battery-low.svg battery-level-50-symbolic.svg
ln -s /home/cat/.icons/ozomox-kitty/32x32/status/battery-low.svg battery-level-40-symbolic.svg
ln -s /home/cat/.icons/oomox-kitty/32x32/status/battery-low.svg battery-level-30-symbolic.svg

ln -s /home/cat/.icons/oomox-kitty/32x32/status/battery-caution.svg battery-level-20-symbolic.svg
ln -s /home/cat/.icons/oomox-kitty/32x32/status/battery-caution.svg battery-level-10-symbolic.svg

ln -s /home/cat/.icons/oomox-kitty/32x32/status/battery-empty.svg battery-level-0-symbolic.svg

ln -s /home/cat/.icons/oomox-kitty/32x32/status/battery-full-charged.svg battery-level-100-charged-symbolic.svg 
ln -s /home/cat/.icons/oomox-kitty/32x32/status/battery-full-charging.svg battery-level-100-charging-symbolic.svg
ln -s /home/cat/.icons/oomox-kitty/32x32/status/battery-full-charging.svg battery-level-90-charging-symbolic.svg

ln -s /home/cat/.icons/oomox-kitty/32x32/status/battery-good-charging.svg battery-level-80-charging-symbolic.svg
ln -s /home/cat/.icons/oomox-kitty/32x32/status/battery-good-charging.svg battery-level-70-charging-symbolic.svg
ln -s /home/cat/.icons/oomox-kitty/32x32/status/battery-good-charging.svg battery-level-60-charging-symbolic.svg

ln -s /home/cat/.icons/oomox-kitty/32x32/status/battery-low-charging.svg battery-level-50-charging-symbolic.svg
ln -s /home/cat/.icons/oomox-kitty/32x32/status/battery-low-charging.svg battery-level-40-charging-symbolic.svg
ln -s /home/cat/.icons/oomox-kitty/32x32/status/battery-low-charging.svg battery-level-30-charging-symbolic.svg

ln -s /home/cat/.icons/oomox-kitty/32x32/status/battery-caution-charging.svg battery-level-20-charging-symbolic.svg
ln -s /home/cat/.icons/oomox-kitty/32x32/status/battery-caution-charging.svg battery-level-10-charging-symbolic.svg
ln -s /home/cat/.icons/oomox-kitty/32x32/status/battery-caution-charging.svg battery-level-0-charging-symbolic.svg


sudo rm -r /home/cat/.icons/oomox-kitty/scalable/legacy
mkdir -p /home/cat/.icons/oomox-kitty/scalable/legacy
cd /home/cat/.icons/oomox-kitty/scalable/legacy

ln -s /home/cat/.icons/oomox-kitty/32x32/status/battery-full.svg battery-full-symbolic.svg

ln -s /home/cat/.icons/oomox-kitty/32x32/status/battery-good.svg battery-good-symbolic.svg

ln -s /home/cat/.icons/oomox-kitty/32x32/status/battery-low.svg battery-low-symbolic.svg

ln -s /home/cat/.icons/oomox-kitty/32x32/status/battery-caution.svg battery-caution-symbolic.svg

ln -s /home/cat/.icons/oomox-kitty/32x32/status/battery-empty.svg battery-empty-symbolic.svg

ln -s /home/cat/.icons/oomox-kitty/32x32/status/battery-full-charged.svg battery-full-charged-symbolic.svg 
ln -s /home/cat/.icons/oomox-kitty/32x32/status/battery-full-charging.svg battery-full-charging-symbolic.svg

ln -s /home/cat/.icons/oomox-kitty/32x32/status/battery-good-charging.svg battery-good-charging-symbolic.svg

ln -s /home/cat/.icons/oomox-kitty/32x32/status/battery-low-charging.svg battery-low-charging-symbolic.svg

ln -s /home/cat/.icons/oomox-kitty/32x32/status/battery-caution-charging.svg battery-caution-charging-symbolic.svg


sudo gtk-update-icon-cache /home/cat/.icons/oomox-kitty

