# filename: setup-windows.ps1
# author:   simshadows <contact@simshadows.com>

echo "=== Version Control ==="

echo "Setting up symlinks..."

New-Item -Force -ItemType SymbolicLink `
    -Path $env:USERPROFILE\AppData\Roaming\Subversion\config `
    -Value $PSScriptRoot\.subversion\config

echo "Done!"
echo ""
