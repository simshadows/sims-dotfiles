#!/bin/bash

# Enable VBoxClient features (such as auto-resize), or fail silently
VBoxClient-all || true
# Load .Xresources file
[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources
# Launch i3 window manager
exec i3
