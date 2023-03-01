#!/bin/sh

#set speed
SPEED=9600
stty -F /dev/ttyS1 ispeed $SPEED ospeed $SPEED cs8
stty -F /dev/ttyS2 ispeed $SPEED ospeed $SPEED cs8

#set up 485_de gpio
#gpiochip507 is DE port for /dev/ttyS2
echo 507 >> /sys/class/gpio/export > /dev/null 2>&1
echo out >> /sys/class/gpio/gpio507/direction
#gpiochip508 is DE port for /dev/ttyS1
echo 508 >> /sys/class/gpio/export > /dev/null 2>&1
echo out >> /sys/class/gpio/gpio508/direction

#/dev/ttyS1 send /dev/ttyS2 receive
echo 0 >> /sys/class/gpio/gpio508/value
echo 1 >> /sys/class/gpio/gpio507/value
cat /dev/ttyS2 > /home/root/.ttyS2_tmp & 
echo -e "rs485 S1 send S2 receive test" >> /dev/ttyS1
TTYS2_DATA=`cat /home/root/.ttyS2_tmp | head -n 1`
if [ "$TTYS2_DATA" == "rs485 S1 send S2 receive test" ];then
	echo "/dev/ttyS1 send /dev/ttyS2 receive OK"
else 
	echo "/dev/ttyS1 send /dev/ttyS2 receive NG"
fi
killall cat
rm /home/root/.ttyS2_tmp

#/dev/ttyS2 send /dev/ttyS1 receive
echo 0 >> /sys/class/gpio/gpio507/value
echo 1 >> /sys/class/gpio/gpio508/value
cat /dev/ttyS1 > /home/root/.ttyS1_tmp &
echo -e "rs485 S2 send S1 receive test" >> /dev/ttyS2
TTYS1_DATA=`cat /home/root/.ttyS1_tmp | head -n 1`
if [ "$TTYS1_DATA" == "rs485 S2 send S1 receive test" ];then
        echo "/dev/ttyS2 send /dev/ttyS1 receive OK"
else
        echo "/dev/ttyS2 send /dev/ttyS1 receive NG"
fi
killall cat
rm /home/root/.ttyS1_tmp

echo 0 >> /sys/class/gpio/gpio507/value
echo 0 >> /sys/class/gpio/gpio508/value


