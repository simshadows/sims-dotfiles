#!/usr/bin/env sh

# Terminate script on error
set -e

# We install some basic packages.
pacman -Sy --noconfirm grub-bios linux-headers wpa_supplicant wireless_tools

