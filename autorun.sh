#!/bin/sh
#if grep --quiet "alacritty" ps_output; 
#then notify-send "alacritty already opened"
#else alacritty &> /dev/null & disown $1
#alacritty &> /dev/null & disown $1
#fi
alacritty_instances=$(echo $(ps -e) | grep -o "alacritty" | wc -l) 

if [ $alacritty_instances -eq 0 ]; then 
alacritty -e bash -c 'neofetch && bash' --hold &> /dev/null & disown $!
sleep 0.1
alacritty &> /dev/null & disown $!
fi

if [ $alacritty_instances -eq 1 ]; then 
alacritty &> /dev/null & disown $! 
fi

if [ $alacritty_instances -eq 2 ]; then
notify-send "Alacritty is already opened 2x"
fi

# Enable numlock on boot
numlockx on
