#!/bin/bash

VPNIP=$1
REALNIC=wlp3s0u2 #enp3s0u2
VPNNIC=tun0 #enp3s0u2 #tun0

function restore {

	iptables -P INPUT ACCEPT
	iptables -P FORWARD ACCEPT
	iptables -P OUTPUT ACCEPT
	iptables -F

	ip6tables -P INPUT ACCEPT
	ip6tables -P FORWARD ACCEPT
	ip6tables -P OUTPUT ACCEPT
	ip6tables -F

	echo "ip table has been restored"
	exit

}

function main {

iptables -F
iptables -P OUTPUT DROP
iptables -P INPUT DROP
iptables -P FORWARD DROP

# allow localhost
iptables -A INPUT --src 127.0.0.1 -j ACCEPT 
iptables -A OUTPUT -d 127.0.0.1 -j ACCEPT 
# allow loopback device
iptables -A INPUT -j ACCEPT -i lo
iptables -A OUTPUT -j ACCEPT -o lo
# allow local network traffic
iptables -A INPUT --src 192.168.0.1/24 -j ACCEPT 
iptables -A OUTPUT -d 192.168.0.1/24 -j ACCEPT 
# accept traffic from VPNIP via REALNIC
iptables -A INPUT -j ACCEPT -s $VPNIP -i $REALNIC
iptables -A OUTPUT -j ACCEPT -d $VPNIP -o $REALNIC
# Accept all traffic the VPN NIC makes. It's not a physical device so it can't connect to anything other than $REALNIC, hence no IP leaks.
iptables -A INPUT -j ACCEPT -i $VPNNIC
iptables -A OUTPUT -j ACCEPT -o $VPNNIC

echo "VPN set to: $VPNIP"

}

function phonemode {

	iptables -F
	iptables -P OUTPUT DROP
	iptables -P INPUT DROP
	iptables -P FORWARD DROP

	iptables -A INPUT --src 1.1.1.1 -j ACCEPT
	iptables -A OUTPUT -d 1.1.1.1 -j ACCEPT

	iptables -A INPUT --src $VPNIP -j ACCEPT
	iptables -A OUTPUT -d $VPNIP -j ACCEPT

}

function disableIPv6 {

echo 1 > /proc/sys/net/ipv6/conf/default/disable_ipv6
echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6 
echo "These must return 1 now:" 
cat /proc/sys/net/ipv6/conf/default/disable_ipv6 
cat /proc/sys/net/ipv6/conf/all/disable_ipv6 

ip6tables -F 
ip6tables -P OUTPUT DROP
ip6tables -P INPUT DROP
ip6tables -P FORWARD DROP

}

function retrieveIP {

	VPNIP=$(curl ip.me)

}

if [ "$1" = "restore" ]
then
	restore
elif [ "$1" = "main" ]
then
	disableIPv6
	retrieveIP
	main
elif [ "$1" = "phonemode" ]
then
	disableIPv6
	retrieveIP
	phonemode
else 
	echo "No option specified!"
fi
