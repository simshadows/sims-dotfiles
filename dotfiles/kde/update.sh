#!/usr/bin/env bash

echo "=== KDE ==="

# Terminate script on error
set -e

# Get the source directory
# (This may not be portable.)
src_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "Copying files into the repository..."

## Unstable. Maybe revisit these some other time.
#update_corresponding .config kdeglobals

echo "DONE!"
printf "\n"

