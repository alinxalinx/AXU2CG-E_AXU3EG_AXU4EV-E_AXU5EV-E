#!/bin/sh

#write some words to file
echo "qspiflashtest" > /home/root/.qspiflashwrite
#erase flash first block
flash_erase /dev/mtd0 0 1 > /dev/null 2>&1
#write file to qspiflash
dd of=/dev/mtd0 if=/home/root/.qspiflashwrite bs=4096 count=1 > /dev/null 2>&1
#read qspiflash to file
dd if=/dev/mtd0 of=/home/root/.qspiflashread  bs=4096 count=1 > /dev/null 2>&1
#read words from file
READFILE=`cat /home/root/.qspiflashread | head -n 1`
echo $READFILE
#check result
if [[ "$READFILE" == "qspiflashtest" ]];then
	echo -e "\e[1;32mqspiflash is OK\e[0m"
else
	echo -e "\e[1;31mqspiflash is NG\e[0m"
fi
rm /home/root/.qspiflash*
