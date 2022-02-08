#!/usr/bin/env bash

echo "=== General Linux ==="

# Terminate script on error
set -e

# Get the source directory
# (This may not be portable.)
src_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "Setting up symlinks and directories..."
ln_corresponding .i3
ln_corresponding bin zephyrus-desktop-mode
ln_corresponding bin zephyrus-portable-mode
ln_corresponding .Xresources
ln_corresponding .config/i3status config
ln_corresponding .config/zathura zathurarc

echo "DONE!"
printf "\n"

