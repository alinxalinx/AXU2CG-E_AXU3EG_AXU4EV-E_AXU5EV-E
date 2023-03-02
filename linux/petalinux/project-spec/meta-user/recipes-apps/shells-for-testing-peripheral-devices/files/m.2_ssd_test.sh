#!/bin/bash

DEVICE=/dev/nvme0n1
DEVICE_NAME=${DEVICE##/dev/}p1
DEVICE_SECTOR="$DEVICE"p1

#check nvme device
if [ ! -e "$DEVICE" ];then
	echo no nvme device found 
	exit
fi

#check sector
CHECK_RST=`ls $DEVICE_SECTOR`
if [[ "$CHECK_RST" != "$DEVICE_SECTOR" ]];then
	#fdisk set sector
	echo "n
p
1


w
" | fdisk $DEVICE
	
	#mkfs.ext4 set fs
	echo "y

" | mkfs.ext4 $DEVICE_SECTOR
	echo -e "\e[1;32mset SSD sector OK, add one sector $DEVICE_SECTOR\e[0m"
else
	echo -e "\e[1;33mSSD already have a sector $DEVICE_SECTOR\e[0m"
fi

#check mount
CHECK_RST=`mount | grep $DEVICE_SECTOR`
if [ "$CHECK_RST" != "" ];then
	umount $DEVICE_SECTOR
fi
mkdir -p /run/media/$DEVICE_NAME
mount $DEVICE_SECTOR /run/media/$DEVICE_NAME
echo -e "\e[1;32mSSD mount to /run/media/$DEVICE_NAME OK\e[0m"

echo "ssd test" > /run/media/$DEVICE_NAME/.ssd_test
CHECK_RST=`cat /run/media/$DEVICE_NAME/.ssd_test`
if [[ "$CHECK_RST" == "ssd test" ]];then
	echo -e "\e[1;32mssd read write OK\e[0m"
else
	echo -e "\e[1;31mssd read write NG\e[0m"
fi
rm -f /run/media/$DEVICE_NAME/.ssd_test

