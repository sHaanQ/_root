#!/bin/bash


 arm-none-eabi-gcc -mcpu=arm1176jzf-s -fpic -ffreestanding -std=gnu99 -c kernel.c -o kernel.o -O2 -Wall -Wextra
 arm-none-eabi-gcc -mcpu=arm1176jzf-s -fpic -ffreestanding -std=gnu99 -c base64.c -o base64.o -O2 -Wall -Wextra
 arm-none-eabi-gcc -mcpu=arm1176jzf-s -fpic -ffreestanding -std=gnu99 -c ascii_hex.c -o ascii_hex.o -O2 -Wall -Wextra
 arm-none-eabi-gcc -T linker.ld -o myos.elf -ffreestanding -O2 -nostdlib boot.o kernel.o base64.o ascii_hex.o
 arm-none-eabi-objcopy myos.elf -O binary myos.bin
 cp myos.bin /media/bhargav/boot/kernel.img
 ls -l  /media/bhargav/boot/kernel.img
 umount /media/bhargav/*
 sync



