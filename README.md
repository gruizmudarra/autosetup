# autosetup
Auto setup is a simple bash script (compatible with Debian-based distributions like Ubuntu and Kali) to install and set up necessary software/tools after doing Fresh Install.

> The script is completely based on the apps I use regularly to develop in Linux, like Discord, Chrome, ROS, VSCode, etc.
> You can modify it according to your need.

## Usage

```bash
git clone https://github.com/shubhampathak/autosetup.git
cd autosetup
chmod +x autosetup.sh
./autosetup.sh
```
## Structure

The script will show a dialogbox (whiptail), where you can select the software(s) you want to install. 

But, before opening the dialogbox, it'll perform the following operations:

1. Install snap, curl, wget, dns-utils, adb and fastboot.
2. Setup Git Global Config. (It'll ask for your name and email)*
3. Install all the required dependencies needed for the list of tools.

**You can skip 2 if you want.*

## List

* Visual Studio Code
* Python3, virtualenv, pip3
* Chromium
* Wireshark
* Virtual Box
* ROS Melodic
* ROS Noetic
* Spotify
* Discord

## To-add
* OBS
* Freecad

* Ask to change touchpad settings when laptop (natural vert and horiz scrolling)
* Plank (download theme and set fixed icons)
* Set theme `xfconf-query -c xsettings -p /Net/ThemeName -s "Sweet-mars-v40"`
* Set window manager theme `xfconf-query -c xfwm4 -p /general/theme -s "Sweet-mars-v40"`
* Set font 
```bash
# Pull font and unpack it
curl -L -O https://github.com/source-foundry/Hack/releases/download/v3.003/Hack-v3.003-ttf.tar.gz

tar -xzvf Hack-v3.003-ttf.tar.gz
# Create (if not created) the user level font folder
mkdir ~/.local/share/fonts

# Move it to that folder
mv ttf/Hack-Regular.ttf ~/.local/share/fonts/Hack-Regular.ttf
mv ttf/Hack-Italic.ttf ~/.local/share/fonts/Hack-Italic.ttf
mv ttf/Hack-Bold.ttf ~/.local/share/fonts/Hack-Bold.ttf
mv ttf/Hack-BoldItalic.ttf ~/.local/share/fonts/Hack-BoldItalic.ttf

# Regenerate font cache
fc-cache -f -v

# Check
fc-list | grep "Hack"

# Set it 
xfconf-query -c xsettings -p /Gtk/FontName -s "Hack"
# Set monospace font
xfconf-query -c xsettings -p /Gtk/MonospaceFontName -s "Monospace"
```




