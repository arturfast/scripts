#!/bin/sh

# Dracula theme
#mv "/home/artur/.config/awesome/rc.lua" "/home/artur/.config/awesome/rc.lua_off"
#mv "/home/artur/.config/awesome/rc-dracula.lua" "/home/artur/.config/awesome/rc.lua"

sed -i 's#themes/.*/#themes/dracula/#' /home/artur/.config/awesome/rc.lua

sed -i "/Markierung1/c\colors: *dracula # Markierung1" ~/.config/alacritty/alacritty.yml

sed -i 's#.*theme:.*#	theme: "/themes/dracula.rasi";#' ~/.config/rofi/config.rasi

if ! grep '"picom"' ~/.config/awesome/rc.lua; 
then
sed -i '/Markierung 1/a "picom",' ~/.config/awesome/rc.lua;
fi

sed -i "s/opacity:.*/opacity: 0.7/" ~/.config/alacritty/alacritty.yml

#sed -i 's/colorscheme.*/colorscheme dracula/' ~/.config/nvim/init.vim

echo 'awesome.restart()' | awesome-client
