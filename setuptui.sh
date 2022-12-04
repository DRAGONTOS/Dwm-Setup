#!/bin/sh

# Dwm Auto Setup Script.
# by Kaley Fischer <koningdragon@gmail.com>
# License: GNU GPLv3

###         ###
## FUNCTIONS ##
###         ###

installpkg() {
	pacman --noconfirm --needed -S "$1" >/dev/null 2>&1
}

error() {
	# Log to stderr and exit with failure.
	printf "%s\n" "$1" >&2
	exit 1
}

welcomemsg() {
	whiptail --title "Welcome!" \
		--msgbox "Welcome to Kaley's Auto Setup Script!\\n\\nThis script will automatically install all dependencies, and will build all Suckless Utils." 10 60

	whiptail --title "Important Note!" --yes-button "All ready!" \
		--no-button "Return..." \
		--yesno "This will delete all Pre-Existing Dwm & Dmenu configs." 8 70
}

gettingrequiredpkgs() {
	whiptail --title "Installing Required pkgs!" --yes-button "Continue" \
		--no-button "Exit" \
		--yesno "This will install all needed pkgs" 8 70
		## pkgs
	pacman -R --noconfirm dmenu &
	pacman -S --noconfirm sxhkd &
	yay -S --noconfirm picom-tryone-git &
}

copyfiles() {
	whiptail --title "Copying files!" --yes-button "Continue" \
		--no-button "Exit" \
		--yesno "This will copy all Required files." 8 70
		## Deleting files
	rm -rf ~/.xinitrc
		## Copying files
	cp -r ~/.config/Dwm-Setup/picom ~/.config &
	cp -r ~/.config/Dwm-Setup/.xinitrc ~/.xinitrc &
	cp -r ~/.config/Dwm-Setup/sxhkd ~/.config &
}

makepkgs() {
	whiptail --title "Making pkgs!" --yes-button "Continue" \
		--no-button "Exit" \
		--yesno "This will compile all pkgs." 8 70
	cd ~/.config/Dwm-Setup/dwm && sudo make clean install >/dev/null 2>&1 &
	cd ~/.config/Dwm-Setup/dmenu && sudo make clean install >/dev/null 2>&1 &
	cd ~/.config/Dwm-Setup/dwmblocks && sudo make clean install >/dev/null 2>&1 &
}

success() {
	whiptail --title "Success!" \
		--msgbox "All is done!" 10 60
}

# Welcome user.
welcomemsg || error "User exited."

# Installing Required pkgs.
gettingrequiredpkgs || error "User exited."

# Copying Required files.
copyfiles || error "User exited."

# Making pkgs.
makepkgs || error "User exited."

# Success.
success || error "User exited."
