#!/bin/bash

# Copied from stackoverflow
function list_offspring {
  tp=`pgrep -P $1`          #get childs pids of parent pid
  for i in $tp; do          #loop through childs
    if [ -z $i ]; then      #check if empty list
      exit                  #if empty: exit
    else                    #else
      printf "$i\n"         #print childs pid
      list_offspring $i     #call list_offspring again with child pid as the parent
    fi;
  done
}

function toggle {

	isMuted=$(pacmd list-sink-inputs | grep -A5000 -m1 -e "index: $INDEX" | grep -m 1 "muted" | awk '{ print $2 }')
	echo $isMuted
if [ "$isMuted" = "no" ]; then
	pacmd set-sink-input-mute $INDEX true
	notify-send "Focused window muted"
else
	pacmd set-sink-input-mute $INDEX false
	notify-send "Focused window unmuted"
fi

}

ACTIVE_WINDOW=$(xprop -id `xdotool getwindowfocus` | grep '_NET_WM_PID' | awk '{ print $3 }')

for i in $(seq 1 $(pacmd list-sink-inputs | head -n 1 | awk '{ print $1}')); do	
INDEX=$(pacmd list-sink-inputs | grep "index:" | awk '{ print $2 }' | sed -n "$i"p)
TARGET_PID=$(pacmd list-sink-inputs | grep "application.process.id" | awk '{ print $3 }' | cut -d '"' -f2 | sed -n "$i"p)

CHILD_PIDS=$(list_offspring "$ACTIVE_WINDOW")

echo $ACTIVE_WINDOW
echo $INDEX
echo $TARGET_PID
echo PIDLIST:
echo $CHILD_PIDS

for j in $(seq 1 $(echo $CHILD_PIDS | wc -w)); do 

if [ "$TARGET_PID" = $(echo $CHILD_PIDS | awk -v j="$j" '{ print $j }') ]; then
	xdotool set_window $TARGET_PID "$(xdotool getwindowname $TARGET_PID) - MUTED"
	toggle
fi 
done

if [ "$TARGET_PID" = "$ACTIVE_WINDOW" ]; then
	toggle
fi 

done
