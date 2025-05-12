# filename: choco-install-packages.ps
# author:   simshadows <contact@simshadows.com>
#
# I install all of these packages whenever I reinstall Windows.

choco install firefox `
    vlc `
    vscodium `
    sumatrapdf `
    libreoffice-fresh `
    drawio `
    git `
    putty `
    sourcetree `
    winmerge `
    7zip `
    podman-desktop `
    podman-cli `
    python `
    obs-studio `
    ffmpeg-full `
    rufus

# Additional packages for manual installation as needed:
#   adobereader
#   wireshark
#   hwinfo
#   geekbench
#   crystaldiskmark
#   aida64-extreme
#   iperf3
#   ventoy
#   tortoisesvn
#   fah        # Folding@home, useful to put a long sustained all-system load.
#   alacritty  # A useful terminal, but it has no tabs.