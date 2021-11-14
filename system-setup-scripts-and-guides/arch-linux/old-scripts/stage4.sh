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

# We install LTS kernel and wireless networking packages.
#pacman -Sy --noconfirm linux-lts linux-lts-headers wpa_supplicant wireless_tools wpa_actiond
# wpa_supplicant is required to use a wireless card.
# wireless_tools is optional.

# We install networking packages.
#pacman -Sy --noconfirm networkmanager network-manager-applet

# We install some more optional packages.
#pacman -Sy --noconfirm dialog

echo ""

# We first grab the UUID that the user found.
swpuuid=$(egrep -o 'UUID=[0-9a-f]{8}-([0-9a-f]{4}-){3}[0-9a-f]{12}' tmp.txt)
# Now, we update /etc/fstab.
# We will append the following lines to the file:
swpcomment="# Swap Partition                          <dir> <type> <options> <dump> <pass>"
swpline="$swpuuid none  swap   defaults  0      0"
# Print some information for the user.
echo "Appending swap partition entry to fstab:"
echo "$swpcomment"
echo "$swpline"
echo ""
# Now, we actually do the appending.
echo "$swpcomment" >> /etc/fstab
echo "$swpline" >> /etc/fstab
echo "" >> /etc/fstab

