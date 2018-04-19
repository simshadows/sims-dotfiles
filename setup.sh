#!/usr/bin/env bash

# Terminate script on error
set -e

# Get the source directory
# (This may not be portable.)
src_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "Running the setup scripts..."
printf "\n"

bash "$src_dir/dotfiles/general-linux/setup.sh"
bash "$src_dir/dotfiles/vim/setup.sh"

echo "ALL DONE!"

