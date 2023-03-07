#!/bin/sh

#check arguments
if [ "$1" != "" ];then
	IP_PING=$1
else
	IP_PING=www.google.com
fi

#disalbe ipv6
#sh -c 'echo 1 > /proc/sys/net/ipv6/conf/eth0/disable_ipv6'
#sh -c 'echo 1 > /proc/sys/net/ipv6/conf/eth1/disable_ipv6'

#set auto eth1
READLINE=`sed -n '19p' /etc/network/interfaces`
if [ "$READLINE" != "auto eth1" ];then
	echo -e "\e[1;33meth1 is not auto set\e[0m"
	echo -e "\e[1;33mnetwork will reset to setup eth1 and set eth1 auto start\e[0m"
	sed -i '19i auto eth1' /etc/network/interfaces
	
	#network restart
	/etc/init.d/networking restart
	#wait network restart
	TIMECNT=0
	while ((1))
	do
		READLINE_ETH0=`route | grep eth0 | grep -v default`
		READLINE_ETH1=`route | grep eth1 | grep -v default`
		if [ "$READLINE_ETH0" != "" ] && [ "$READLINE_ETH1" != "" ];then
			break
		fi
		let TIMECNT=${TIMECNT}+1
		if [ $TIMECNT -gt 60 ];then
			echo -e "\e[1;31mnetwork restart timeout\e[0m"
			exit
		else
			echo -e "network restarting \e[1;34m"$TIMECNT"s\e[0m ..." 
		fi
		sleep 1
	done
else
	echo -e "\e[1;32meth0 and eth1 set as auto start\e[0m"
fi


#set default gw
GW=`route | grep default`
GW=${GW##default         }
GW=${GW%% *}
while ((1))
do
	READLINE_DEF=`route | grep default`
	if [ "$READLINE_DEF" != "" ];then
		route del default
	else
		break
	fi
done
route add default gw $GW eth0
route add default gw $GW eth1
sleep 2

#check link speed
ETH0_SPEED=`ethtool eth0 | grep Speed`
ETH1_SPEED=`ethtool eth1 | grep Speed`

#check net
PING_ETH0=`ping -c 1 -I eth0 $IP_PING | grep " 0% packet loss"`
if [ "$PING_ETH0" != "" ];then
	echo -e "\e[1;32mETH0 access $IP_PING success. link$ETH0_SPEED\e[0m"
else
	echo -e "\e[1;31mETH0 can not access $IP_PING\e[0m"
fi
PING_ETH1=`ping -c 1 -I eth1 $IP_PING | grep " 0% packet loss"`
if [ "$PING_ETH1" != "" ];then
	echo -e "\e[1;32mETH1 access $IP_PING success. link$ETH0_SPEED\e[0m"
else
	echo -e "\e[1;31mETH1 can not access $IP_PING\e[0m"
fi

