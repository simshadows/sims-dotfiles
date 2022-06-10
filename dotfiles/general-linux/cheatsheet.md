# Linux Cheatsheet

*A cheatsheet for things I regularly need but forget.*

*IMPORTANT: My custom aliases are used here.*

## Linux Meta

- `$ man <<QUERY>>`
    - **Shows manpages for the query.**
- `$ which <<<COMMAND>>>`
    - **Shows full path of a command.**

For rescuing an Arch/Manjaro Linux installation from a live installer:

```
$ echo "Run fdisk to check your system's disk devices."
# fdisk -l

$ echo "Substitute your system's disk devices into the commands below."
# cryptsetup open /dev/nvme0n1p3 cryptroot
# mount /dev/mapper/cryptroot /mnt
# mount /dev/nvme0n1p1 /mnt/boot
# arch-chroot /mnt

$ echo "If you're using Manjaro, use 'manjaro-chroot' instead."
```

## Git + Lazygit

- `git submodule update --init --recursive --remote`
    - Run this if you forgot to clone with `--recurse-submodules` and need it.

## Kubernetes + Helm

*(TODO)*

## LaTeX (`pacman -S texlive-most biber`)

- `latexmk -pdf <<<.tex FILE>>`
    - **Compiles LaTeX to PDF.**
    - Add `-f` to force complete processing despite errors.
    - Add `-quiet` to force complete processing without interruption.
    - Add `-pvc` to watch for changes and automatically recompile.

