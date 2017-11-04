#!/bin/bash

# Error Logger
# https://gist.github.com/aguy/2359833

set -o errexit # exit on errors
set -o errtrace # inherits trap on ERR in function and subshell

trap 'traperror $? $LINENO $BASH_LINENO "$BASH_COMMAND" $(printf "::%s" ${FUNCNAME[@]:-})' ERR
trap 'trapexit $? $LINENO' EXIT

function trapexit() {
  echo "$(date) $(hostname) $0: EXIT on line $2 (exit status $1)"
}

function traperror () {
    local err=$1 # error status
    local line=$2 # LINENO
    local linecallfunc=$3
    local command="$4"
    local funcstack="$5"
    echo "$(date) $(hostname) $0: ERROR '$command' failed at line $line - exited with status: $err" 

    if [ "$funcstack" != "::" ]; then
      echo -n "$(date) $(hostname) $0: DEBUG Error in ${funcstack} "
      if [ "$linecallfunc" != "" ]; then
        echo "called at line $linecallfunc"
      else
        echo
      fi
    fi
    echo "'$command' failed at line $line - exited with status: $err"
	echo "Un-mounting card"
	sudo umount "$FAT"
	sudo umount "$EXT"
}

function log() {
    local msg=$1
    now=$(date)
    i=${#FUNCNAME[@]}
    lineno=${BASH_LINENO[$i-2]}
    file=${BASH_SOURCE[$i-1]}
    echo "${now} $(hostname) $0:${lineno} ${msg}"
}

# Error Logger Ends

function usage(){
	echo "Usage: $0 /dev/{sdX | mmcblkX} Kernel-Directory"
	echo "Example Usage: $0 /dev/mmcblk0 ~/raspberry-pi/linux"
	exit 1
}

function mount_sdcard(){
	echo "--------------------------------------------------------------------"
	echo "Mounting SD card partitions"
	echo "--------------------------------------------------------------------"
	# Setup Directories
	FAT=/tmp/fat32

	if [ ! -d "$FAT" ]; then
		mkdir /tmp/fat32
	fi

	EXT=/tmp/ext4
	if [ ! -d "$EXT" ]; then
		mkdir /tmp/ext4
	fi

	# Mount the SD card
	if [[ $1 == *"mmc"* ]]; then
		sudo mount "$1p1" "$FAT"	# Partition 1
		sudo mount "$1p2" "$EXT"	# Partition 2
	else
		sudo mount "$11" "$FAT"
		sudo mount "$12" "$EXT"
	fi
}

function build_kernel(){
	echo "--------------------------------------------------------------------"
	echo "Do you wish overwrite existing config with the default one ?"
	echo "--------------------------------------------------------------------"
	select yn in "Yes" "No"; do
		case $yn in
			Yes ) make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- bcm2709_defconfig; break;;
			No  ) break;;
		esac
	done
	echo "--------------------------------------------------------------------"
	echo "Do you wish to customize the kernel ?"
	echo "--------------------------------------------------------------------"
	select yn in "Yes" "No"; do
		case $yn in
			Yes ) make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- menuconfig; break;;
			No  ) break;;
		esac
	done
	echo "--------------------------------------------------------------------"
	echo "Building Kernel, Device Tree Blobs and Modules"
	echo "--------------------------------------------------------------------"	
	
	time make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- zImage modules dtbs
	if [ $? -eq 0 ]; then
    	echo "======================="
    	echo "BUILD SUCCESSFULL..."
    	echo "======================="
    else
    	echo "***********************"
    	echo "BUILD FAILED !!"
    	echo "Check error log"
    	echo "***********************"
    	exit 1
    fi

}

function install_modules(){
	echo "--------------------------------------------------------------------"
	echo "Installing modules into SD-card"
	echo "--------------------------------------------------------------------"
	time sudo make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- INSTALL_MOD_PATH=/tmp/ext4 modules_install
}

function copy_kernel(){
	echo "--------------------------------------------------------------------"
	echo "Copying zImage, dtb and dtb-overlays"
	echo "--------------------------------------------------------------------"
	sudo cp "$FAT/$KERNEL.img" "$FAT/$KERNEL-backup.img"
	sudo cp arch/arm/boot/zImage "$FAT/$KERNEL.img"
	sudo cp arch/arm/boot/dts/*.dtb "$FAT"
	sudo cp arch/arm/boot/dts/overlays/*.dtb* "$FAT/overlays/"
	sudo cp arch/arm/boot/dts/overlays/README "$FAT/overlays/"
	ls -lth $FAT
	ls -lth $EXT
	sudo umount "$FAT"
	sudo umount "$EXT"

}

# RPi 3 kernel image name
KERNEL=kernel7

if [ -z "$1" ] || [ -z "$2" ]; then
	echo "SD card path or Kernel Source directory not specified"
	usage
	exit 1
fi

KDIR=$2
cd $KDIR

mount_sdcard "$1"
sleep 2
build_kernel
sleep 2
install_modules
sleep 2
copy_kernel
sleep 2

