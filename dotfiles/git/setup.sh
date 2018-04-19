#!/usr/bin/env bash

echo "=== Git ==="

# Terminate script on error
set -e

# Get the source directory
# (This may not be portable.)
src_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "Setting up symlinks..."
ln -sfT "$src_dir/.gitignore_global" ~/.gitignore_global

echo "Running git config commands..."
git config --global user.email 'contact@simshadows.com'
git config --global user.name 'simshadows'
git config --global core.editor vim
git config --global core.excludesfile ~/.gitignore_global

echo "DONE!"
printf "\n"

