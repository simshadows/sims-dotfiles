#!/usr/bin/env bash

#
# You run this file to copy in any required files.
#

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
# NOTE: "rm" is used instead of the "ln -T" option for compatibility.
function update_corresponding() {
    if [[ "$#" == 1 ]]; then
        cp "$HOME/$1" "$src_dir/$1"
    elif [[ "$#" == 2 ]]; then
        mkdir -p "$HOME/$1"
        cp "$HOME/$1/$2" "$src_dir/$1/$2"
    else
        echo "Wrong number of arguments for update_corresponding()."
        exit 1
    fi
}
export -f update_corresponding

################################################################################

echo "Detecting system information..."
# System detection
if [[ "$OSTYPE" == "darwin"* ]]; then
    os_type="mac"
    utils_flavour="bsd"
else
    # Catch-all: Assume everything else is GNU.
    os_type="gnu"
    utils_flavour="gnu"
fi
echo "OSTYPE        = $OSTYPE"
echo "os_type       = $os_type"
echo "utils_flavour = $utils_flavour"
printf "\n"

echo "Running the setup scripts..."
printf "\n"

bash "$src_dir/dotfiles/general/update.sh"

if [[ "$os_type" == "gnu" ]]; then
    bash "$src_dir/dotfiles/kde/update.sh"
fi

echo "ALL DONE!"

