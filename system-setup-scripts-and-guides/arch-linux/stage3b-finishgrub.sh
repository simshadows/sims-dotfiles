#!/usr/bin/env sh

# Terminate script on error
set -e

# We generate grub.cfg.
grub-mkconfig -o /boot/grub/grub.cfg

