#!/bin/bash

set -euo pipefail

LATEST_VERSION=$(curl -s https://api.github.com/repos/neovim/neovim/releases/latest | grep '"tag_name":' | sed -E 's/.*"v?([^"]+)".*/\1/')

if [ -z "$LATEST_VERSION" ]; then
    echo "Error: Could not fetch the latest Neovim version from GitHub."
    exit 1
fi

CURRENT_VERSION=""
if command -v nvim >/dev/null 2>&1; then
    CURRENT_VERSION=$(nvim --version | head -n 1 | awk '{print $2}' | sed 's/^v//')
fi

echo "=== neovim ==="
echo "Installed: ${CURRENT_VERSION:-none}"
echo "Latest:    $LATEST_VERSION"
echo

if [ "$CURRENT_VERSION" = "$LATEST_VERSION" ]; then
    echo "✓ Neovim is already the latest stable version."
    echo
    exit 0
fi

read -rp "Update neovim to $LATEST_VERSION? [y/N] " answer
if [[ ! "$answer" =~ ^[Yy]$ ]]; then
    echo "Aborted."
    exit 0
fi

echo "Downloading neovim..."
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.appimage
chmod u+x nvim-linux-x86_64.appimage
sudo mv ./nvim-linux-x86_64.appimage /usr/local/bin/nvim
echo "✓ Neovim is now updated!"
echo
nvim --version | head -1