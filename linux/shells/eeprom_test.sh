#!/bin/sh

value=$(cat /sys/bus/i2c/devices/1-0050/eeprom | head -n 1)
echo $value
if [ "$value" == "test e2prom" ];then
	echo If you call this shell for the first time after cold restarting, eeprom is OK.
else
	echo -e "test e2prom\n" > /sys/bus/i2c/devices/1-0050/eeprom
	echo 3 > /proc/sys/vm/drop_caches 
	echo If this is not the first time to use this shell, eeprom is NG.
	echo Otherwise, please call this shell again after cold restarting the board to test whether eeprom is working.
fi

