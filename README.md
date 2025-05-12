# Sim's Dotfiles

My personal dotfiles for Linux and Mac.

(And I'm also trying to do Windows, but that's still a WIP.)


## Installation (Linux/Mac)

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

## Installation (Windows)

Run `setup-windows.ps1`.

You may need to open an Admin shell and run:

```ps
Set-ExecutionPolicy Unrestricted
```

You may also need to run `setup-windows.ps1` as administrator.
