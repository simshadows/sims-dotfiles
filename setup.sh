#!/usr/bin/env bash

# Terminate script on error
set -e

# Get the source directory
# (This may not be portable.)
src_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# If one argument:
#   We symlink "$HOME/$1" to "$src_dir/$1".
# If two arguments:
#   We symlink "$HOME/$1/$2" to "$src_dir/$1/$2".
#   Intermediate parent directories are also created.
function ln_corresponding() {
    if [[ "$#" == 1 ]]; then
        ln -sfT "$src_dir/$1" "$HOME/$1"
    elif [[ "$#" == 2 ]]; then
        mkdir -p "$HOME/$1"
        ln -sfT "$src_dir/$1/$2" "$HOME/$1/$2"
    else
        echo "Wrong number of arguments for ln_corresponding()."
        exit 1
    fi
}
export -f ln_corresponding

################################################################################

echo "Running the setup scripts..."
printf "\n"

bash "$src_dir/dotfiles/general/setup.sh"
bash "$src_dir/dotfiles/general-linux/setup.sh"
bash "$src_dir/dotfiles/git/setup.sh"
bash "$src_dir/dotfiles/vim/setup.sh"

echo "ALL DONE!"

