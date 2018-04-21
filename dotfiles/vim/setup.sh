#!/usr/bin/env bash

echo "=== Vim ==="

# Terminate script on error
set -e

# Get the source directory
# (This may not be portable.)
src_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "Setting up .vimrc symlink..."
ln_corresponding .vimrc

echo "Setting up Vundle..."
vundle_dir=~/.vim/bundle/Vundle.vim
if [ ! -d "$vundle_dir" ]; then
    git clone https://github.com/VundleVim/Vundle.vim.git "$vundle_dir"
fi
# This should also automatically set up parent directories.

echo "Running vim PluginInstall..."
vim +PluginInstall +qall

echo "Setting up remaining symlinks..."
ln -sfn "$src_dir/runtime" ~/.vim/custom-runtime

echo "DONE!"
printf "\n"

