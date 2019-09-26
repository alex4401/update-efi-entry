#!/bin/bash
# Automatically find the EFI partition.
######

# Exit early if ESP is already specified.
if [ -n "$ESP_DISK" ] && [ -n "$ESP_PARTITION_ID" ]
then
    return 0
fi

ESP_MOUNTED_DEVICE=`findmnt -fn -o SOURCE $ESP_MOUNT_POINT`
ESP_PARTITION_ID=`echo $ESP_MOUNTED_DEVICE | grep -Eo '[0-9]+$'`
ESP_DISK=`echo $ESP_MOUNTED_DEVICE | sed "s/$ESP_PARTITION_ID$//"`

# Imprecise check if this actually succeded.
if [ -z "$ESP_DISK" ] || [ -z "$ESP_PARTITION_ID" ] || [ -z "$ESP_MOUNTED_DEVICE" ] || [ "$ESP_MOUNTED_DEVICE" == "sysfs" ]
then
	echo "Failed to find the ESP partition. Is it really mounted on $ESP_MOUNT_POINT?"
	return 1
fi