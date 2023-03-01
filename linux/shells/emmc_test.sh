#!/bin/bash

DEVICE=/dev/mmcblk0
DEVICE_NAME=${DEVICE##/dev/}p1
DEVICE_SECTOR="$DEVICE"p1

#check nvme device
if [ ! -e "$DEVICE" ];then
	echo no emmc device found 
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
	echo "set emmc sector OK, add one sector $DEVICE_SECTOR"
else
	echo "emmc already have a sector $DEVICE_SECTOR"
fi

#check mount
CHECK_RST=`mount | grep $DEVICE_SECTOR`
if [ "$CHECK_RST" != "" ];then
	umount $DEVICE_SECTOR
fi
mkdir -p /run/media/$DEVICE_NAME
mount $DEVICE_SECTOR /run/media/$DEVICE_NAME
echo "emmc mount to /run/media/$DEVICE_NAME OK"


echo "emmc test" > /run/media/$DEVICE_NAME/.emmc_test
CHECK_RST=`cat /run/media/$DEVICE_NAME/.emmc_test`
if [[ "$CHECK_RST" == "emmc test" ]];then
        echo emmc read write OK
else
        echo emmc read write NG
fi
rm -f /run/media/$DEVICE_NAME/.emmc_test

