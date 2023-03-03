#!/bin/sh

value=$(cat /sys/bus/i2c/devices/1-0050/eeprom | head -n 1)
echo $value
if [ "$value" == "test e2prom" ];then
	echo -e "\e[1;33mIf you call this shell for the first time after cold restarting\e[0m, \e[1;32meeprom is OK\e[0m."
else
	echo -e "test e2prom\n" > /sys/bus/i2c/devices/1-0050/eeprom
	sync
	echo -e "\e[1;33mIf this is not the first time to use this shell\e[0m, \e[1;31meeprom is NG\e[0m."
	echo -e "\e[1;33mOtherwise, please call this shell again after cold restarting the board to test whether eeprom is working\e[0m."
fi

