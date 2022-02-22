#!/bin/sh

if [ $# -eq 0 ]; then
	echo "You need to specifiy an argument"
	exit
fi

if [ $1 == "on" ]; then
sed -i 's/#//g' /etc/hosts 
elif [ $1 == "off" ]; then
if grep youtube /etc/hosts | grep '#' ; then 
echo "YouTube Block already turned off"
else 
	sed -i '/youtube/s/^/#/' /etc/hosts
fi
fi
