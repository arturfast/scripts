#!/bin/bash
	if [[ $(bspc query -T --node focused | grep '"state":"fullscreen"') ]];
	then
		sed -i 's/opacity.*/opacity: 0.7/' ~/.config/alacritty/alacritty.yml
	else
		sed -i 's/opacity.*/opacity: 1/' ~/.config/alacritty/alacritty.yml
	fi
