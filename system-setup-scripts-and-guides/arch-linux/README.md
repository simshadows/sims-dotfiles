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

List Wi-Fi devices:
```
device list
```

Scan for networks, then list all available networks:
```
station <YOUR_DEVICE_HERE> scan
station <YOUR_DEVICE_HERE> get-networks
```

Connect to network (this may prompt you for a passphrase if needed):
```
station <YOUR_DEVICE_HERE> connect <SSID>
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

You'll generally want to make:

- **EFI system partition**
    - I make this 512MiB, and of GPT partition type `uefi`/`EFI System`/`C12A7328-F81F-11D2-BA4B-00A0C93EC93B`.
- **A root partition**
    - Takes up the remaining space.
- *(Optionally, you can make a swap partition, but it's up to you to figure it out. For this guide, I'll be using a swapfile.)*

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

First, we'll need to install git into the RAM-disk:
```
pacman -Sy git
```

And now, we clone my repository!
```
git clone https://github.com/simshadows/sims-dotfiles.git /mnt/root/dotfiles
```

**IMPORTANT: Each script may need adjustments before running. Please read the "This will:" dotpoints and adjust the script if any of it is wrong!**

## Stage 3: Continuing from within the Arch installation...

Chroot into installation, and change directory for convenience:
```
arch-chroot /mnt
cd /root/dotfiles/system-setup-scripts-and-guides/arch-linux
```

Run my script:
```
./stage3.sh
```

`stage3.sh` will:
- Generate locale to `en_AU.UTF-8`.
- Set our timezone to `Australia/Sydney`.
- Set the hardware clock.
- Install the standard Linux kernel and its headers. *(Headers are optional.)*
- Edits mkinitcpio hooks then regenerates preset. **(This is probably not necessary if not using LUKS)**
- Install GRUB bootloader.
- Sets GRUB language to `en`.
- Sets `GRUB_CMDLINE_LINUX`. **(This is probably not necessary if not using LUKS)**
- Installs and sets up a DHCP client to allow us to connect to the internet.

Change `root`'s password:
```
passwd
```

Now, we must reboot:
```
exit
umount /mnt/boot
umount /mnt
cryptsetup close cryptroot
reboot
```

Wait for reboot. If the installation media boots again, select "Boot existing OS" or similar options to boot into the installation.

Should be able to log in as `root` now. If not, we failed something and should start all over again.

## Stage 4: Now that we have directly booted into our installation...

Ensure `/dev/sda1` and `/dev/sda2` are shown (or `/dev/mapper/cryptroot`):<br>
`df -h`

We're not using a swap partition right now. Verify this with:<br>
`free -m`<br>
Swap total should show 0 total.

~~Double-check what the swap partition is:~~<br>
~~`fdisk -l`~~

~~Set up the swap partition and tee the output into `tmp.txt`:~~<br>
~~`mkswap /dev/sda2 | tee tmp.txt`~~<br>
~~This should print out a UUID.~~

~~Run my script:~~<br>
~~`./stage4.sh`~~<br>
~~This will add an entry in `/etc/fstab` for the swap partition.~~<br>
~~Please double-check that the UUID it shows is consistent with the UUID from mkswap.~~

Note on the above: If you're using an SSD, you should also add `discard` to  the root and data partitions (or whatever is on an SSD).<br>
This sets up trim support.<br>
Don't do this with a hard drive.<br>

`reboot` if needed.

Wait for reboot...

~~`free -m`~~<br>
~~Swap should show values now.~~

## Stage 5: User account, hostname, and X.org.

Install sudo and X.org:<br>
`pacman -Sy sudo xorg-server xorg-xinit`

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

Additionally, we should enable the VirtualBox guest service:<br>
`systemctl enable vboxservice.service`

### Vesa driver (allows you to use any card, but very minimal)

`pacman -Sy xf86-video-vesa`

## Stage 7: Installing display managers and desktop environments

Pick one of the options below.

Note that both minimalist recommendations include terminals. That's because without one, you literally can't do anything.

### Minimalist i3

`pacman -Sy gdm i3 rxvt-unicode`

`systemctl enable gdm`

`reboot`

*Note: GDM is the display manager, but it's heavily bloated. Consider installing LightDM or some other lighter-weight display manager instead. The only reason I personally use GDM is because LightDM doesn't work in a VirtualBox guest for some reason.*

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

Do note that this script will require you to interact with any prompts. I left it this way to make sure we understand the options we're choosing here.
