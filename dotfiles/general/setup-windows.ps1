# filename: setup-windows.ps1
# author:   simshadows <contact@simshadows.com>

echo "=== General ==="

echo "Setting up symlinks..."

cp $PSScriptRoot\.config\vlc\vlcrc $env:USERPROFILE\AppData\Roaming\vlc\vlcrc
# We should symlink the file, but VLC seems to delete the symlink and replace it every time it updates the settings.
#New-Item -Force -Path $env:USERPROFILE\AppData\Roaming\vlc\vlcrc -ItemType SymbolicLink -Value $PSScriptRoot\.config\vlc\vlcrc

echo "Done!"
echo ""