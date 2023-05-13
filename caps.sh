#!/bin/sh

# Using keycodes
if [ $(cat /etc/udev/hwdb.d/90-custom-keyboard.hwdb | grep -c esc) -ge 1 ];
then 
sudo sed -e "s/esc/kp5/g" -i /etc/udev/hwdb.d/90-custom-keyboard.hwdb
else
sudo sed -e "s/kp5/esc/g" -i /etc/udev/hwdb.d/90-custom-keyboard.hwdb
fi
sudo systemd-hwdb update && sudo udevadm trigger

# Old method, remaps keycodes to keysyms, but some programs ignore keysyms and listen to keycodes only

#if [ $(xmodmap -pke | grep 66 | grep -c VoidSymbol) -ge 1 ];
#then
#xmodmap -e 'keycode 66 = Escape';
#notify-send "The caps key has been switched to Escape"
#echo "VOidSymboL";
#elif [ $(xmodmap -pke | grep 66 | grep -c Escape) -ge 1 ];
#then
#xmodmap -e 'keycode 66 = VoidSymbol';
#notify-send "The caps key has been switched to VoidSymbol"
#fi
