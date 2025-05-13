#!/usr/bin/env bash

echo "=== General ==="

# Terminate script on error
set -e

# Get the source directory
# (This may not be portable.)
src_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "Copying files into the repository..."

update_corresponding .config/vlc vlcrc

echo "DONE!"
printf "\n"

