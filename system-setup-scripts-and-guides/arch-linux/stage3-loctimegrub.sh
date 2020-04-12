#!/usr/bin/env sh

# Terminate script on error
set -e

# We will first generate locale.
# First, we uncomment the line 'en_AU.UTF-8 UTF-8' from the locales file.
sed -i 's/^#en_AU\.UTF-8 UTF-8/en_AU\.UTF-8 UTF-8/' /etc/locale.gen
# Now, we run locale-gen
locale-gen

# Somehow, this is required, otherwise some applications won't work.
localectl set-locale LANG="en_AU.UTF-8"

# Setting timezone
ln -s /usr/share/zoneinfo/Australia/Sydney /etc/localtime

# Setting hardware clock to the current system time.
hwclock --systohc --utc

# Install the Linux kernel and the associated Linux headers.
# Do note that if we install a different kernel, we may need a different headers package.
pacman -Sy --noconfirm linux linux-headers

# Install the GRUB package.
pacman -Sy --noconfirm grub-bios

# Install GRUB.
# Note that we are using `i386-pc`, even if we're on a 64-bit installation.
grub-install --target=i386-pc --recheck /dev/sda

# (Not 100% sure what this does. I think it sets the GRUB language to en?)
mkdir /boot/grub/locale
cp /usr/share/locale/en\@quot/LC_MESSAGES/grub.mo /boot/grub/locale/en.mo

# We generate grub.cfg.
grub-mkconfig -o /boot/grub/grub.cfg

# Install networking packages.
# This is important, otherwise our Arch installation cannot connect to the internet!
pacman -Sy --noconfirm networkmanager

