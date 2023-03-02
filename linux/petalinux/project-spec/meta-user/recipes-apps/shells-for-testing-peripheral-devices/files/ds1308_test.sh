#!/bin/sh

#check arguments
ARGUMENT1="$1"
TIMETOSET="2023-03-01 10:30:00"
if [[ "$ARGUMENT1" == "" ]];then
	echo -e "\e[1;33mYou can input the time you want to set in RTC as a parameter as follow:\e[0m"
	echo -e "\e[1;34m./ds1308_test.sh 2023-03-01 10:30:00\e[0m"
	echo -e "\e[1;33mIf you do not enter parameter, the default setting time is '2023-03-01 10:30:00'\e[0m."
elif [[ ${#ARGUMENT1} -eq ${#TIMETOSET} ]] && [[ $ARGUMENT1 == *-*-*:*:* ]];then
	TIMETOSET=$ARGUMENT1
	echo -e "\e[1;33m$TIMETOSET will be set to rtc0(ds1308)\e[0m."
	echo
fi

#set system date
date --set="$TIMETOSET"
#write date to rtc	
hwclock -f /dev/rtc0 -w
#read rtc to check if rtc is OK       
url1=`hwclock -f /dev/rtc0 -r`
url2=`hwclock -f /dev/rtc0 -r`
url1=`echo $url1 | awk -F: '{print $3}'`
url1=${url1%%.*}
url2=`echo $url2 | awk -F: '{print $3}'`
url2=${url2%%.*}
let url1=${url1}+1
if [ $url1 -eq $url2 ];then
	echo -e "\e[1;32mds1308 is OK\e[0m."
else
	echo -e "\e[1;31mds1308 is NG\e[0m."
fi 

