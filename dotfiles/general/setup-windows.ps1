# filename: setup-windows.ps1
# author:   simshadows <contact@simshadows.com>

echo "=== General ==="

echo "Setting up symlinks..."

New-Item -Force -ItemType SymbolicLink `
    -Path $env:USERPROFILE\.claude\CLAUDE.md `
    -Value $PSScriptRoot\.claude\CLAUDE.md
New-Item -Force -ItemType SymbolicLink `
    -Path $env:USERPROFILE\.claude\settings.json `
    -Value $PSScriptRoot\.claude\settings.json

cp $PSScriptRoot\.config\vlc\vlcrc $env:USERPROFILE\AppData\Roaming\vlc\vlcrc
# We should symlink the file, but VLC seems to delete the symlink and replace it every time it updates the settings.
#New-Item -Force -Path $env:USERPROFILE\AppData\Roaming\vlc\vlcrc -ItemType SymbolicLink -Value $PSScriptRoot\.config\vlc\vlcrc

echo "Done!"
echo ""
