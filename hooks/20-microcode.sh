#!/bin/bash
# Find the microcode binary name.
######

# Check if the microcode is to be found.
if [ "$MICROCODE" != "auto" ]
then
    return 0
fi

CPU_VENDOR_ID=`cat /proc/cpuinfo | grep vendor_id | cut -d':' -f2`
if [[ "$CPU_VENDOR_ID" == *"Intel"* ]]
then
    MICROCODE=intel
elif [[ "$CPU_VENDOR_ID" == *"AMD"* ]]
then
    MICROCODE=amd
else
    MICROCODE=none
    return 0
fi

MICROCODE_FILENAME="$MICROCODE-ucode.img"
check_file_espnboot_u "$MICROCODE_FILENAME"
if [ ! -f "$ESP_MOUNT_POINT/$MICROCODE_FILENAME" ]
then
    error "Detected that the \"$MICROCODE_FILENAME\" is preferred for this hardware, but it is not installed."
    MICROCODE=none
    return 0
fi
