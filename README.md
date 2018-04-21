# Sim's Dotfiles

My personal dotfiles for Linux.

## Installation

This script will overwrite any existing files. Back up your current configuration now if you need to.

I suggest looking through everything first and changing things as needed. This repo is personalized for my needs, such as my git identity.

If you're happy with what you see, run `setup.sh` to set everything up.

### Errors during installation

During first-time installation, you may run into something like the following:

```
Error detected while processing /home/simshadows/.vimrc:
line   85:
E185: Cannot find color scheme 'solarized'
Press ENTER or type command to continue
```

Just press enter. It happens because Vim needs to be run during installation to install plugins, which reads a line from `.vimrc` that requires a plugin to be installed.

### Pamts that require manual installation

Anything in `dotfiles/other-backups/` must be manually copied/symlinked as needed.

## Maintenance

You should be able to just `git pull && ./setup.sh` to get and install the latest version of this repository.

## Interesting stuff

- Git configuration file `dotfiles/git/.gitconfig` includes a whole bunch of aliases of essential commands along with extensive comments in that config file.
- Vim config can be found in `dotfiles/vim/`, which includes my collection of snippets in `dotfiles/vim/runtime/UltiSnips/`.
    - I generally still rely on [honza/vim-snippets](https://github.com/honza/vim-snippets). The snippets found in this dotfiles repository simply add my personal preferences and tweaks on top of honza's repository.
    - My Latex snippets frequently involve custom commands, so don't expect them to work for you out of the box.
    - Other tweaks are to do with my preferred coding style. E.g. I prefer K&R braces for C and C-like languages.

## TODOs

- Have a separate Mac OS installation.
- Have the `other-backups/` files be installed automatically.
- I should learn more about Git and redo the `dotfiles/git/.gitconfig` Git aliases. As it is right now, I'm not actually 100% confident in my documentation, I simply don't understand enough about Git, and that file is really messy.
- Extend this repository to also do system configuration scripts maybe even documentation
    - However, I want to avoid overloading this repository too much.
    - Additionally, I want to add documentation to my personal website, which would mean duplication if a copy also exists here.
- General code cleanup and improve portability as required (ongoing)

