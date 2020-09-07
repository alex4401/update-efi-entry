#!/bin/bash

if [ "$BUILD_IMAGE" != "yes" ]
then
    return 0
fi


if [ "$EFISTUB_LOCATION" == "auto" ]
then
  case "$(uname -m)" in
    x86_64)
      EFISTUB_LOCATION="/usr/lib/systemd/boot/efi/linuxx64.efi.stub"
      ;;
    i686)
      EFISTUB_LOCATION="/usr/lib/systemd/boot/efi/linuxia32.efi.stub"
      ;;
    *)
      error "Could not find an EFISTUB."
      return 1
      ;;
  esac
fi
