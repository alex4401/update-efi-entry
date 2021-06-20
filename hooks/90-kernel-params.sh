#!/bin/bash
# Combine all of the user settings (or generated data) into
# a final kernel cmdline.
######

# Exit early if the kernel parameters is already specified.
if [ -n "$KERNEL_PARAMETERS" ]
then
    return 0
fi

# Helper function to append a kernel parameter
append() {
    KERNEL_PARAMETERS="$KERNEL_PARAMETERS $@"
}

# Root
KERNEL_PARAMETERS="root=$SYSTEM_ROOT"
if [ "$WRITABLE_ROOT" == "yes" ]
then
    append "rw"
else
    append "ro"
fi

# Initialization ramdisks
if [ "$BUILD_IMAGE" != "yes" ]
then
    # Microcode
    if [ "$MICROCODE" != "none" ]; then
        append "initrd=\\\\$MICROCODE-ucode.img"
    fi

    # Main
    append "initrd=\\\\$INITRD_FILENAME"
fi

# Use kernel-parameters if enabled by user.
KERNEL_PARAMS_CONFIG="$CONFIG_DIR/kernel-parameters"
if [[ `cat "$KERNEL_PARAMS_CONFIG" | grep -o "\!\[use\]"` != "![use]" ]]
then
    indent && print "Using separate kernel parameters configuration"
    source "$KERNEL_PARAMS_CONFIG"
fi
unset KERNEL_PARAMS_CONFIG

# Run advanced configuration hook.
if [ `LC_ALL=C type -t late_advanced_boot_config` == "function" ]
then
    indent && print "Using advanced boot entry configuration"
    late_advanced_boot_config
fi
