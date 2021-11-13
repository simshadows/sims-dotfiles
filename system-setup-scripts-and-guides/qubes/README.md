# WORK-IN-PROGRESS: Qubes OS Personal Notes

**I haven't managed to get a fully-working Qubes OS installation yet. As such, this document is incomplete and only has the parts I got working well.**

*My Qubes OS machine is the **ASUS Zephyrus G14 GA401Q** with AMD Ryzen 7 5800HS and Nvidia GTX 1650. Instructions on this page may relate to this specific configuration alone.*

## General

### General Applications

- `thunar` (Default GUI file manager)

### Useful Commands

Manually sync the system clock:
```
[user@dom0]$ sudo qvm-sync-clock
```

## Setup: Initial Stages

*To get my setup working, I referred partially to [Alethia's HCL report for an older Zephyrus G14](https://forum.qubes-os.org/t/asus-rog-zephyrus-g14-ga401iv-ha112r-14/3245).*

At the time of writing (2021-11-07), these were the relevant versions of Qubes:

- 4.0.4 (latest stable release), and
- 4.1.0-rc1 (latest testing release).

Booting the 4.0.4 image on a USB drive would hang on a black screen indefinitely on bootup, so I had to use 4.1.0-rc1.

The 4.1.0-rc1 installation is smooth with no issues. However, `sys-net` is unable to use the Wifi, despite the device `02:00.0 Network controller: MEDIATEK Corp.` being passthrough'd to it.

In Alethia's report:

> Since kernel 5.4 has some limitations (no wifi, hdmi etc.) download 5.11.4-1 via another computer from: [Index of /r4.1/current-testing/dom0/fc32/rpm/](https://yum.qubes-os.org/r4.1/current-testing/dom0/fc32/rpm/) 13 (both kernel-latest for dom0 and kernel-latest-qubes-vm for vms)

I navigated to that linked page and downloaded the following files and loaded it onto another flash drive:

- `kernel-latest-5.14.15-1.fc32.qubes.x86_64.rpm`
- `kernel-latest-qubes-vm-5.14.15-1.fc32.qubes.x86_64.rpm`

I inserted the flash drive, then attached it to the `untrusted` qube.

It didn't automatically mount. Relevant commands in `untrusted`:
```
[user@untrusted]$ sudo fdisk -l
[user@untrusted]$ mount
```

I identified the disk `/dev/xvdi` to be the flash drive. I mounted to `/mnt`, copied to `untrusted`'s home, then unmounted and removed the drive. Relevant commands in `untrusted`:
```
[user@untrusted]$ sudo mount /dev/xvdi /mnt
[user@untrusted]$ cp /mnt/*.rpm ~
[user@untrusted]$ sudo umount /mnt
```

I copied the two files to `dom0` (using [this guide](https://github.com/Qubes-Community/Contents/blob/master/docs/common-tasks/copying-files-to-dom0.md)). Relevant commands in `dom0`:
```
[user@dom0]$ qvm-run --pass-io untrusted "cat /home/user/kernel-latest-5.14.15-1.fc32.qubes.x86_64.rpm" > kernel-latest-5.14.15-1.fc32.qubes.x86_64.rpm
[user@dom0]$ qvm-run --pass-io untrusted "cat /home/user/kernel-latest-qubes-vm-5.14.15-1.fc32.qubes.x86_64.rpm" > kernel-latest-qubes-vm-5.14.15-1.fc32.qubes.x86_64.rpm
```

I installed the two packages as per Alethia's report, then checked available kernels. Relevant commands:
```
[user@dom0]$ sudo dnf install kernel-latest-5.14.15-1.fc32.qubes.x86_64.rpm
[user@dom0]$ sudo dnf install kernel-latest-qubes-vm-5.14.15-1.fc32.qubes.x86_64.rpm
[user@dom0]$ rpm -qa | grep kernel
```

I checked kernel versions:
```
[user@dom0]$ cat /proc/version
[user@untrusted]$ cat /proc/version
[user@sys-net]$ cat /proc/version
```

It's still on the older 5.10.71-1 kernel.

Using the Qube Manager GUI, I shut down `sys-net`, then set only `sys-net` to use the new kernel. I then started `sys-net` and `sys-firewall` again (since `sys-firewall` shut down automatically).

**Wifi now works! I simply connected to my home wifi, and now I have internet access!**

Continuing to use the Qubes Manager GUI, I set the `personal` qube to use the `debian-11` template since I'm more comfortable using that for general computing, then edited the applications list since `debian-11`'s applications are different to `fedora-34`.

## Setup: Updating and debugging post-update wifi issues

I ran the Qubes Update GUI tool, but only `debian-11` and `fedora-34` successfully updated.

Also, every time I saw the Tor wizard, I set it to "Disable" for now since I want to get the basics of the system set up first. (Also, when I try to set it up, it doesn't work anyway.)

I rebooted, but when I logged back in, Qubes crashed and went back into boot.

When I logged in again, `sys-net` didn't launch automatically. But when I looked to see the devices attached to the qube through the Qube Manager GUI, the network card is no longer recognized.

To solve this, I had to reset the networking card. To do this with the Zephyrus G14, I press-and-held the power button for about 1.5 minutes (you're meant to do 60 seconds, but from experience, this sometimes fails). When I log back in again after, the network card is recognized again and the system works as normal.

At this point, I'm experiencing three problems:

- `dom0`, `whonix-gw-16`, and `whonix-ws-16` fails to update,
- Tor wizard won't set up, and
- Firefox is complaining that my clock is out of sync when I try to visit YouTube.

Turns out, Firefox is right and that's the cause of all three issues. I synced the clock with this command:
```
[user@dom0]$ sudo qvm-sync-clock
```

Tor setup now succeeds. (Do this by opening Anon Connection Wizard through the `sys-whonix` app menu. If it still fails, restart the `sys-whonix` qube.)

## Setup: Further Work

I haven't gotten Qubes working acceptably past this point. I will give up on getting `4.1.0-rc1` to work for now and try again later with future Qubes versions.
