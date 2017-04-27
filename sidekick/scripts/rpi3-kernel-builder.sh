#!/bin/bash

function usage(){
	echo "Usage: $0 /dev/{sdX | mmcblkX} Kernel-Directory"
	echo "Example Usage: $0 /dev/mmcblk0 ~/raspberry-pi/linux"
	exit 1
}

function mount_sdcard(){
	echo "Mounting SD card partitions"
	# Setup Directories
	FAT=/mnt/fat32
	if [ ! -d "$FAT" ]; then
		sudo mkdir /mnt/fat32
	fi

	EXT=/mnt/ext4
	if [ ! -d "$EXT" ]; then
		sudo mkdir /mnt/ext4
	fi

	# Mount the SD card
	if [ $1 eq "mmc" ]; then
		sudo mount "$1p1" "$FAT"	# Partition 1
		sudo mount "$1p2" "$EXT"	# Partition 2
	else
		sudo mount "$11" "$FAT"
		sudo mount "$12" "$EXT"
	fi
}

function build_kernel(){
	echo "Do you wish overwrite existing config with the default one ?"
	select yn in "Yes" "No"; do
		case $yn in
			Yes ) make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- bcm2709_defconfig; break;;
			No  ) break;;
		esac
	done
	echo "Do you wish to customize the kernel ?"
	select yn in "Yes" "No"; do
		case $yn in
			Yes ) make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- menuconfig; break;;
			No  ) break;;
		esac
	done
	echo "Building Kernel, Device Tree Blobs and Modules"
	time make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- zImage modules dtbs
}

function install_modules(){
	echo "Installing modules into SD-card"
	time sudo make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- INSTALL_MOD_PATH=/mnt/ext4 modules_install
}

function copy_kernel(){
	echo "Copying zImage, dtb and dtb overlays"
	sudo cp "$FAT/$KERNEL.img" "$FAT/$KERNEL-backup.img"
	sudo cp arch/arm/boot/zImage "$FAT/$KERNEL.img"
	sudo cp arch/arm/boot/dts/*.dtb "$FAT"
	sudo cp arch/arm/boot/dts/overlays/*.dtb* "$FAT/overlays/"
	sudo cp arch/arm/boot/dts/overlays/README "$FAT/overlays/"
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

build_kernel
mount_sdcard "$1"
install_modules
copy_kernel

