#!/usr/bin/env sh

# Terminate script on error
set -e

# We install some basic packages.
pacman -Sy --noconfirm linux-headers wpa_supplicant wireless_tools

