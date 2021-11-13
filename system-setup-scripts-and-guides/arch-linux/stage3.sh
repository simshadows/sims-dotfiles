#!/usr/bin/env sh

# Terminate script on error
set -e

# Let the user know if something went wrong.
on_exit () {
    echo ""
    echo "A critical error has occurred on line $1."
    echo "Stopping."
    echo ""
}
trap 'on_exit $LINENO' ERR

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

# Install the Linux kernel and the associated Linux headers, and the GRUB package.
# Do note that if we install a different kernel, we may need a different headers package.
pacman -Sy --noconfirm grub linux linux-headers efibootmgr
# We need efibootmgr otherwise grub-install doesn't work.

# regenerate the mkinitcpio preset. (mkinitcpio is what makes the initial ramdisk environment.)
# First, we add 'keyboard' and 'keymap' directly after 'autodetect'
sed -i '/^HOOKS=/s/autodetect/autodetect keyboard keymap/' /etc/mkinitcpio.conf
# Then, we add 'encrypt' directly before 'filesystems'
sed -i '/^HOOKS=/s/filesystems/encrypt filesystems/' /etc/mkinitcpio.conf
# (There's probably a shorter way to do this, but I'm too lazy to figure it out.)
# Now, we regenerate the preset
mkinitcpio -p linux
# (This command may be different depending on which kernel you're using.)

# Install GRUB.
# Note that we are using `i386-pc`, even if we're on a 64-bit installation.
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB

# (Not 100% sure what this does. I think it sets the GRUB language to en?)
mkdir -p /boot/grub/locale
cp /usr/share/locale/en\@quot/LC_MESSAGES/grub.mo /boot/grub/locale/en.mo

# We get the UUID of cryptroot's underlying physical partition.
# For example, if cryptroot lives in /dev/sda2, then this should be the UUID of /dev/sda2.
# If possible, please double-check 
CRYPTROOT_PHYSICAL_UUID=$(blkid -s UUID -o value --match-token TYPE=crypto_LUKS)
#GRUB_CMDLINE_LINUX="cryptdevice=UUID=${CRYPTROOT_PHYSICAL_UUID}:cryptroot root=/dev/mapper/cryptroot"
NEW_LINE="GRUB_CMDLINE_LINUX=\\\"cryptdevice=UUID=${CRYPTROOT_PHYSICAL_UUID}:cryptroot root=\/dev\/mapper\/cryptroot\\\""
sed -i "s/^GRUB_CMDLINE_LINUX=\"\"$/${NEW_LINE}/" /etc/default/grub

# We generate grub.cfg.
grub-mkconfig -o /boot/grub/grub.cfg

# Install and enable our DHCP client into our Arch installation.
# This is important, otherwise our Arch installation cannot connect to the internet!
pacman -Sy --noconfirm dhcpcd
systemctl enable dhcpcd.service
