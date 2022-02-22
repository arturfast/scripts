#!/bin/sh

#sed -i "s/colorscheme.*/colorscheme peachpuff/" ~/.config/nvim/init.vim
sed -i 's#themes/.*#themes/nord/theme.lua")#' /home/artur/.config/awesome/rc.lua
sed -i "/Markierung1/c\colors: *nord # Markierung1" ~/.config/alacritty/alacritty.yml
sed -i "s/window.opacity:.*/window.opacity: 1/" ~/.config/alacritty/alacritty.yml
sed -i "s/.*picom.*//" ~/.config/awesome/rc.lua
sed -i 's#.*theme:.*#	theme: "/themes/coodos.rasi";#' ~/.config/rofi/config.rasi
echo 'awesome.restart()' | awesome-client
killall picom
notify-send "Your colorscheme has been changed to grey"
