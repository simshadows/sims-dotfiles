#!/usr/bin/env bash

echo "=== General Linux ==="

# Terminate script on error
set -e

# Get the source directory
# (This may not be portable.)
src_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "Setting up symlinks and directories..."

ln -sfT "$src_dir/.bash_logout" ~/.bash_logout
ln -sfT "$src_dir/.bash_profile" ~/.bash_profile
ln -sfT "$src_dir/.bashrc" ~/.bashrc
ln -sfT "$src_dir/.i3" ~/.i3
ln -sfT "$src_dir/.tmux.conf" ~/.tmux.conf
ln -sfT "$src_dir/.Xresources" ~/.Xresources


config_dir=~/.config
repo_config_dir="$src_dir/.config"
function config_ln() {
    mkdir -p "$config_dir/$1"
    ln -sfT "$repo_config_dir/$1/$2" "$config_dir/$1/$2"
}
config_ln i3status config
config_ln ranger commands_sample.py
config_ln ranger rc.conf
config_ln ranger rifle.conf
config_ln zathura zathurarc

echo "DONE!"
printf "\n"

