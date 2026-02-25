#!/bin/bash
set -euo pipefail

# macOS bootstrap for dotfiles — mirrors tools/setup.sh for Linux.
# Run from anywhere; assumes the repo lives at ~/dotfiles.

DOTFILES="$HOME/dotfiles"

if [[ "$(uname -s)" != "Darwin" ]]; then
    echo "This script is intended for macOS. Use tools/setup.sh on Linux."
    exit 1
fi

if [[ ! -d "$DOTFILES" ]]; then
    echo "Error: $DOTFILES not found. Clone the repo first:"
    echo "  git clone <repo-url> ~/dotfiles"
    exit 1
fi

# ── Homebrew ─────────────────────────────────────────────────────────
if ! command -v brew &>/dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    # Add brew to PATH for the rest of this script
    if [[ -f /opt/homebrew/bin/brew ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    else
        eval "$(/usr/local/bin/brew shellenv)"
    fi
fi

echo "Installing packages via Homebrew..."
brew install --quiet \
    fish \
    tmux \
    neovim \
    fzf \
    bat \
    ripgrep \
    lazygit \
    kitty \
    node        # needed by some Neovim plugins (Copilot, etc.)

# ── Fish shell ───────────────────────────────────────────────────────
FISH_PATH="$(which fish)"
# Add fish to allowed shells if not already there
if ! grep -qF "$FISH_PATH" /etc/shells; then
    echo "Adding $FISH_PATH to /etc/shells (requires sudo)..."
    echo "$FISH_PATH" | sudo tee -a /etc/shells >/dev/null
fi

# Set fish as default shell if it isn't already
if [[ "$SHELL" != "$FISH_PATH" ]]; then
    echo "Setting fish as default shell..."
    chsh -s "$FISH_PATH"
fi

# ── Symlinks ─────────────────────────────────────────────────────────
link() {
    local src="$1" dst="$2"
    mkdir -p "$(dirname "$dst")"
    if [[ -L "$dst" ]]; then
        rm "$dst"
    elif [[ -e "$dst" ]]; then
        echo "  Backing up existing $dst → ${dst}.bak"
        mv "$dst" "${dst}.bak"
    fi
    ln -sf "$src" "$dst"
    echo "  Linked $dst → $src"
}

echo "Linking configuration files..."
link "$DOTFILES/.tmux.conf"          "$HOME/.tmux.conf"
link "$DOTFILES/.bash_aliases"       "$HOME/.bash_aliases"
link "$DOTFILES/fish/config.fish"    "$HOME/.config/fish/config.fish"
link "$DOTFILES/fish/fish_aliases.fish" "$HOME/.config/fish/fish_aliases.fish"
# functions/ is a directory symlink
rm -rf "$HOME/.config/fish/functions" 2>/dev/null || true
link "$DOTFILES/fish/functions"      "$HOME/.config/fish/functions"
link "$DOTFILES/kitty/kitty.conf"    "$HOME/.config/kitty/kitty.conf"

# Neovim and lazygit configs are copied (not symlinked) to allow local edits
echo "Copying Neovim config..."
mkdir -p "$HOME/.config/nvim"
cp -r "$DOTFILES/nvim/" "$HOME/.config/nvim/"

echo "Copying lazygit config..."
mkdir -p "$HOME/.config/lazygit"
cp "$DOTFILES/lazygit/config.yml" "$HOME/.config/lazygit/config.yml"

# ── Kitty: fix shell path for macOS ─────────────────────────────────
KITTY_CONF="$HOME/.config/kitty/kitty.conf"
if grep -q '/usr/bin/fish' "$KITTY_CONF" 2>/dev/null; then
    echo "Patching kitty.conf shell path for macOS..."
    sed -i '' "s|/usr/bin/fish|$FISH_PATH|g" "$KITTY_CONF"
fi

# ── tmux: fix shell path for macOS ──────────────────────────────────
TMUX_CONF="$HOME/.tmux.conf"
if grep -q '/usr/bin/fish' "$TMUX_CONF" 2>/dev/null; then
    echo "Patching .tmux.conf shell path for macOS..."
    sed -i '' "s|/usr/bin/fish|$FISH_PATH|g" "$TMUX_CONF"
fi

# ── Git aliases ──────────────────────────────────────────────────────
echo "Setting git aliases..."
git config --global alias.st status
git config --global alias.pl pull
git config --global alias.d  diff
git config --global alias.aA "add ."
git config --global alias.l  log
git config --global alias.b  branch
git config --global core.editor "nvim"

# ── fzf shell integration ───────────────────────────────────────────
echo "Setting up fzf shell integration..."
# Homebrew fzf includes an install script for key bindings
if [[ -f "$(brew --prefix)/opt/fzf/install" ]]; then
    "$(brew --prefix)/opt/fzf/install" --key-bindings --completion --no-update-rc --no-bash --no-zsh
fi

# ── TPM (tmux plugin manager) ───────────────────────────────────────
if [[ ! -d "$HOME/.tmux/plugins/tpm" ]]; then
    echo "Installing tmux plugin manager (TPM)..."
    git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
fi

# ── Caps Lock → Escape (reminder) ───────────────────────────────────
echo ""
echo "════════════════════════════════════════════════════════"
echo "  Setup complete!"
echo "════════════════════════════════════════════════════════"
echo ""
echo "Next steps:"
echo "  1. Open kitty and tmux — press prefix (Ctrl+S) then I to"
echo "     install tmux plugins via TPM."
echo "  2. Open nvim — lazy.nvim will auto-install plugins on first launch."
echo "  3. To remap Caps Lock → Escape on macOS, go to:"
echo "     System Settings → Keyboard → Keyboard Shortcuts → Modifier Keys"
echo "     and set Caps Lock to Escape."
echo ""
