#!/bin/bash

installPython3() {
	sudo apt install -y python3
	echo -e "${c}Installing pip and ipython"; $r
	sudo apt install -y python3-pip python3-setuptools
	sudo pip install ipython
	echo -e "${c}Installing development environment and virtualenv for Python"; $r
	sudo apt install -y build-essential libssl-dev libffi-dev python3-dev python3-venv
}

installCode() {
	sudo snap install code --classic
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

installKiCAD() {
	sudo add-apt-repository --yes ppa:kicad/kicad-6.0-releases
	sudo apt update
	sudo apt install --install-recommends kicad
}

installFreeCAD() {
	sudo apt-get install freecad
}

installFreeCADRT() {
	curl -L https://github.com/realthunder/FreeCAD_assembly3/releases/download/0.11/FreeCAD-asm3-Stable-Conda-Py3-Qt5-20211015-glibc2.12-x86_64.AppImage > FreeCAD-asm3-Stable-20211015-x86_64.AppImage
	
}
