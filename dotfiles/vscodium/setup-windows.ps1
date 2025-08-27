# filename: setup-windows.ps1
# author:   simshadows <contact@simshadows.com>

echo "=== VSCodium ==="

echo "Setting up symlinks..."

New-Item -Force -Path $env:USERPROFILE\AppData\Roaming\VSCodium\User\settings.json -ItemType SymbolicLink -Value $PSScriptRoot\.config\VSCodium\User\settings.json

echo "Installing snippets extension..."

New-Item -Path $env:USERPROFILE\.vscode-oss -Name extensions -ItemType Directory -Force

New-Item -Force -Path $env:USERPROFILE\.vscode-oss\extensions\simshadows.simshadows-snippets-0.0.1 -ItemType SymbolicLink -Value $PSScriptRoot\..\general\.common-resources\snippets-vscode

echo "Removing 'extensions.json' and '.obsolete' (otherwise the extension fails to install)..."

if (Test-Path $env:USERPROFILE\.vscode-oss\extensions\extensions.json) {
    Remove-Item $env:USERPROFILE\.vscode-oss\extensions\extensions.json
}
if (Test-Path $env:USERPROFILE\.vscode-oss\extensions\.obsolete) {
    Remove-Item $env:USERPROFILE\.vscode-oss\extensions\.obsolete
}

echo "Done!"
echo ""