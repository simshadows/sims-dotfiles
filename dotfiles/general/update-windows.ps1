# filename: update-windows.ps1
# author:   simshadows <contact@simshadows.com>

echo "=== General ==="

echo "Copying files into the repository..."

cp $env:USERPROFILE\AppData\Roaming\vlc\vlcrc $PSScriptRoot\.config\vlc\vlcrc

echo "Done!"
echo ""