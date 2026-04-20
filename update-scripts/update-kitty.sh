#!/bin/bash
set -euo pipefail

REPO="kovidgoyal/kitty"
INSTALL_DIR="$HOME/.local/kitty.app"
CHANGELOG_URL="https://sw.kovidgoyal.net/kitty/changelog/"

# Detect architecture
ARCH=$(uname -m)
case "$ARCH" in
    x86_64)  ASSET_ARCH="x86_64" ;;
    aarch64) ASSET_ARCH="arm64" ;;
    *) echo "Unsupported architecture: $ARCH"; exit 1 ;;
esac

echo "=== kitty ==="
RELEASE_JSON=$(curl -sf "https://api.github.com/repos/$REPO/releases/latest") || {
    echo "Error: failed to fetch release info from GitHub."; exit 1
}

LATEST_TAG=$(echo "$RELEASE_JSON" | python3 -c "import sys,json; print(json.load(sys.stdin)['tag_name'])")
LATEST_VERSION="${LATEST_TAG#v}"

CURRENT_VERSION=""
if command -v kitty &>/dev/null; then
    CURRENT_VERSION=$(kitty --version 2>/dev/null | awk '{print $2}')
fi

echo "Installed: ${CURRENT_VERSION:-none}"
echo "Latest:    $LATEST_VERSION"
echo

if [ "$CURRENT_VERSION" = "$LATEST_VERSION" ]; then
    echo "✓ kitty is already the latest stable version."
    echo
    exit 0
fi

# Fetch and display changelog for versions between current and latest
echo "════════════════════════════════════════════════════════"
echo "  Changelog: ${CURRENT_VERSION:-none} → $LATEST_VERSION"
echo "════════════════════════════════════════════════════════"
echo

# Scrape changelog entries newer than the installed version
python3 - "$CURRENT_VERSION" "$CHANGELOG_URL" << 'PYEOF'
import sys, re, urllib.request, html as htmlmod

current = sys.argv[1]
url = sys.argv[2]

try:
    with urllib.request.urlopen(url, timeout=15) as resp:
        page = resp.read().decode()
except Exception as e:
    print(f"  (Could not fetch changelog: {e})")
    print(f"  See: {url}")
    sys.exit(0)

# Parse version sections: <h3>...<a id="id..."> pattern or ### headers
# The page uses <h3> tags with version numbers like "0.45.0 [2025-12-24]"
version_re = re.compile(
    r'<h3[^>]*>\s*([\d]+\.[\d]+\.[\d]+)\s*\[([^\]]+)\].*?</h3>(.*?)(?=<h3|<h2|$)',
    re.DOTALL
)

def strip_html(text):
    text = re.sub(r'<a[^>]*>#</a>', '', text)
    text = re.sub(r'<a[^>]*>(.*?)</a>', r'\1', text)
    text = re.sub(r'<code[^>]*>(.*?)</code>', r'`\1`', text)
    text = re.sub(r'<li[^>]*>\s*', '  • ', text)
    text = re.sub(r'</li>', '', text)
    text = re.sub(r'<[^>]+>', '', text)
    text = htmlmod.unescape(text)
    lines = [l.rstrip() for l in text.strip().splitlines() if l.strip()]
    return '\n'.join(lines)

def ver_tuple(v):
    return tuple(int(x) for x in v.split('.'))

found = False
for m in version_re.finditer(page):
    ver, date, body = m.group(1), m.group(2), m.group(3)
    try:
        if current and ver_tuple(ver) <= ver_tuple(current):
            break
    except Exception:
        pass
    found = True
    print(f"── {ver} [{date}] ──")
    print(strip_html(body))
    print()

if not found:
    print(f"  (No changelog entries found; see {url})")
PYEOF

echo "════════════════════════════════════════════════════════"
echo

read -rp "Update kitty to $LATEST_VERSION? [y/N] " answer
if [[ ! "$answer" =~ ^[Yy]$ ]]; then
    echo "Aborted."
    exit 0
fi

ASSET_NAME="kitty-${LATEST_VERSION}-${ASSET_ARCH}.txz"
DOWNLOAD_URL="https://github.com/$REPO/releases/download/$LATEST_TAG/$ASSET_NAME"
TMPDIR=$(mktemp -d)
trap 'rm -rf "$TMPDIR"' EXIT

echo
echo "Downloading $ASSET_NAME..."
curl -fL -o "$TMPDIR/$ASSET_NAME" "$DOWNLOAD_URL" || {
    echo "Error: download failed."; exit 1
}

echo "Installing to $INSTALL_DIR..."
rm -rf "$INSTALL_DIR"
mkdir -p "$INSTALL_DIR"
tar -xJf "$TMPDIR/$ASSET_NAME" -C "$INSTALL_DIR"

# Create symlinks if not already on PATH
LINK_DIR="$HOME/.local/bin"
mkdir -p "$LINK_DIR"
ln -sf "$INSTALL_DIR/bin/kitty" "$LINK_DIR/kitty"
ln -sf "$INSTALL_DIR/bin/kitten" "$LINK_DIR/kitten"

# Install .desktop file and icon
cp -f "$INSTALL_DIR/share/applications/kitty.desktop" "$HOME/.local/share/applications/" 2>/dev/null || true
cp -f "$INSTALL_DIR/share/applications/kitty-open.desktop" "$HOME/.local/share/applications/" 2>/dev/null || true
if [ -d "$INSTALL_DIR/share/icons" ]; then
    cp -rf "$INSTALL_DIR/share/icons/"* "$HOME/.local/share/icons/" 2>/dev/null || true
fi
sed -i "s|Icon=kitty|Icon=$INSTALL_DIR/share/icons/hicolor/256x256/apps/kitty.png|g" \
    "$HOME/.local/share/applications/kitty.desktop" 2>/dev/null || true
sed -i "s|Exec=kitty|Exec=$INSTALL_DIR/bin/kitty|g" \
    "$HOME/.local/share/applications/kitty.desktop" 2>/dev/null || true

echo
echo "✓ kitty updated to $LATEST_VERSION"
kitty --version
