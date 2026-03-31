#!/bin/bash

# Get current version (e.g., v0.10.0)
if command -v nvim >/dev/null 2>&1; then
    CURRENT_VERSION=$(nvim --version | head -n 1 | awk '{print $2}')
else
    CURRENT_VERSION="none"
fi

# Get latest version from GitHub API
LATEST_VERSION=$(curl -s https://api.github.com/repos/neovim/neovim/releases/latest | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')

if [ -z "$LATEST_VERSION" ]; then
    echo "❌ Error: Could not fetch the latest Neovim version from GitHub."
    exit 1
fi

echo "Current Neovim version: $CURRENT_VERSION"
echo "Latest Neovim version:  $LATEST_VERSION"

if [ "$CURRENT_VERSION" == "$LATEST_VERSION" ]; then
    echo "✅ Neovim is already up to date!"
    exit 0
fi

echo "Updating Neovim..."
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.appimage
chmod u+x nvim-linux-x86_64.appimage
sudo mv ./nvim-linux-x86_64.appimage /usr/local/bin/nvim
echo "✅ Neovim updated successfully!"
nvim --version
