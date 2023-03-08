#!/bin/sh

#set can up
ip link set can0 down
ip link set can1 down
ip link set can0 up type can bitrate 1000000
ip link set can1 up type can bitrate 1000000

#can receive and send
candump can0 > /home/root/.can0_tmp &
candump can1 > /home/root/.can1_tmp &
cansend can0 5A1#11.2233.4455
cansend can1 5A1#11.2233.4455
CAN0_READ=`cat /home/root/.can0_tmp | head -n 1`
CAN1_READ=`cat /home/root/.can1_tmp | head -n 1`
killall candump

#check receive and send result
#can0
if [ "$CAN0_READ" == "  can0  5A1   [5]  11 22 33 44 55" ];then
	echo -e "\e[1;32mCAN0 is OK\e[0m."
else
	echo -e "\e[1;31mCAN0 is error\e[0m."
fi
#can1
if [ "$CAN1_READ" == "  can1  5A1   [5]  11 22 33 44 55" ];then
        echo -e "\e[1;32mCAN1 is OK\e[0m."
else
        echo -e "\e[1;31mCAN1 is error\e[0m."
fi

#remove tmp
rm /home/root/.can0_tmp
rm /home/root/.can1_tmp


