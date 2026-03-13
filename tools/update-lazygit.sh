#!/bin/bash

# Update/Install Lazygit
# Usage: ./update-lazygit.sh

set -e

echo "Fetching latest lazygit release..."

# Get latest version tag
LATEST_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": *"v\K[^"]*')

if [ -z "$LATEST_VERSION" ]; then
    echo "Error: Could not fetch latest version."
    exit 1
fi

echo "Latest version: v$LATEST_VERSION"

# Check installed version
if command -v lazygit &> /dev/null; then
    CURRENT_VERSION=$(lazygit --version | grep -Po "version \K[0-9.]+")
    if [ "$CURRENT_VERSION" == "$LATEST_VERSION" ]; then
        echo "lazygit is already up to date (v$CURRENT_VERSION)."
        # Still update config just in case
        echo "Updating configuration..."
        mkdir -p "$HOME/.config/lazygit"
        if [ -f "$HOME/dotfiles/lazygit/config.yml" ]; then
            cp "$HOME/dotfiles/lazygit/config.yml" "$HOME/.config/lazygit/config.yml"
            echo "Configuration updated."
        else
            echo "Warning: ~/dotfiles/lazygit/config.yml not found."
        fi
        exit 0
    fi
    echo "Updating from v${CURRENT_VERSION:-unknown} to v$LATEST_VERSION..."
else
    echo "Installing lazygit v$LATEST_VERSION..."
fi

# Create temp dir
TEMP_DIR=$(mktemp -d)
cd "$TEMP_DIR"

echo "Downloading lazygit_v${LATEST_VERSION}_Linux_x86_64.tar.gz..."
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/v${LATEST_VERSION}/lazygit_${LATEST_VERSION}_Linux_x86_64.tar.gz"

echo "Extracting..."
tar xf lazygit.tar.gz lazygit

echo "Installing to ~/.local/bin/lazygit..."
mkdir -p "$HOME/.local/bin"

# Remove old symlink or binary if exists
if [ -L "$HOME/.local/bin/lazygit" ] || [ -f "$HOME/.local/bin/lazygit" ]; then
    rm -f "$HOME/.local/bin/lazygit"
fi

mv lazygit "$HOME/.local/bin/lazygit"
chmod +x "$HOME/.local/bin/lazygit"

# Clean up
cd - > /dev/null
rm -rf "$TEMP_DIR"

# Update configuration
echo "Updating configuration..."
mkdir -p "$HOME/.config/lazygit"
if [ -f "$HOME/dotfiles/lazygit/config.yml" ]; then
    cp "$HOME/dotfiles/lazygit/config.yml" "$HOME/.config/lazygit/config.yml"
    echo "Copied config.yml to ~/.config/lazygit/"
else
    echo "Warning: ~/dotfiles/lazygit/config.yml not found. Configuration not updated."
fi

echo "✓ lazygit updated to v$LATEST_VERSION"
lazygit --version
