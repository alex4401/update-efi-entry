#!/bin/bash
# Automatically find the EFI partition.
######

# Require ESP_MOUNT_POINT to be specified.
if [ -z "$ESP_MOUNT_POINT" ]
then
    error "ESP mount point has not been set in the configuration file."
    return 1
fi

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
	error "Failed to find the ESP partition. Is it really mounted on $ESP_MOUNT_POINT?"
	return 1
fi
