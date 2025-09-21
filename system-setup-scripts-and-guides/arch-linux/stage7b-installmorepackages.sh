#!/usr/bin/env sh

# Terminate script on error
set -e

# Empty array.
a=()

###########################################################


a+=( discord )


#
# Security Stuff
#
#a+=( bless    ) # GUI hex editor (TODO: Seems to be in the AUR now.)
#a+=( steghide ) # steganography program to hide or extract info in image/audio files
#a+=( yara     ) # (TODO: idk how to describe this one lol)


###########################################################

# Start installation of all specified packages!
pacman -Sy "${a[@]}"

