# filename: choco-install-packages.ps
# author:   simshadows <contact@simshadows.com>
#
# I install all of these packages whenever I reinstall Windows.

choco install firefox `
    chromium `
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
    rufus `
    windirstat `
    audacity `
    yt-dlp `
    qbittorrent `
    virtualbox `
    winaero-tweaker

# I don't install DisplayCAL using Chocolatey due to bad experiences with it when I tried.
# (Granted, they were super-minor issues, but this is probably one program that I will just
# install separately.)

# Additional packages for manual installation as needed:
#
#   Software development:
#       bruno
#       tortoisesvn
#       alacritty  # A useful terminal, but it has no tabs. I should fine one with tabs.
#
#   Network admin/debugging:
#       wireshark
#       iperf3
#
#   General utilities:
#       adobereader
#       hwinfo
#       ventoy
#       fah        # Folding@home, useful to put a long sustained all-system load.
#
#   Hardware benchmarking:
#       geekbench
#       crystaldiskmark
#       aida64-extreme
