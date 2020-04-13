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
