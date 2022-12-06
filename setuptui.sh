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
	#Note
	whiptail --title "Important Note!" --yes-button "All ready!" \
		--no-button "Return..." \
		--yesno "This will delete all Pre-Existing Dwm & Dmenu configs." 8 70
}

gettingrequiredpkgs() {
    psw=$(whiptail --title "Installing Required pkgs!" --passwordbox "Enter your password and choose Ok to continue." 10 60 3>&1 1>&2 2>&3)
    #Password If
    exitstatus=$?
    if [ $exitstatus = 0 ]; then
        sudo -S <<< $psw sudo -s ./scripts/pacmaninstallremove.sh &
    else
        #Password If cancel
        whiptail --title "Cancel" --msgbox "Operation Cancel" 10 60
    fi

	#timer
    	for i in {1..100}; do
   		echo $i
   		sleep 0.2
	done | whiptail --gauge "Please Wait...." 10 50 0

	#AUR pkgs Installer
    	whiptail --title "Installing AUR pkgs!" --yes-button "Continue" \
	    --no-button "Exit" \
	    --yesno "This will install all needed AUR pkgs." 8 70
    	sh ./scripts/aurinstallremove.sh &

	#timer
    	for i in {1..100}; do
   		echo $i
   		sleep 0.2
	done | whiptail --gauge "Please Wait...." 10 50 0
}

copyfiles() {
	whiptail --title "Copying files!" --yes-button "Continue" \
		--no-button "Exit" \
		--yesno "This will copy all Required files." 8 70
		## Deleting files
	sh ./scripts/copy.sh &
}

makepkgs() {
    psw=$(whiptail --title "Making pkgs!" --passwordbox "Enter your password and choose Ok to continue." 10 60 3>&1 1>&2 2>&3)
    #Password If
    exitstatus=$?
    if [ $exitstatus = 0 ]; then
        sudo -S <<< $psw sudo -s ./scripts/make.sh &
    else
        #Password If cancel
        whiptail --title "Cancel" --msgbox "Operation Cancel" 10 60
    fi

	#timer
        for i in {1..100}; do
   		echo $i
   		sleep 0.15
	done | whiptail --gauge "Please Wait...." 10 50 0
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
