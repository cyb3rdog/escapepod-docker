#!/bin/bash

# Place this script to same location as your 'escape-pod-6ab70e5-R1.img.xz' file
# In case the image file will not be found in the same directory as this script,
# this script will download and extract the image by itself before mounting it.
# Once done, you can access your EscapePod filesystem in VAR_MOUNT (/mnt/escape-pod),
# you can symlink the targets, or copy the required files wherever you want to.
# You'll be most probably interrested in /mnt/escape-pod/usr/local/escapepod/
# Enjoy.

VAR_IMAGE_URL="https://assets.digitaldreamlabs.com/PEavApG5dgnZA5ei/Escape-Pod-Release-1.0.0/escape-pod-6ab70e5-R1.img.xz"
VAR_IMAGE_XZ="escape-pod-6ab70e5-R1.img.xz"
VAR_MOUNT="/mnt/escape-pod"
VAR_LOOP=""

echo "--- Escape Pod Image Mount Script --- "

if [ ! -f $VAR_IMAGE_XZ ]
then
    echo "Downloading '$VAR_IMAGE_URL'..."
    wget $VAR_IMAGE_URL
fi

VAR_IMAGE=${VAR_IMAGE_XZ/.xz/}
if [ ! -f $VAR_IMAGE ]
then
    echo "Extracting '$VAR_IMAGE_XZ' to '$VAR_IMAGE'..."
    unxz -v $VAR_IMAGE_XZ
fi

echo "Image path:  '$VAR_IMAGE'"
echo "Mount point: '$VAR_MOUNT'"

test -f $VAR_IMAGE && echo "OK. Image file ready." || echo "FAILED. Image file not found!"
test -f $VAR_IMAGE || exit

echo ""
echo "Mounting '$VAR_IMAGE' to '$VAR_MOUNT'..."

sudo mkdir -p $VAR_MOUNT

sudo modprobe loop
VAR_LOOP=$(sudo losetup -f)

echo "Setting up Loop Device '$VAR_LOOP'..."
sudo losetup -P $VAR_LOOP ./$VAR_IMAGE

echo "Probing '$VAR_LOOP' for partitions..."
sudo partprobe $VAR_LOOP

echo "Mounting '${VAR_LOOP}p2' to '$VAR_MOUNT'..."
sudo mount "${VAR_LOOP}p2" "$VAR_MOUNT"

echo "Done."
echo ""

echo "- To unmount, call this command:"
echo "sudo umount $VAR_MOUNT"
echo "- To delete the loop device, call this one:"
echo "sudo losetup -d ${VAR_LOOP}"
