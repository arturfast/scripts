#!/bin/bash
IFS=$'\n'
index=$(pacmd list-sinks | grep "index:" | awk '{print $3}')
sinks=( $(echo $index) )

for i in $sinks
do
pacmd set-sink-volume $i 1000000
echo asdasd
done

function whatever {
 
for j in $sinks
do
pacmd set-sink-volume $j 0x10000
done
 
kill 0
}

trap whatever INT 

mpv "./siren.mp3" &
mpv "./siren.mp3" &
mpv "./siren.mp3" 

# aplay /dev/urandom &
# aplay /dev/urandom &
# aplay /dev/urandom &
# aplay /dev/urandom &
# aplay /dev/random


