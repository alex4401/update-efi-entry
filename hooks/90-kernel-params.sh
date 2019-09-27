#!/bin/bash
# Combine all of the user settings (or generated data) into
# a final kernel cmdline.
######

# Exit early if the kernel parameters is already specified.
if [ -n "$KERNEL_PARAMETERS" ]
then
    return 0
fi

# Root
KERNEL_PARAMETERS="root=PARTUUID=$ROOT_PARTITION_UUID"
if [ "$ROOT_PARTITION_WRITABLE" == "yes" ]
then
	KERNEL_PARAMETERS="$KERNEL_PARAMETERS rw"
else
	KERNEL_PARAMETERS="$KERNEL_PARAMETERS ro"
fi

# Microcode
if [ "$MICROCODE" != "none" ]; then
	KERNEL_PARAMETERS="$KERNEL_PARAMETERS initrd=\\\\$MICROCODE-ucode.img"
fi

# InitRD
KERNEL_PARAMETERS="$KERNEL_PARAMETERS initrd=\\\\$INITRD_FILENAME"

# Custom user kernel parameters
append() {
	KERNEL_PARAMETERS="$KERNEL_PARAMETERS $@"
}
source ./config/kernel-parameters