#!/bin/bash

# Remove following files/dirs

function usage(){
	echo "Usage: $0 kernel-version"
	echo "Ex: $0 4.6"
	exit 1
}

function cleanup(){

	local VERSION=$1
	sudo echo "Cleaning all $VERSION version's of linux"

	echo "boot/vmlinux"
	sudo rm /boot/vmlinuz-$VERSION*
	if [ $? -eq 0 ]; then echo CLEANED; else echo SKIPPED; fi

	echo "boot/initrd.img"
	sudo rm /boot/initrd.img-$VERSION*
	if [ $? -eq 0 ]; then echo CLEANED; else echo SKIPPED; fi

	echo "boot/System.map"
	sudo rm /boot/System.map-$VERSION*
	if [ $? -eq 0 ]; then echo CLEANED; else echo SKIPPED; fi

	echo "boot/config"
	sudo rm /boot/config-$VERSION*
	if [ $? -eq 0 ]; then echo CLEANED; else echo SKIPPED; fi

	echo "lib/modules"
	if [ -d /lib/modules/$VERSION* ]; then
		sudo rm -rf /lib/modules/$VERSION* 
		echo CLEANED
	else 
		echo SKIPPED
		break
	fi
		
	echo "updating grub"
	sudo update-grub
}

if [ -z "$1" ]; then
	echo "No argument supplied"
	usage
	exit 1
fi 

while true; do
    read -p "This script can brick ur system, Do you wish to continue? " yn
    case $yn in
        [Yy]* ) cleanup "$1"; break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done

