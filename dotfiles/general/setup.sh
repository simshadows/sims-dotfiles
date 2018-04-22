#!/usr/bin/env bash

echo "=== General ==="

# Terminate script on error
set -e

# Get the source directory
# (This may not be portable.)
src_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "Setting up symlinks and directories..."
ln_corresponding .bash_logout
ln_corresponding .bash_profile
ln_corresponding .bashrc
ln_corresponding .tmux.conf
ln_corresponding .config/i3status config
ln_corresponding .config/ranger commands.py
ln_corresponding .config/ranger commands_full.py
ln_corresponding .config/ranger rc.conf
ln_corresponding .config/ranger rifle.conf
ln_corresponding .config/ranger scope.sh
ln_corresponding .config/zathura zathurarc
ln_corresponding .newsboat config
ln_corresponding .newsboat urls

echo "DONE!"
printf "\n"

