# Arch Linux Installation

This guide currently is designed mostly for personal reference, and not a newbie guide. But if you like what you see, use it by all means! :)

To save on the tedium, I have written some sections into scripts.

*(I'll link to a proper newbie guide when I find one that I can vet!)*

## Stage 0: Prerequisites

This guide is specifically only applicable for a setup involving the following:

- EFI systems only (not BIOS systems)
- GPT partition table
- A single disk device containing only two partitions: EFI system partition and root partition
- LUKS encryption without LVM
- Uses a swapfile, not a swap partition

If you're using VirtualBox, you'll need to turn EFI on.

## Stage 1: From the installation media...

### Does the system use EFI?

Run the command:
```
efibootmgr
```

If you get `EFI variables are not supported on this system.`, then you are not booted in with EFI. Otherwise, the command should print out a whole bunch of values.

### Internet Connection

Check our IP address and ping Google's DNS server to check the internet connection:
```
ip a
ping -c 5 8.8.8.8
```

If you're on ethernet, it should immediately work. If you need to connect to a wireless network, you'll need to do to follow the steps below.

Launch interactive prompt:
```
iwctl
```

List Wi-Fi devices, scan for networks, list all available networks, then connect to one (this may prompt you for a passphrase if needed):
```
device list
station <YOUR_DEVICE_HERE> scan
station <YOUR_DEVICE_HERE> get-networks
station <YOUR_DEVICE_HERE> connect <SSID>
```

Verify you're connected:
```
station <YOUR_DEVICE_HERE> show
```

### Creating physical partitions

Verify available storage devices:
```
fdisk -l
```

Launch fdisk:
```
fdisk /dev/sda
```

We want to make:

- **EFI system partition**
    - I make this 512MiB, and of GPT partition type `uefi`/`EFI System`/`C12A7328-F81F-11D2-BA4B-00A0C93EC93B`.
- **A root partition**
    - Takes up the remaining space.

Useful commands within `fdisk`:

- `g` creates a new GPT partition table. Use this command first.
- `n` creates a new partition.
    - *Generally want default partition numbers.*
    - *Generally also want the default first sector, which is the next available sector.*
    - *For last sector, specify sizes. E.g. for 512MiB, type +512M. Otherwise, the default value of last sector takes up the remaining portion of the drive.*
- `type` sets partition types.
- `w` writes changes to disk. Use this command last.

Afterwards, verify available storage devices again:
```
fdisk -l
```

*We will now assume that `/dev/sda1` is the boot partition and `/dev/sda2` is the root partition.*

### Setting up your root partition

#### Option 1: Encrypted using LUKS

*(We follow the steps from [LUKS on a partition](https://wiki.archlinux.org/title/Dm-crypt/Encrypting_an_entire_system#LUKS_on_a_partition) here.)*

Format the root physical partition as LUKS:
```
cryptsetup -vy luksFormat /dev/sda2
```

Open the LUKS physical partition as `/dev/mapper/cryptroot`:
```
cryptsetup open /dev/sda2 cryptroot
```

Check and see that `cryptroot` can be seen from `fdisk`:
```
fdisk -l
```

Format filesystems (the UEFI partition must be FAT12/FAT16/FAT32):
```
mkfs.fat -F32 /dev/sda1
mkfs.ext4 /dev/mapper/cryptroot
```

Mount the filesystems:
```
mount /dev/mapper/cryptroot /mnt
mkdir /mnt/boot
mount /dev/sda1 /mnt/boot
```

#### Option 2: Unencrypted

Format filesystems:
```
mkfs.fat -F 32 /dev/sda1
mkfs.ext4 /dev/sda2
```

Mount our partitions:
```
mount /dev/sda2 /mnt
mkdir /mnt/boot
mount /dev/sda1 /mnt/boot
```

### Continuing on...

Check what's mounted:
```
mount
```

If we successfully mounted everything, we should be able to see something like this:
```
/dev/mapper/cryptroot on /mnt type ext4 (rw,relatime)
/dev/sda1 on /mnt/boot type ext4 (rw,relatime)
```

Install base package to disk:
```
pacstrap -i /mnt base
```

Create filesystems table file:
```
genfstab -U -p /mnt >> /mnt/etc/fstab
```

## Stage 2: Downloading my helper scripts

Tnstall git into the RAM-disk and clone the repository:
```
pacman -Sy git
git clone https://github.com/simshadows/sims-dotfiles.git /mnt/root/dotfiles
```

## Stage 3: Continuing from within the Arch installation...

Chroot into installation, and change directory for convenience:
```
arch-chroot /mnt
cd /root/dotfiles/system-setup-scripts-and-guides/arch-linux
```

We're not using the swapfile (or any swap partition) right now. Verify this by checking zero swap space:
```
free -m
```

Now, we will run `stage3.sh`. First, check through the script to see if you need to make any edits:
- Create and enable a 16GB swapfile at `/swapfile`
    - **Edit the script if you want a different size.**
- Generate locale to `en_AU.UTF-8`.
- Set our timezone to `Australia/Sydney`.
- Set the hardware clock.
- Install the bootloader, standard Linux kernel, and efibootmgr.
- Edits mkinitcpio hooks then regenerates preset.
    - **Edit the script to remove this if you're not using LUKS.**
- Install GRUB bootloader.
- Sets GRUB language to `en`.
- Sets `GRUB_CMDLINE_LINUX`.
    - **Edit the script to remove this if you're not using LUKS.**
- Installs some very common packages.
    - **Edit the script if you want a more minimal system.**
- Sets up a DHCP client.
    - *Allows us to automatically connect to the internet when we have a connection.*
- Sets up NetworkManager.
    - *It's required by a lot of Desktop Environments for their wireless networking tools (but for some reason doesn't come with them).*

Run the script:
```
./stage3.sh
```

Check now that we have swap space:
```
free -m
```

Optional: If you're using a laptop, install TLP to improve power efficiency and the `gnome-power-statistics` tool for tracking charge:
```
pacman -Sy tlp gnome-power-manager
systemctl enable tlp.service
```

Optional: Change `root`'s password if you want the account enabled:
```
passwd
```

Add user account, set user password, and change machine name:
```
useradd -m -s /bin/bash simshadows
passwd simshadows
hostnamectl set-hostname YOUR_MACHINE_NAME_HERE
```

Now, we want to add `simshadows ALL=(ALL) ALL` to the sudoers file using:
```
visudo
```

Now that we have our user account, we can install yay (my preferred AUR helper).
```
# sudo -u simshadows bash
$ cd
$ git clone https://aur.archlinux.org/yay.git tmp-yay
$ cd tmp-yay
$ makepkg -si
```

Now, we can reboot to check if our installation was done correctly:
```
exit
umount /mnt/boot
umount /mnt
cryptsetup close cryptroot
reboot
```

Ensure `/dev/sda1` and `/dev/mapper/cryptroot` are shown (or `/dev/sda2`):
```
df -h
```

## Stage 4: TRIM Support

If you want to use TRIM, you'll need to do some manual tweaks yourself.

(I haven't quite figured this out yet though since I'm using root filesystem encryption, but if you aren't using encryption, you can just add `discard` to `/etc/fstab` where needed.)

(I'll updated this section once I figured it out.)

## Stage 5: Installing the video driver

Use to check what card you're using:
```
lspci
```

You may need to do your own research into what driver to use, but here are some suggestions:

### Virtualbox

```
pacman -Sy virtualbox-guest-utils xf86-video-vmware
systemctl enable vboxservice.service
```

xf86-video-vmware assumes you're using the VMSVGA virtual graphics controller.

### Intel driver

```
pacman -Sy xf86-video-intel
```

### AMD driver

```
pacman -Sy xf86-video-amdgpu
```

### Open-source Nvidia driver

*(If you want performance, you probably don't want the open-source driver. Use the proprietary driver for this.)*

```
pacman -Sy xf86-video-nouveau lib32-nouveau-dri
```

If that succeeds, go to the next section.

Otherwise, if that fails, you might need to allow 32-bit packages to be installed. Do the following:

```
vi /etc/pacman.conf
```

Uncomment:
```
[multilib]
Include = /etc/pacman.d/mirrorlist
```

Then, attempt to install again.

### Proprietary Nvidia driver

```
pacman -Sy nvidia lib32-nvidia-libgl nvidia-utils nvidia-settings
```

### Vesa driver (allows you to use any card, but very minimal)

```
pacman -Sy xf86-video-vesa
```

## Stage 6: Installing display managers and desktop environments

Pick one of the options below (or do some research into others you might be interested in).

Note that both minimalist recommendations include terminals. That's because without one, you literally can't do anything.

### KDE

Full KDE:
```
pacman -Sy sddm \
    plasma-meta \
    rxvt-unicode \
    dolphin \
    ark \
    filelight \
    spectacle \
    kolourpaint
systemctl enable sddm
reboot
```

Extras:
```
yay ttf-twemoji
```

You'll also need to fix locale issues by going *System Settings* > *Regional Settings* > *Formats* and setting *Region* to *Australia - Australian English (en_AU)*, then reboot. Without doing this, you end up with really weird behaviour.

Additional things I like to configure:

- **Appearance-related configuration**:
    - *System Settings* > *Appearance* > *Global Theme*
        - Set to *Breeze Dark*.
        - > *Window Decorations*, set to *Plastik* to get the familiar minimize/maximize/close buttons.
    - Right-click on your desktop > *Configure Desktop and Wallpaper...*, set to *Plain Color* and set the colour to `#191c1e`/`rgb(252,28,30)`.
    - *System Settings* > *Workspace Behavior*
        - > *Screen Locking* > *Apperance: Configure...*, set to the same colour as the desktop.
        - > *General Behavior*, set animation speed to instant.
- **Functionality-related configuration**:
    - *System Settings* > *Input Devices* > *Touchpad*, enable *Tap-to-click* and consider enabling *Tap-and-drag*.
    - *System Settings* > *Workspace Behavior*
        - > *Virtual Desktops*, set up 10 desktops named `Desktop 1` through to `Desktop 10`, set up as two rows.
    - *System Settings* > *Shortcuts*
        - > *KWin*
            - Bind *Switch to Desktop 1:* to `Alt+1`, and so on for all 10 desktops.
            - Bind *Window to Desktop 1:* to `Alt+Shift+1`, and so on for all 10 desktops.
            - Bind *Toggle Present Windows (Current desktop):* to `Alt+\``.

### GNOME

Full GNOME:
```
pacman -Sy gdm gnome gnome-extra
systemctl enable gdm
reboot
```

Alternative minimal GNOME:
```
pacman -Sy gdm gnome-shell gnome-terminal gnome-control-center
systemctl enable gdm
reboot
```

`networkmanager` is required if you want GNOME to manage your wireless networking connection.

If weird things are happening and you can't even open up a terminal, you should go into settings, find *Region & Language*, and fix up any weird values you see there. That should fix it.

### Minimalist i3

```
pacman -Sy gdm i3 rxvt-unicode thunar
systemctl enable gdm
reboot
```

*Note: GDM is the display manager, but it's heavily bloated. Consider installing LightDM or some other lighter-weight display manager instead. The only reason I personally use GDM is because LightDM doesn't work in a VirtualBox guest for some reason.*

## Stage 7: Recommended Programs

You can install a tonne of stuff I use by running my script:
```
./stage8-installpackages.sh
```

You can also read the script and edit it yourself as needed.

Do note that this script will require you to interact with any prompts. I left it this way to make sure we understand the options we're choosing here.
