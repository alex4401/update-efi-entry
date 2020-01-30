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

MICROCODE_PATH="/boot/$MICROCODE-ucode.img"
if [ ! -f "$MICROCODE_PATH" ]
then
    error "Detected that the \"$MICROCODE_PATH\" is preferred for this hardware, but it is not installed."
    MICROCODE=none
    return 0
fi
