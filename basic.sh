#!/bin/bash

installSnap() {
	#Snap Installation & Setup
	echo -e "${c}Installing Snap & setting up."; $r
	sudo apt install -y snapd
	sudo systemctl start snapd
	sudo systemctl enable snapd
	sudo systemctl start apparmor
	sudo systemctl enable apparmor
	export PATH=$PATH:/snap/bin
	sudo snap refresh
}

installChromium() {
	sudo apt install chromium-browser
}

installVirtualbox() {
	sudo apt install virtualbox
}