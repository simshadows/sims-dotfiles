# filename: setup-windows.ps1
# author:   simshadows <contact@simshadows.com>

echo "=== VSCodium ==="

echo "Setting up symlinks..."

New-Item -Force -Path $env:USERPROFILE\AppData\Roaming\VSCodium\User\settings.json -ItemType SymbolicLink -Value $PSScriptRoot\.config\VSCodium\User\settings.json

echo "Done!"
echo ""