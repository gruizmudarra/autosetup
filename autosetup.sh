#!/bin/bash

##################################################################################################
# Original author: Shubham Pathak                                                                #
# Edited by: Germán Ruiz-Mudarra 																 #
# Description: Auto setup bash script to setup required programs after doing fresh install.      # 
# Tested against Debian based distributions like Ubuntu and Kali Linux.                          #        
##################################################################################################

c='\e[32m' # Coloured echo (Green)
y=$'\033[38;5;11m' # Coloured echo (yellow)
r='tput sgr0' #Reset colour after echo

#Display Banner
if [[ ! -z $(which figlet) ]]; then
    figlet AutoSetup
    echo -e "${y} - By German Ruiz-Mudarra"
else 
echo -e "\n\n\n\n
    _         _       ____       _
   / \  _   _| |_ ___/ ___|  ___| |_ _   _ _ __
  / _ \| | | | __/ _ \___ \ / _ \ __| | | | '_ |
 / ___ \ |_| | || (_) |__) |  __/ |_| |_| | |_) |
/_/   \_\__,_|\__\___/____/ \___|\__|\__,_| .__/
                                          |_| 
						  - By German Ruiz-Mudarra\n\n\n"
fi

# 3 seconds wait time to start the setup
for i in `seq 3 -1 1` ; do echo -ne "$i\rThe setup will start in... " ; sleep 1 ; done

# Required dependencies for all softwares (important)
echo -e "${c}Installing complete dependencies pack."; $r
sudo apt install -y software-properties-common apt-transport-https build-essential checkinstall libncursesw5-dev libssl-dev libsqlite3-dev tk-dev libc6-dev libbz2-dev autoconf automake libtool make g++ unzip flex bison gcc libyaml-dev libreadline-dev zlib1g zlib1g-dev libncurses5-dev libffi-dev libgdbm-dev libpq-dev libpcap-dev libmagickwand-dev libcurl4 libcurl4-openssl-dev mlocate imagemagick xdg-utils

# Show Battery Percentage on Top Bar [Debian (gnome)]
if [[ $XDG_CURRENT_DESKTOP =~ 'GNOME' ]]; then
	gsettings set org.gnome.desktop.interface show-battery-percentage true
fi

# Upgrade and Update Command
echo -e "${c}Updating and upgrading before performing further operations."; $r
sudo apt update && sudo apt upgrade -y
sudo apt --fix-broken install -y

#Setting up Git
read -p "${y}Do you want to setup Git global config? (y/n): " -r; $r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
	echo -e "${c}Setting up global git config at ~/.gitconfig"; $r
	git config --global color.ui true
	read -p "Enter Your Full Name: " name
	read -p "Enter Your Email: " email
	git config --global user.name "$name"
	git config --global user.email "$email"
	echo -e "${c}Git Setup Successfully!"; $r
else
	echo -e "${c}Skipping!"; $r && :
fi

#Installing curl and wget
echo -e "${c}Installing Curl and wget"; $r
sudo apt-get install -y wget curl

#Installing dig and net-tools
echo -e "${c}Installing DNS Utils and net-tools"; $r
sudo apt install -y dnsutils net-tools

#Installing ADB and Fastboot
#echo -e "${c}Installing ADB and Fastboot"; $r
#sudo apt install -y android-tools-adb android-tools-fastboot

#Creating Directory Inside $HOME
echo -e "${c}Creating Directory named 'tools' inside $HOME directory."; $r
cd
mkdir -p tools



installPython3() {
	sudo apt install -y python3
	echo -e "${c}Installing pip and ipython"; $r
	sudo apt install -y python3-pip python3-setuptools
	sudo pip install ipython
	echo -e "${c}Installing development environment and virtualenv for Python"; $r
	sudo apt install -y build-essential libssl-dev libffi-dev python3-dev python3-venv
}

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

installCode() {
	sudo snap install code --classic
}

installChromium() {
	sudo apt install chromium-browser
}

installROSMelodic() {
	sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'	
	curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add -
	sudo apt update
	sudo apt install ros-melodic-desktop-full
	
	read -p "${y}Using zsh? (y/n): " -r; $r
	echo
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		echo -e "${c}Setting up ROS in the .zshrc"; $r
		echo "source /opt/ros/noetic/setup.zsh" >> ~/.zshrc
		source ~/.zshrc
	else
		echo -e "${c}Setting up ROS in the .bashrc"; $r
		echo "source /opt/ros/noetic/setup.bash" >> ~/.bashrc
		source ~/.bashrc
	fi
	
	sudo apt install python-rosdep python-rosinstall python-rosinstall-generator python-wstool build-essential	sudo 
	rosdep init
	rosdep update
}

installROSNoetic() {
	sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
	curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add -
	sudo apt update
	sudo apt install ros-noetic-desktop-full
	
	read -p "${y}Using zsh? (y/n): " -r; $r
	echo
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		echo -e "${c}Setting up ROS in the .zshrc"; $r
		echo "source /opt/ros/noetic/setup.zsh" >> ~/.zshrc
		source ~/.zshrc
	else
		echo -e "${c}Setting up ROS in the .bashrc"; $r
		echo "source /opt/ros/noetic/setup.bash" >> ~/.bashrc
		source ~/.bashrc
	fi
	
	sudo apt install python3-rosdep python3-rosinstall python3-rosinstall-generator python3-wstool build-essential
	sudo rosdep init
	rosdep update
}

checkInstalled() {
	echo -e "${c}Checking if $1 is installed."; $r
	source ~/.profile
	source ~/.bashrc
	if [[ -z $(which $1) ]]; then
			echo -e "${c}$1 is not installed, installing it first."; $r
			$2
	else
			echo -e "${c}$1 is already installed, Skipping."; $r
	fi
}


#Executing Install Dialog
dialogbox=(whiptail --separate-output --ok-button "Install" --title "Auto Setup Script" --checklist "\nPlease select required software(s):\n(Press 'Space' to Select/Deselect, 'Enter' to Install and 'Esc' to Cancel)" 30 80 20)
options=(1 "Visual Studio Code" off
	2 "Python3, pip3, venv & iPython" off
	3 "Chromium" off
	4 "Wireshark" off
	5 "Virtual Box" off
	6 "ROS Melodic" off
	7 "ROS Noetic" off
	8 "Spotify" off
	9 "Discord" off)

selected=$("${dialogbox[@]}" "${options[@]}" 2>&1 >/dev/tty)

for choices in $selected
do
	case $choices in
		1) 
		echo -e "${c}Installing Visual Studio Code"; $r
		checkInstalled snap installSnap
		checkInstalled code installCode
		echo -e "${c}Visual Studio Code Installed Successfully."; $r
		;;

		2) 
		echo -e "${c}Installing Python3, Python3-pip and iPython"; $r
		checkInstalled python3 installPython3
		echo -e "${c}Python3 and others installed"; $r
		;;

		3) 
		echo -e "${c}Installing Chromium"; $r
		checkInstalled chromium-browser installChromium
		echo -e "${c}Chromium installed successfully"; $r
		;;

		4) 
		echo -e "${c}Installing Wireshark"; $r
		sudo apt install -y wireshark
		sudo dpkg-reconfigure wireshark-common 
		echo -e "${c}Adding user to wireshark group."; $r
		sudo usermod -aG wireshark $USER
		echo -e "${c}Wireshark installed successfully."; $r
		;;

		5)
		echo -e "${c}Installing VirtualBox"; $r
		sudo apt install -y virtualbox
		echo -e "${c}VirtualBox installed successfully"; $r
		;;

		6)
		echo -e "Installing ROS Melodic"; $r
		checkInstalled ros-melodic-desktop-full installROSMelodic
		echo -e "${c}ROS Melodic installed successfully"; $r
		;;

		7)
		echo -e "${c}Installing ROS Noetic"; $r
		checkInstalled ros-noetic-desktop-full installROSNoetic
		echo -e "${c}ROS Noetic installed successfully"; $r
		;;

		8)
		echo -e "${c}Installing Spotify"; $r
		sudo snap install spotify
		echo -e "${c}Spotify installed successfully"; $r
		;;

		9)
		echo -e "${c}Installing Discord"; $r
		sudo snap install discord
		echo -e "${c}Discord installed successfully"; $r
		;;

	esac
done

# Final Upgrade and Update Command
echo -e "${c}Updating and upgrading to finish auto-setup script."; $r
sudo apt update && sudo apt upgrade -y
sudo apt --fix-broken install -y