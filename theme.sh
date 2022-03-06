#!/bin/bash

installMarsTheme() {
	curl -L -O https://github.com/source-foundry/Hack/releases/download/v3.003/Hack-v3.003-ttf.tar.gz
	tar -xzvf Hack-v3.003-ttf.tar.gz
	sudo cp -r ~/Downloads/Flat-Remix-GTK_2.8 /usr/share/themes/

}

installFonts() {
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

	# Set it 
	xfconf-query -c xsettings -p /Gtk/FontName -s "Hack"
	# Set monospace font
	xfconf-query -c xsettings -p /Gtk/MonospaceFontName -s "Monospace"

}