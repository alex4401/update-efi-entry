#!/bin/bash

# Initialization ramdisks
if [ "$BUILD_IMAGE" != "yes" ]
then
    return 0
fi

# Main
INITRD_FILENAME="$ESP_MOUNT_POINT/$INITRD_FILENAME"
