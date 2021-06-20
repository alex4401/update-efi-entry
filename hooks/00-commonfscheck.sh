#!/bin/bash
# Common functions to check whether files exist.
######

check_file_esp() {
    if [ ! -f "$1" ]
    then
        error "A required file is missing from the ESP: $1"
        return 1
    fi
}

check_file_espnboot_u() {
    # Check if exists in /boot but not ESP
    if [ ! -f "$ESP_MOUNT_POINT/$1" ] && [ -f "/boot/$1" ]
    then
        error "Required file $1 is missing from the ESP, but it has been found in /boot."
        error "Your system will be likely unable to boot."
        error ""
        error "- If /boot *is* your ESP, update ESP_MOUNT_POINT in the configuration file"
        error "  to point at it, or set up a bind mount from $ESP_MOUNT_POINT to /boot."
        error "- Copy the missing file over to the ESP. This will be required each time"
        error "  it is updated, and you will not receive another warning to remind you."
        return 1
    fi
}

check_file() {
    check_file_esp "$1" || return 1
}

check_file_espnboot() {
    check_file_espnboot_u "$1" || return 1
    check_file "$ESP_MOUNT_POINT/$1" || return 1
}
