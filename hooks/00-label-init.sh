#!/bin/bash
# Initialize the entry label if it's empty.
######

if [ -z "$BOOT_ENTRY_LABEL" ]; then
	error "Boot entry label unspecified; using \"Linux\""
	BOOT_ENTRY_LABEL="Linux"
fi