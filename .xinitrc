#!/bin/sh



###
## Startup Programs/tweaks
###
nitrogen --restore &
picom --config ~/.config/picom/picom.conf &
/usr/local/bin/dwmblocks &
sxhkd &
xrandr --auto &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

##
# Window Manager >-<
##
exec /home/rander/.config/suckless/dwm/dwm
