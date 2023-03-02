#!/bin/sh

CHECK_RST=`ls /dev/sda1`
if [[ "$CHECK_RST" == "" ]];then
	echo -e "\e[1;31mno usb drive found\e[0m"
        exit
fi

CHECK_RST=`mount | grep sda1`
if [[ "$CHECK_RST" == "" ]];then
	echo -e "\e[1;33musb drive found but not mount\e[0m"
	exit
fi

echo "usb drive test" > /run/media/sda1/.usb_drive_test
CHECK_RST=`cat /run/media/sda1/.usb_drive_test`
if [[ "$CHECK_RST" == "usb drive test" ]];then
	echo -e "\e[1;32musb drive is working and mount at /run/media/sda1\e[0m"
fi
rm -f /run/media/sda1/.usb_drive_test



