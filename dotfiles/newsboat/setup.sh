#!/usr/bin/env bash

echo "=== Newsboat ==="

# Terminate script on error
set -e

# Get the source directory
# (This may not be portable.)
src_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "Setting up symlinks and directories..."
ln_corresponding .newsboat config
ln_corresponding .newsboat urls

echo "DONE!"
printf "\n"

