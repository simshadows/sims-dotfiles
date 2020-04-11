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

Chroot into installation:<br>
`arch-chroot /mnt`

## Stage 2: Downloading my scripts

First, we'll need to install git:

`pacman -Sy git`

And now, we clone my repository!<br>
`git clone https://github.com/simshadows/sims-dotfiles.git /root/dotfiles`<br>
`cd /root/dotfiles/system-setup-scripts-and-guides/arch-linux`

**IMPORTANT: Each script may need adjustments before running. Please read the "This will:" dotpoints and adjust the script if any of it is wrong!**

## Stage 3: Continuing from within the Arch installation...

Run my script:<br>
`./stage3a-loctimegrub.sh`<br>
This will:
- Generate locale to `en_AU.UTF-8`.
- Set our timezone to `Australia/Sydney`.
- Set the hardware clock.
- Install GRUB to `/dev/sda`.
- Sets GRUB language to `en`.

We can now optionally configure the system to skip the boot menu. Open:<br>
`vi /etc/defaults/grub`<br>
Set the following values:
```
GRUB_TIMEOUT=0
GRUB_HIDDEN_TIMEOUT=0
GRUB_FORCE_HIDDEN_MENU=true
```

*TODO: How do we make it show the boot menu by holding shift?*

Run my script to finish installing GRUB:<br>
`./stage3b-finishgrub.sh`

Change the password:<br>
`passwd`

Now, we must reboot:<br>
`exit`<br>
`umount /mnt/home`<br>
`umount /mnt`<br>
`reboot`

Wait for reboot. If the installation media boots again, select "Boot existing OS" or similar options to boot into the installation.

Should be able to log in now. If not, we failed something and should start all over again.

## Stage 4: Now, back on the installation media...

`pacman -Sy openssh linux-headers linux-lts linux-lts-headers wpa_supplicant wireless_tools`<br>
Packages:
* linux-headers: Recommended.
* linux-lts: Recommended. This is a secondary kernel, useful as a backup. Accessible via the boot menu.
* linux-lts-headers: Recommended to go with the LTS kernel.
* wpa\_supplicant: Required in order to use a wireless card. Recommended otherwise.
* wireless\_tools: Optional.

Ensure `/dev/sda1` and `/dev/sda3` are shown:<br>
`df -h`

## Stage 5: Post-installation steps...

We're not using a swap partition right now. Verify this with:<br>
`free -m`<br>
Swap should show 0 total.

Check what the swap partition is:<br>
`fdisk -l`

Set up the swap partition:<br>
`mkswap /dev/sda2`<br>
We should now get a UUID. Copy this down. (This is where SSH is useful.)

`vi /etc/fstab`<br>
Add a new line somewhere (substituting `<YOUR UUID>` with the UUID you just wrote):<br>
```
UUID=<YOUR UUID>              none                   swap                defaults                0 0
```

Note on the above: If you're using an SSD, you should also add `discard` to  the root and data partitions (or whatever is on an SSD).<br>
This sets up trim support.<br>
Don't do this with a hard drive.<br>

`reboot`

Wait for reboot...

`free -m`<br>
Swap should show values now.

If wired connection:<br>
`ip a`<br>
`dhcpcd`<br>
If a wireless connection, see the source video <https://www.youtube.com/watch?v=GCUmGtCYPWM>, at about 8:10.

`pacman -Sy networkmanager network-manager-applet wpa_actiond dialog`<br>
If you see "There are x providers available for libgl", just use the default.

`pacman -Sy xf86-input-libinput xorg-server xorg-xinit xorg-apps mesa`<br>
xf86-input-libinput is for if you use a trackpad. Otherwise, it's optional.

Now, we install the video driver.

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

## Stage 7: Continuing on...

Now, install sudo:<br>
`pacman -Sy sudo`

Now, we want to allow all members of group wheel to execute any command:<br>
`visudo`<br>

Uncomment:<br>
```
%wheel ALL=(ALL) ALL
```

Or, if you want just a specific user (e.g. the user simshadows):<br>
```
simshadows ALL=(ALL) ALL
```

Create your own user account:<br>
`useradd -m -G wheel -s /bin/bash <putnamehere>`

Set password:<br>
`passwd <putnamehere>`

Check if you have a home directory:<br>
`ls /home`

Change machine name:<br>
`hostnamectl set-hostname <putnamehere>`

## Stage 8: Installing display managers and desktop environments

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

## Stage 9: Recommended Programs

Now that the important stuff is done, let's install more programs!

You can find packages at [https://www.archlinux.org/packages/](archlinux.org/packages). Install anything you want, it's up to you! :)

Here's what I use:

### Absolute Essentials

```
base-devel
git
tmux
```

### Core CLI and Minimalist GUI Applications

```
gvim               <<cli text editor>>
ranger             <<cli file manager>>
lynx               <<cli web browser>>
feh                <<image viewer>>
zathura            <<document viewer>>
zathura-pdf-mupdf  <<zathura mupdf plugin to view pdfs>>
```

*Note: `gvim` installed since `vim` otherwise installs a minimal build, which annoyingly lacks clipboard support.*

### Core Full Graphical Applications

```
sublime-text  <<text editor>> (Requires extra set-up. See https://www.sublimetext.com/)
thunar        <<file manager>>
firefox       <<web browser>>
```

### Core Development Tools

```
ctags     <<code indexing>>
gdb       <<gnu debugger>>
lldb      <<llvm debugger>>
valgrind  <<memory debugger>>
strace    <<for debugging interactions between a process and the kernel>>
```

More development tools:

```
ruby      <<ruby>>
```

### Fonts

It is highly recommended to get at least one good terminal font. I currently use `adobe-source-code-pro-fonts`.

Other fonts worth

### Miscellaneous Highly Recommended

Fairly standard command line utilities

```
wget               <<simple web content retriever>>
netcat             <<network utility>>
lsof               <<lists all open files>>
tree               <<recursive directory lister>>
zip                <<zip archive utility for compressing>>
unzip              <<zip archive utility for uncompressing>>
xclip              <<clipboard cli interface, useful for tmux>>
htop               <<a much more useful process monitor>>
dos2unix           <<converts between unix-style and dos-style line breaks>>
dosfstools         <<dos filesystems>>
ntfs-3g            <<ntfs filesystem>>
```

Other software:

```
scrot              <<makes screenshots>>
nmap               <<maps the network, e.g. ping/port scans>> (Warning: Be ethical.)
sshfs              <<for mounting remote directories over SSH>>
weechat            <<irc client>>
rtorrent           <<bittorrent client>>
p7zip			   <<7zip POSIX port>>
texlive-most       <<latex distribution>> (Warning: Very large install.)
biber              <<latex reference management>>
libreoffice-still  <<libreoffice, stable branch>> (Warning: Very large install.)
```

Offline documentation:

```
arch-wiki-docs	   <<arch wiki>>
```

### Might be useful

```
screenfetch  <<prints basic system info, usually to show off in screenshots>>
```

### Domain Specific: Security

```
bless       <<gui hex editor>>
steghide    <<steganography program to hide or extract info in image and audio files>>
yara        <<???>>
```


# Installing Arch ARM on a Raspberry Pi 3

## Stage 1: Partition and format the SD card.

Instructions from the official website can be found at <https://archlinuxarm.org/platforms/armv8/broadcom/raspberry-pi-3>. But for reference, I'll copy them here in stage 1 and 2 of this installation procedure.

On a Linux system,start `fdisk` on the SD card with `fdisk /dev/sdX` (substituting `/dev/sdX` with the appropriate device). Enter `o` to clear partitions.

We want to make the following partitions:
1. Partition 1 (primary) spans the first 100MB, and is type W95 FAT32 (partition code `c`).
2. Partition 2 (primary) spans the remaining space and is a Linux partition.

To do this:
1. Enter `n` to create the first partition. Enter all defaults except the last sector, which should be `+100M`. After that, enter `t` to change the partition type. Enter `c` as the partition type code.
2. After creating the first partition, enter `n` again and simply enter all defaults.

Once all of this is done, enter `w` to write the partition table.

## Stage 2: Load the Arch Linux ARM files to the SD card.

Format the two partitions (again substituting `/dev/sdX` with the appropriate device):

```
mkfs.vfat /dev/sdX1
mkfs.ext4 /dev/sdX2
```

Mount them:

```
cd /mnt
mkdir boot
mkdir root
mount /dev/sdX1 boot
mount /dev/sdX2 root
```

Download and extract the root filesystem:

```
wget http://os.archlinuxarm.org/os/ArchLinuxARM-rpi-3-latest.tar.gz
tar -zxvf ArchLinuxARM-rpi-2-latest.tar.gz -C root
sync
```

Move boot files:

```
mv root/boot/* boot
```

Unmount both partitions:

```
umount boot root
```

Insert the SD card into the Pi 3.

## Stage 3: Setting up Wi-Fi

Log in as `root`/`root`.

Now, we're likely using wifi, so let's set that up. 

Create the WPA supplicant config file (entering the appropriate SSID and password in the quotes):

```
wpa_passphrase SSID_PLACEHOLDER PASSPHRASE_PLACEHOLDER > /etc/wpa_supplicant/wpa_supplicant-wlan0.conf
```

Recommended: Remove the commented plaintext passphrase from `/etc/wpa_supplicant/wpa_supplicant-wlan0.conf`.

Configure WPA supplicant and dhcpcd to start on bootup (so we immediately connect via wi-fi):

```
systemctl enable --now wpa_supplicant@wlan0.service
systemctl enable --now dhcpcd.service
```

Verify that we're connected with `ip addr` and `ping 8.8.8.8`.

## Stage 4: Post-installation

Initialize `pacman`, update the system, and install `sudo`:

```
pacman-key --init
pacman -Syu sudo
```

TODO: Add more to this.
