#! /bin/bash
#
# Compiling glue lib

gcc -shared -o ${PWD}/integration/integration.so ${PWD}/integration/integration.c

# Compiling driver
cd ${PWD}/driver

if [ "$1" = "create" ]
then

	sudo mknod /dev/damas c 60 0
	sudo chmod 666 /dev/damas
else	
	make
	echo "Refreshing"
	sudo rmmod driver.ko
	sudo insmod driver.ko
fi
