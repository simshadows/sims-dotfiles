#!/usr/bin/env sh

# Terminate script on error
set -e

# We will first generate locale.
# First, we uncomment the line 'en_AU.UTF-8 UTF-8' from the locales file.
sed -i 's/^#en_AU\.UTF-8 UTF-8/en_AU\.UTF-8 UTF-8/' /etc/locale.gen
# Now, we run locale-gen
locale-gen

# Setting timezone
ln -s /usr/share/zoneinfo/Australia/Sydney /etc/localtime

# Setting hardware clock to the current system time.
hwclock --systohc --utc

