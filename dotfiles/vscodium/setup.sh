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
ln -sfn "$DOTFILES_CODIUM/User/settings.json" "$HOME_OSS/User/settings.json"

mkdir -p "$HOME/.vscode-oss/extensions"
ln -sfn "$src_dir/../general/.common-resources/snippets-vscode" "$HOME/.vscode-oss/extensions/simshadows.simshadows-snippets-0.0.1"
# We need to delete extensions.json, otherwise the extension fails to install.
# The file is just a cache anyway.
rm -f "$HOME/.vscode-oss/extensions/extensions.json"

echo "DONE!"
printf "\n"

