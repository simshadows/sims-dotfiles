#!/usr/bin/env bash

echo "=== VSCodium ==="

# Terminate script on error
set -e

# Get the source directory
# (This may not be portable.)
src_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

DOTFILES_CODIUM=$src_dir/.config/VSCodium
HOME_OSS="$HOME/.config/Code - OSS"

echo "Setting up symlinks..."
echo $DOTFILES_CODIUM
echo $HOME_OSS

ln_corresponding .config/VSCodium/User settings.json
# Also link the config for VSCode OSS
mkdir -p "$HOME_OSS/User"
ln -sfn $DOTFILES_CODIUM/User/settings.json "$HOME_OSS/User/settings.json"

echo "DONE!"
printf "\n"

