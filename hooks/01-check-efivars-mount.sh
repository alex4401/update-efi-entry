#!/bin/bash
# Verify that EFI variables are mounted.
######

if [ ! -d /sys/firmware/efi/efivars ]
then
  error "/sys/firmware/efi/efivars is not mounted."
  error "If you are absolutely sure you're running on UEFI and not a compatibility"
  error "mode, attempt to mount the \"efivars\" filesystem manually, or add this"
  error "rule to /etc/fstab:"
  error ""
  error "efivarfs  /sys/firmware/efi/efivars  efivarfs  rw,nosuid,nodev,noexec,relatime 0 0"
  return 1
fi

return 0
