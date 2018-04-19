#!/usr/bin/env bash

echo "=== Git ==="

# Terminate script on error
set -e

# Get the source directory
# (This may not be portable.)
src_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "Setting up symlinks..."
ln -sfT "$src_dir/.gitconfig" ~/.gitconfig
ln -sfT "$src_dir/.gitignore_global" ~/.gitignore_global

echo "DONE!"
printf "\n"

