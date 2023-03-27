#!/usr/bin/env bash

echo "=== General ==="

# Terminate script on error
set -e

# Get the source directory
# (This may not be portable.)
src_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "Setting up symlinks and directories..."
ln_corresponding .dotfiles-kde-assets

## Unstable. Maybe revisit these some other time.
#ln_corresponding .config kdeglobals # THIS ONE WILL HANG THE SYSTEM
#cp_corresponding .config kdeglobals
#ln_corresponding .config kglobalshortcutsrc
#ln_corresponding .config kscreenlockerrc
#ln_corresponding .config kwinrc
#ln_corresponding .config plasma-org.kde.plasma.desktop-appletsrc
#ln_corresponding .config powermanagementprofilesrc

echo "DONE!"
printf "\n"

