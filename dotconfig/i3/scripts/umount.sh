#!/bin/sh

# Use rofi to choose a partition to umount

chosen=$(lsblk -nrpo "label,type,size,mountpoint" |
    sed 's/^ /NoLabel /' |
    awk '$2 == "part" && $4 !~ /^\/boot|^\/home|SWAP/ && length($4) > 1 {
        printf "%s %s (%s)\n",$4,$1,$3
    }' |
    rofi -dmenu -no-custom -i -p "Unmount which drive?" |
    cut -d' ' -f1)

if [ $? = 0 ] && [ -n "$chosen" ]; then
    if umount "$chosen"; then
        notify-send "💻 Umount" "$chosen: success"
    else
        notify-send "💻 Umount" "$chosen: failed"
    fi
fi
