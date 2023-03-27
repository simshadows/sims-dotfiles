#!/usr/bin/env bash

echo "=== General ==="

# Terminate script on error
set -e

# Get the source directory
# (This may not be portable.)
src_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "Updating '~/.config/kdeglobals'..."

## Unstable. Maybe revisit these some other time.
#update_corresponding .config kdeglobals

echo "DONE!"
printf "\n"

