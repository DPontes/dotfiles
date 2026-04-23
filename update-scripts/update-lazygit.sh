#!/bin/bash

set -euo pipefail

LATEST_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": *"v\K[^"]*')

if [ -z "$LATEST_VERSION" ]; then
    echo "Error: Could not fetch latest version."
    exit 1
fi

CURRENT_VERSION=""
if command -v lazygit &> /dev/null; then
    CURRENT_VERSION=$(lazygit --version | grep -oP "(?<!git )version=\K[0-9.]+" | head -1 || true)
fi

echo "=== lazygit ==="
echo "Installed: ${CURRENT_VERSION:-none}"
echo "Latest:    $LATEST_VERSION"
echo

if [ "$CURRENT_VERSION" = "$LATEST_VERSION" ]; then
    echo "✓ Lazygit is already the latest stable version."
    echo
    exit 0
fi

ARCH=$(uname -m)
case "$ARCH" in
    x86_64)  LG_ARCH="x86_64" ;;
    aarch64) LG_ARCH="arm64" ;;
    armv7l)  LG_ARCH="armv6" ;;
    *) echo "Unsupported arch: $ARCH"; exit 1 ;;
esac

TEMP_DIR=$(mktemp -d)
curl -sL "https://github.com/jesseduffield/lazygit/releases/download/v${LATEST_VERSION}/lazygit_${LATEST_VERSION}_Linux_${LG_ARCH}.tar.gz" | tar xz -C "$TEMP_DIR" lazygit

mkdir -p "$HOME/.local/bin"
rm -f "$HOME/.local/bin/lazygit"
mv "$TEMP_DIR/lazygit" "$HOME/.local/bin/lazygit"
chmod +x "$HOME/.local/bin/lazygit"
rm -rf "$TEMP_DIR"

echo "✓ Lazygit is now updated!"
echo