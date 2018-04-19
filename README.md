# Sim's Dotfiles

My personal dotfiles for Linux.

## Installation

This script will overwrite any existing files. Back up your current configuration now if you need to.

I suggest looking through everything first and changing things as needed. This repo is personalized for my needs, such as my git identity.

If you're happy with what you see, run `setup.sh` to set everything up.

### Parts that require manual installation

Anything in `dotfiles/other-backups/` must be manually copied/symlinked as needed.

## Interesting stuff

- Git configuration file (`dotfiles/git/.gitconfig`) includes a whole bunch of aliases of essential commands along with extensive comments in that config file.

## TODO

- Have a separate Mac OS installation.
- Have the `other-backups/` files be installed automatically.
- Make use of `dotfiles/vim/vimruntime` and add snippets to it.
- General code cleanup and improve portability as required (ongoing)

