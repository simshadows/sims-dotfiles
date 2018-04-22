#!/usr/bin/env bash

# Terminate script on error
set -e

# Get the source directory
# (This may not be portable.)
src_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "Running content autogeneration scripts......"
printf "\n"

bash "$src_dir/dotfiles/newsboat/autogen.sh"

echo "ALL DONE!"
