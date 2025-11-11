#!/usr/bin/env bash
# copilot-install.sh
# Install GitHub Copilot CLI on Ubuntu 24.04 LTS using the official .deb system package.
# Usage: chmod +x copilot-install.sh && ./copilot-install.sh
set -euo pipefail

TMPDIR=$(mktemp -d)
cleanup() {
  rm -rf "$TMPDIR"
}
trap cleanup EXIT

echo "==> Updating apt and installing prerequisites..."
sudo apt update
sudo apt install -y curl ca-certificates

echo "==> Detecting architecture..."
ARCH=$(dpkg --print-architecture)
case "$ARCH" in
  amd64) TAG_FILTER="linux_amd64.deb" ;;
  arm64|arm64*) TAG_FILTER="linux_arm64.deb" ;;
  *)
    echo "Unsupported architecture: $ARCH"
    echo "Supported: amd64, arm64"
    exit 1
    ;;
esac
echo "Detected architecture: $ARCH (will look for asset matching: $TAG_FILTER)"

API_URL="https://api.github.com/repos/github/copilot-cli/releases/latest"
echo "==> Querying GitHub releases for latest copilot-cli release..."
ASSET_URL=$(curl -s "$API_URL" \
  | grep '"browser_download_url":' \
  | grep "$TAG_FILTER" \
  | head -n 1 \
  | cut -d '"' -f 4 || true)

if [ -z "$ASSET_URL" ]; then
  echo "ERROR: Could not find a release asset for '$TAG_FILTER'."
  echo "Visit: https://github.com/github/copilot-cli/releases to pick a compatible asset manually."
  exit 1
fi

DEB_PATH="$TMPDIR/copilot.deb"
echo "==> Downloading: $ASSET_URL"
curl -L -o "$DEB_PATH" "$ASSET_URL"

echo "==> Installing copilot (.deb) via apt so dependencies are resolved..."
# Use apt install ./file.deb to let apt resolve dependencies
sudo apt install -y "./$DEB_PATH" || {
  echo "apt reported an error installing the package. Attempting to repair dependencies..."
  sudo apt -f install -y
  sudo apt install -y "./$DEB_PATH"
}

echo "==> Verifying installation..."
if command -v copilot >/dev/null 2>&1; then
  echo "copilot installed successfully: $(copilot --version 2>/dev/null || echo 'version unknown')"
else
  echo "ERROR: 'copilot' command not found after installation."
  exit 1
fi

cat <<'EOF'

Next step: Authenticate the Copilot CLI with your GitHub account.

If you are on a desktop machine (with a browser), run:
  copilot auth login
This will open a browser window to let you sign in with the GitHub account that has Copilot enabled.

If you are on a headless server (no browser), follow the device/browser flow:
- Run the same command:
    copilot auth login
  It will print instructions in the terminal. If it cannot open a browser automatically, it typically provides a URL and a code you can open on another machine with a browser to complete authentication.
- If you prefer to authenticate from a different machine, run 'copilot auth login' locally (with a browser) and copy any token or follow the on-screen steps.

After authentication, try a quick command:
  copilot chat
or
  copilot generate "create a bash script that prints Hello World"

For more details and troubleshooting see:
  https://github.com/github/copilot-cli

EOF

# end of script
