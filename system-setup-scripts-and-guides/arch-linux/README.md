# Arch Linux Installation

This guide currently is designed mostly for personal reference, and not a newbie guide. But if you like what you see, use it by all means! :)

To save on the tedium, I have written some sections into scripts.

*(I'll link to a proper newbie guide when I find one that I can vet!)*

## Stage 1: From the installation media...

### Firstly:

Verify available storage devices:<br>
`fdisk -l`

Launch fdisk:<br>
`fdisk /dev/sda`

### Now within `fdisk`:

You'll generally want to make:
* A boot partition of at least 30GB,
* A swap partition of maybe 2GB, and
* A data partition taking up the remaining space.

`o` wipes the drive. Use this command first.

`n` creates a new partition.

Generally want primary and default partition numbers.<br>
Generally also want the default first sector, which is the next available sector.<br>
For last sector, specify sizes. E.g. for 128GB, type +128G. Otherwise, the default value of last sector takes up the remaining portion of the drive.<br>

`type` sets partition types. All partitions are 'Linux' by default.<br>
To change a partition to a swap partition, use partition type 82 ('Linux swap / Solaris').

`w` writes changes to disk. Use this command last.

### After exiting from `fdisk`:

*We will now assume from now on that `/dev/sda1` is the boot partition, `/dev/sda2` is the swap partition, and `/dev/sda3` is the data partition.*

Format sda1 and sda3 to the ext4 filesystem:<br>
`mkfs.ext4 /dev/sda1`<br>
`mkfs.ext4 /dev/sda3`

Check if we have an IP address:<br>
`ip a`

Ping Google's DNS server to check the internet connection:<br>
`ping -c 5 8.8.8.8`

Mount our partitions:<br>
`mount /dev/sda1 /mnt`<br>
`mkdir /mnt/home`<br>
`mount /dev/sda3 /mnt/home`

Check what's mounted:<br>
`mount`<br>
If we successfully mounted everything, we should be able to see `/dev/sda1` and `/dev/sda3` towards the end on the terminal. That should look like this:
```
/dev/sda1 on /mnt type ext4 (rw,relatime,data=ordered)
/dev/sda3 on /mnt/home type ext4 (rw,relatime,data=ordered)
root@archiso ~ #
```

`pacstrap -i /mnt base`

Create filesystems table file:<br>
`genfstab -U -p /mnt >> /mnt/etc/fstab`

## Stage 2: Downloading my helper scripts

First, we'll need to install git into the RAM-disk:<br>
`pacman -Sy git`

And now, we clone my repository!<br>
`git clone https://github.com/simshadows/sims-dotfiles.git /mnt/root/dotfiles`

**IMPORTANT: Each script may need adjustments before running. Please read the "This will:" dotpoints and adjust the script if any of it is wrong!**

## Stage 3: Continuing from within the Arch installation...

Chroot into installation, and change directory for convenience:<br>
`arch-chroot /mnt`<br>
`cd /root/dotfiles/system-setup-scripts-and-guides/arch-linux`

Run my script:<br>
`./stage3.sh`
This will:
- Generate locale to `en_AU.UTF-8`.
- Set our timezone to `Australia/Sydney`.
- Set the hardware clock.
- Install the standard Linux kernel and its headers. *(Headers are optional.)*
- Install GRUB bootloader to `/dev/sda`.
- Sets GRUB language to `en`.
- Installs and sets up a DHCP client to allow us to connect to the internet.

Change `root`'s password:<br>
`passwd`

Now, we must reboot:<br>
`exit`<br>
`umount /mnt/home`<br>
`umount /mnt`<br>
`reboot`

Wait for reboot. If the installation media boots again, select "Boot existing OS" or similar options to boot into the installation.

Should be able to log in as `root` now. If not, we failed something and should start all over again.

## Stage 4: Now that we have directly booted into our installation...

Ensure `/dev/sda1` and `/dev/sda3` are shown:<br>
`df -h`

We're not using a swap partition right now. Verify this with:<br>
`free -m`<br>
Swap total should show 0 total.

Double-check what the swap partition is:<br>
`fdisk -l`

Set up the swap partition and tee the output into `tmp.txt`:<br>
`mkswap /dev/sda2 | tee tmp.txt`<br>
This should print out a UUID.

Run my script:<br>
`./stage4.sh`
This will add an entry in `/etc/fstab` for the swap partition.

Note on the above: If you're using an SSD, you should also add `discard` to  the root and data partitions (or whatever is on an SSD).<br>
This sets up trim support.<br>
Don't do this with a hard drive.<br>

`reboot`

Wait for reboot...

`free -m`<br>
Swap should show values now.

## Stage 5: User account, hostname, and X.org.

Install sudo and X.org:
`pacman -Sy --noconfirm sudo xorg-server xorg-xinit`

Add user account:<br>
`useradd -m -s /bin/bash simshadows`

Now, we want to add `simshadows` to the sudoers file. Run:<br>
`visudo`<br>
Add this line:<br>
```
simshadows ALL=(ALL) ALL
```

Set user password:<br>
`passwd simshadows`

Change machine name:<br>
`hostnamectl set-hostname <putnamehere>`

## Stage 6: Installing the video driver...

Use to check what card you're using:<br>
`lspci`

Now pick a driver below:

### Open-source Nvidia driver

`pacman -Sy xf86-video-nouveau lib32-nouveau-dri`

If that succeeds, go to the next section.

Otherwise, if that fails, you might need to allow 32-bit packages to be installed. Do the following:

`vi /etc/pacman.conf`

Uncomment:
```
[multilib]
Include = /etc/pacman.d/mirrorlist
```

Then, attempt to install again.

### Intel driver
`pacman -Sy xf86-video-intel lib32-intel-dri lib32-mesa lib32-libgl`

### Closed-source Nvidia driver (better for gaming)
`pacman -Sy nvidia lib32-nvidia-libgl`

### Virtualbox
`pacman -Sy virtualbox-guest-utils xf86-video-vmware`<br>
xf86-video-vmware assumes you're using the VMSVGA virtual graphics controller.

### Vesa driver (allows you to use any card, but very minimal)
`pacman -Sy xf86-video-vesa`

## Stage 7: Installing display managers and desktop environments

Pick one of the options below.

Note that both minimalist recommendations include terminals. That's because without one, you literally can't do anything.

### Minimalist i3 (This is what I personally use)

`pacman -Sy nodm i3 rxvt-unicode`

`vi /etc/nodm.conf`<br>
Sample settings (without comments):<br>
```
NODM_USER='simshadows'
NODM_X_OPTIONS='vt7 -nolisten tcp'
NODM_MIN_SESSION_TIME=60
NODM_XSESSION='/home/simshadows/.xinitrc'
NODM_X_TIMEOUT=20      
```

`vi /home/simshadows/.xinitrc`<br>
File contents:
```
#!/bin/bash

# Enable VBoxClient features (such as auto-resize), or fail silently
VBoxClient-all || true
# Load .Xresources file
[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources
# Launch i3 window manager
exec i3
```

Change file permissions (since it's a user file):
```
chown simshadows /home/simshadows/.xinitrc
chgrp simshadows /home/simshadows/.xinitrc
```

`systemctl enable nodm`

`reboot`

### Minimalist GNOME

`pacman -Sy gdm gnome-shell gnome-terminal`

Highly recommended:<br>
`pacman -Sy gnome-control-center` to provide the "control panel".

`systemctl enable gdm`

`reboot`

### Full GNOME

`pacman -Sy gdm gnome gnome-extra`

Notes:
* gdm: The display manager. It is generally recommended to use one associated with your desktop environment, but they can be interchangable anyway. In this case, gdm is GNOME's recommended display manager.
* gnome: The desktop environment itself.
* gnome-extra: A bundle of extras to provide a more complete system.

Enable GDM to start automatically upon boot:<br>
`systemctl enable gdm`

`reboot`

## Stage 8: Recommended Programs

You can install a tonne of stuff I use by running my script:<br>
`./stage8-installpackages.sh`

You can also read the script and edit it yourself as needed.

Do note that this script will require you to 
