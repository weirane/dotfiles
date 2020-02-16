#!/bin/sh

# Use rofi to choose a partition to mount

chosen=$(lsblk -rnpo "label,name,size,type,mountpoint" |
    sed 's/^ /NoLabel /' |
    awk '/part $/ && !/WINRE_DRV/ { printf "%s %s (%s)\n",$2,$1,$3 }' |
    rofi -dmenu -no-custom -i -p "Mount which drive?" |
    cut -d' ' -f1)

if [ $? = 0 ] && [ -n "$chosen" ]; then
    msg=$(udisksctl mount -b "$chosen" 2>&1)
    notify-send '💻 Mount' "$msg"
else
    echo "Abort"
fi
