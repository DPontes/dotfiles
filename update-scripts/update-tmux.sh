#!/usr/bin/env bash
set -euo pipefail

GITHUB_API="https://api.github.com/repos/tmux/tmux"
CURRENT_VERSION=$(tmux -V 2>/dev/null | awk '{print $2}')
BUILD_DIR=$(mktemp -d)

trap 'rm -rf "$BUILD_DIR"' EXIT

# ──────────────────────────────────────────────────────────────────────
# Detect latest version from GitHub
# ──────────────────────────────────────────────────────────────────────
echo "=== tmux ==="
TARGET_VERSION=$(curl -sfL "$GITHUB_API/releases/latest" \
    | grep '"tag_name"' | head -1 | sed 's/.*: "//;s/".*//')

if [ -z "$TARGET_VERSION" ]; then
    echo "✗ Could not determine latest tmux version. Check your internet connection."
    exit 1
fi

echo "Installed: ${CURRENT_VERSION:-none}"
echo "Latest:    $TARGET_VERSION"
echo

if [ "${CURRENT_VERSION}" = "${TARGET_VERSION}" ]; then
    echo "✓ Tmux is already the latest stable version."
    echo
    exit 0
fi

# ──────────────────────────────────────────────────────────────────────
# Offer to show changelog between installed and latest version
# ──────────────────────────────────────────────────────────────────────
read -r -p "View changelog between $CURRENT_VERSION and $TARGET_VERSION? [y/N] " show_log
if [[ "$show_log" =~ ^[Yy]$ ]]; then
    echo ""
    echo "▸ Fetching changelog..."
    changelog=$(curl -sfL \
        "https://raw.githubusercontent.com/tmux/tmux/refs/tags/${TARGET_VERSION}/CHANGES")

    if [ -n "$changelog" ]; then
        # Extract only the sections between current and target version.
        # The CHANGES file lists sections as "CHANGES FROM x.y TO x.z".
        # We print everything up to the line mentioning the current version.
        echo ""
        echo "══════════════════════════════════════════════════════════════════════"
        echo "  CHANGELOG: tmux $CURRENT_VERSION → $TARGET_VERSION"
        echo "══════════════════════════════════════════════════════════════════════"
        echo ""
        echo "$changelog" \
            | sed -n "1,/CHANGES FROM.*TO ${CURRENT_VERSION//./\\.}\b/{ /CHANGES FROM.*TO ${CURRENT_VERSION//./\\.}\b/!p; }"
        echo "══════════════════════════════════════════════════════════════════════"
    else
        echo "  (Could not fetch changelog)"
    fi
    echo ""
fi

read -r -p "Proceed with update to tmux $TARGET_VERSION? [y/N] " confirm
if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
    echo "Aborted."
    exit 0
fi

# ──────────────────────────────────────────────────────────────────────
# Install build dependencies
# ──────────────────────────────────────────────────────────────────────
echo ""
echo "▸ Installing build dependencies..."
sudo apt-get update -qq || echo "  (apt-get update had warnings/errors — continuing anyway)"
sudo apt-get install -y -qq \
    build-essential \
    libevent-dev \
    libncurses-dev \
    bison \
    pkg-config \
    autoconf \
    automake > /dev/null

# ──────────────────────────────────────────────────────────────────────
# Download and build
# ──────────────────────────────────────────────────────────────────────
echo "▸ Downloading tmux $TARGET_VERSION..."
cd "$BUILD_DIR"
curl -sL "https://github.com/tmux/tmux/releases/download/${TARGET_VERSION}/tmux-${TARGET_VERSION}.tar.gz" \
    -o "tmux-${TARGET_VERSION}.tar.gz"
tar xzf "tmux-${TARGET_VERSION}.tar.gz"
cd "tmux-${TARGET_VERSION}"

echo "▸ Configuring..."
./configure --prefix=/usr/local > /dev/null 2>&1

echo "▸ Building (this may take a minute)..."
make -j"$(nproc)" > /dev/null 2>&1

# ──────────────────────────────────────────────────────────────────────
# Install — kill tmux server so the old binary is not in use
# ──────────────────────────────────────────────────────────────────────
echo "▸ Installing..."
sudo make install > /dev/null 2>&1

# Make sure /usr/local/bin is found before /usr/bin
NEW_TMUX="/usr/local/bin/tmux"
if [ ! -x "$NEW_TMUX" ]; then
    echo "✗ Installation failed — $NEW_TMUX not found."
    exit 1
fi

INSTALLED_VERSION=$("$NEW_TMUX" -V | awk '{print $2}')
echo ""
echo "✓ tmux $INSTALLED_VERSION installed at $NEW_TMUX"
echo

# ──────────────────────────────────────────────────────────────────────
# Restart tmux server to pick up the new binary
# ──────────────────────────────────────────────────────────────────────
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  IMPORTANT: You are inside a tmux session."
echo ""
echo "  To start using tmux $INSTALLED_VERSION, you need to restart"
echo "  the tmux server. This will close ALL tmux sessions."
echo ""
echo "  Run:  tmux kill-server && $NEW_TMUX new-session"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
read -r -p "Kill tmux server and restart now? [y/N] " restart
if [[ "$restart" =~ ^[Yy]$ ]]; then
    echo "Restarting tmux server..."
    exec tmux kill-server \; new-session
else
    echo "Remember to restart tmux later to use the new version."
    echo "  tmux kill-server && $NEW_TMUX new-session"
fi
