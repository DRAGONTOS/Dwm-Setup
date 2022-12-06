#!/bin/sh
		## Removing files
	rm -rf ~/.xinitrc
		## Copying files
	cp -r ~/.config/Dwm-Setup/picom ~/.config &
	cp -r ~/.config/Dwm-Setup/.xinitrc ~/.xinitrc &
	cp -r ~/.config/Dwm-Setup/sxhkd ~/.config &
	cp -r scripts/sysact.sh ~/.local/bin/ &
