#!/bin/sh

if [ $(xmodmap -pke | grep 66 | grep -c VoidSymbol) -ge 1 ];
then
xmodmap -e 'keycode 66 = Escape';
notify-send "The caps key has been switched to Escape"
echo "VOidSymboL";
elif [ $(xmodmap -pke | grep 66 | grep -c Escape) -ge 1 ];
then
xmodmap -e 'keycode 66 = VoidSymbol';
notify-send "The caps key has been switched to VoidSymbol"
fi
