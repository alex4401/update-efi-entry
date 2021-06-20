#!/bin/bash
# Checks whether all the files exist.
######

check_file_espnboot $KERNEL_PATH || return 1
check_file_espnboot $INITRD_FILENAME || return 1
if [ "$MICROCODE" != "none" ]
then
    check_file_espnboot "$MICROCODE-ucode.img"
fi
