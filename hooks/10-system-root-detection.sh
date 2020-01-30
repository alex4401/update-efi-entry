#!/bin/bash
# Automatically find the system (/) partition's UUID.
######

if [ -z "$WRITABLE_ROOT" ]
then
    echo "Assuming that the root partition is meant to be writable."
    WRITABLE_ROOT="yes"
fi

# Exit early if the UUID is already specified.
if [ -n "$SYSTEM_ROOT" ] && [ "$SYSTEM_ROOT" != "auto" ]
then
    return 0
fi

# Find the GPT UUID of current mount.
_ROOT_PARTUUID=`findmnt -fn -o PARTUUID /`
if [ -z "$_ROOT_PARTUUID" ]
then
    error "PARTUUID of system root could not be determined."
    error "TODO: Auto-detection for LVM setups is not supported yet."
    return 1
fi

SYSTEM_ROOT="PARTUUID=$_ROOT_PARTUUID"
