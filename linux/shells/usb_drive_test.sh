#!/bin/sh

CHECK_RST=`ls /dev/sda1`
if [[ "$CHECK_RST" == "" ]];then
        echo no usb drive found
        exit
fi

CHECK_RST=`mount | grep sda1`
if [[ "$CHECK_RST" == "" ]];then
	echo usb drive found but not mount
	exit
fi

echo "usb drive test" > /run/media/sda1/.usb_drive_test
CHECK_RST=`cat /run/media/sda1/.usb_drive_test`
if [[ "$CHECK_RST" == "usb drive test" ]];then
        echo usb drive is working and mount at /run/media/sda1
fi
rm -f /run/media/sda1/.usb_drive_test



