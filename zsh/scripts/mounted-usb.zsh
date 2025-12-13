#!/usr/bin/env zsh

# Count mounted USB drives
count=$(lsblk -nlo TRAN,MOUNTPOINT | grep -E "^usb" -A1 | grep -c "/")

if [[ $count -gt 0 ]]; then
    echo "USB:$count"
fi
