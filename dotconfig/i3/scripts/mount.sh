#!/bin/sh

# Use rofi to choose a partition to mount

chosen=$(lsblk -rnpo "name,label,size,type,mountpoint" |
    awk '/part $/ && !/WINRE_DRV/ { printf "%s %s (%s)\n",$1,$2,$3 }' |
    rofi -dmenu -no-custom -i -p "Mount which drive?" |
    cut -d' ' -f1)

if [ $? = 0 ] && [ -n "$chosen" ]; then
    msg=$(udisksctl mount -b $chosen 2>&1)
    notify-send '💻 Mount' "$msg"
else
    echo "Abort"
fi
