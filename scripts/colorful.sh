#!/bin/sh

#sed -i "s/colorscheme.*/colorscheme default/"  ~/.config/nvim/init.vim
sed -i 's#themes/.*#themes/colorful/theme.lua")#' /home/artur/.config/awesome/rc.lua
sed -i "/Markierung1/c\colors: *dracula # Markierung1" ~/.config/alacritty/alacritty.yml
sed -i "s/opacity:.*/opacity: 0.7/" ~/.config/alacritty/alacritty.yml
notify-send "Your theme has been changed to colorful"

if ! grep '"picom"' ~/.config/awesome/rc.lua; 
then
sed -i '/Markierung 1/a "picom",' ~/.config/awesome/rc.lua;
fi

echo 'awesome.restart()' | awesome-client

 
