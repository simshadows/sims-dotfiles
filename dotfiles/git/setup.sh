#!/usr/bin/env bash

echo "=== Version Control ==="

# Terminate script on error
set -e

# Get the source directory
# (This may not be portable.)
src_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "Setting up symlinks..."
ln_corresponding .gitconfig
ln_corresponding .gitignore_global
ln_corresponding .config/lazygit config.yml
# Untested
#ln_corresponding .subversion config

echo "DONE!"
printf "\n"

