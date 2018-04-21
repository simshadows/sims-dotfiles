# Sim's Dotfiles

My personal dotfiles for Linux and Mac.

## Cool stuff to check out

- **My Git config can be used as a cheatsheet.**
    - `dotfiles/git/.gitconfig` includes a whole bunch of aliases of essential commands along with extensive comments in that config file.
- **My Vim config and UltiSnips snippets collection.**
    - See `dotfiles/vim/.vimrc` and `dotfiles/vim/runtime/UltiSnips/`.
    - I generally still rely on [honza/vim-snippets](https://github.com/honza/vim-snippets). The snippets found in this dotfiles repository simply add my personal preferences and tweaks on top of honza's repository.
    - My Latex snippets frequently involve custom commands, so don't expect them to work for you out of the box.

## Compatibility and Personalization

This repo is built primarily *for my convenience*, which means two things:

- I will only guarantee it works on my own systems, and
- This repository will have a lot of personalizations (such as my git username and email).

For reference, I use systems that run:

- Arch Linux
- Mac OS

While I do make an effort to make things portable between different operating systems and distributions, it can be a huge pain.

As such, if you're adopting my dotfiles repository for your own use, be prepared to put out fires.

## Installation

The scripts will overwrite any existing files. Back up your current configuration now if you need to.

I suggest looking through everything first, understanding what the scripts and files are doing, and changing things as needed.

If you're happy with what you see, run `setup.sh` and everything should be set up.

### Errors during installation

During first-time installation, you may run into something like the following:

```
Error detected while processing /home/simshadows/.vimrc:
line   85:
E185: Cannot find color scheme 'solarized'
Press ENTER or type command to continue
```

It's fine. Just press enter. It happens because Vim needs to be run during installation to install plugins, which reads a line from `.vimrc` that requires a plugin to be installed.

### Parts that require manual installation

Anything in `dotfiles/other-backups/` must be manually copied/symlinked as needed.

## Updating

You should be able to just `git pull && ./setup.sh` to get and install the latest version of this repository.

## TODOs

- Have the `other-backups/` files be installed automatically.
- I should learn more about Git and redo the `dotfiles/git/.gitconfig` Git aliases. As it is right now, I'm not actually 100% confident in my documentation, I simply don't understand enough about Git, and that file is really messy.
- Extend this repository to also do system configuration scripts, and maybe even documentation.
    - However, I want to avoid overloading this repository too much.
    - Additionally, I want to add documentation to my personal website, which would mean duplication if a copy also exists here.

