#!/bin/bash
# Checks whether all the files exist.
######

check_file() {
    if [ ! -f "$1" ]
    then
        error "At least one of the required files is missing: $1"
        return 1
    fi
}

check_file /boot/$KERNEL_PATH || return 1
check_file /boot/$INITRD_FILENAME || return 1
if [ "$MICROCODE" != "none" ]
then
    check_file "/boot/$MICROCODE-ucode.img"
fi