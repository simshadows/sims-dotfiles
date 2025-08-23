#!/usr/bin/env bash

echo "=== Neovim ==="

# Terminate script on error
set -e

# Get the source directory
# (This may not be portable.)
src_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "Setting up init.lua symlink..."
ln_corresponding .config/nvim init.lua

echo "DONE!"
printf "\n"

