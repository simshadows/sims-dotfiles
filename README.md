# Sim's Dotfiles

My personal dotfiles for Linux and Mac.


## Installation

**The scripts will overwrite any existing files. Back up your current configuration now if you need to.**

To install, simply run:
```
$ ./setup.sh
```

The `setup.sh` script almost entirely sets up symlinks, but I found one specific case where neither symlink nor hard link works: `~/.config/kdeglobals`.


## Updating `~/.config/kdeglobals`

To update it, run:

```
$ update.sh
```


## Updating the dotfiles

To pull my latest changes, simply run:

```
$ git pull && ./setup.sh
```

