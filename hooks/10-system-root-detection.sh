#!/bin/bash
# Automatically find the system (/) partition's UUID.
######

if [ -z "$ROOT_PARTITION_WRITABLE" ]
then
    echo "Assuming that the root partition is desired to be writable."
    ROOT_PARTITION_WRITABLE="yes"
fi

# Exit early if the UUID is already specified.
if [ -n "$ROOT_PARTITION_UUID" ]
then
    return 0
fi

ROOT_PARTITION_UUID=`findmnt -fn -o PARTUUID /`
