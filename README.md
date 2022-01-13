# dotfiles

Use [Stow](https://www.gnu.org/software/stow/#navigation) to manage dotfiles


## Dependencies

* [Awesome](https://github.com/awesomeWM/awesome)
* [Kitty](https://github.com/kovidgoyal/kitty)
* [Rofi](https://github.com/davatorium/rofi)
* [FontAwesome](https://github.com/FortAwesome/Font-Awesome)
* Bitstream Vera Sans Mono
* [Zsh](https://www.zsh.org/)
* [OhMyZsh](https://github.com/ohmyzsh/ohmyzsh)
* [Powerlevel10k](https://github.com/romkatv/powerlevel10k) (install meslo fonts too)
* [Zsh Autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)
* [Zsh Syntax Highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)
* [PCManFM](https://github.com/lxde/pcmanfm)
* [fd-find](https://github.com/sharkdp/fd)
* [Rofi todo](https://github.com/claudiodangelis/rofi-todo)
* [Picom](https://github.com/yshui/picom)
* [Nitrogen](https://github.com/l3ib/nitrogen)
* [BetterDiscord](https://betterdiscord.app/)
* [Flameshot](https://github.com/flameshot-org/flameshot)
* [Redshift](https://github.com/jonls/redshift)


## VSCode
 Use [Settings Sync](https://marketplace.visualstudio.com/items?itemName=Shan.code-settings-sync)


## For Surface

* [TLP](https://linrunner.de/tlp/)
* [PowerTop](https://github.com/fenrus75/powertop)

### .xprofile content:
```
#!/bin/sh

#Resolution
xrandr --newmode "1368x912_60.00"  103.00  1368 1448 1592 1816  912 915 925 947 -hsync +vsync
xrandr --addmode eDP1 1368x912_60.00
xrandr --output eDP1 --mode 1368x912_60.00

#polkit
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

#power management
tlp start &

#appearance
picom -b
redshift &

#systray
volumeicon &
```


