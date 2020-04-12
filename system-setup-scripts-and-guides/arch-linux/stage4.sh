#!/usr/bin/env sh

# Terminate script on error
set -e

# We install LTS kernel and wireless networking packages.
#pacman -Sy --noconfirm linux-lts linux-lts-headers wpa_supplicant wireless_tools wpa_actiond
# wpa_supplicant is required to use a wireless card.
# wireless_tools is optional.

# We install networking packages.
#pacman -Sy --noconfirm network-manager-applet

# We install some more optional packages.
#pacman -Sy --noconfirm dialog

