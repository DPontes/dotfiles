#!/usr/bin/env bash

# File: tools/setup.sh
# Description: Dotfiles setup and environment configuration script.
# Dependencies: git, curl, tar, sudo (for apt)

set -euo pipefail

# Ensure we're in the dotfiles directory
DOTFILES_DIR="$HOME/dotfiles"

# TMUX configuration
if [[ ! -f "$HOME/.tmux.conf" ]]; then
    echo "Linking .tmux.conf"
    ln -sf "$DOTFILES_DIR/.tmux.conf" "$HOME/.tmux.conf"
fi

# Add .bash_aliases
if [[ ! -f "$HOME/.bash_aliases" ]]; then
    echo "Linking .bash_aliases"
    ln -sf "$DOTFILES_DIR/.bash_aliases" "$HOME/.bash_aliases"
fi

# git alias configuration
echo "Configuring git aliases"
git config --global alias.st status
git config --global alias.pl pull
git config --global alias.d diff
git config --global alias.aA "add ."
git config --global alias.l log
git config --global alias.b branch
git config --global core.editor "nvim"

# Install fzf (Fuzzy Finder)
if [[ ! -d "$HOME/.fzf" ]]; then
    echo "Installing fzf..."
    git clone --depth 1 https://github.com/junegunn/fzf.git "$HOME/.fzf"
    "$HOME/.fzf/install" --all --no-update-rc
fi

# Install bat (a nicer cat)
if ! command -v bat &> /dev/null && ! command -v batcat &> /dev/null; then
    echo "Installing bat..."
    sudo apt update && sudo apt install -y bat
    mkdir -p "$HOME/.local/bin"
    ln -sf /usr/bin/batcat "$HOME/.local/bin/bat"
fi

# Install ripgrep (rg) for Telescope live_grep
if ! command -v rg &> /dev/null; then
    echo "Installing ripgrep..."
    sudo apt update && sudo apt install -y ripgrep
fi

# Install lazygit
if ! command -v lazygit &> /dev/null; then
    echo "Installing lazygit..."
    LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": *"v\K[^"]*')
    ARCH=$(uname -m)
    case "$ARCH" in
        x86_64)  LG_ARCH="x86_64" ;;
        aarch64) LG_ARCH="arm64" ;;
        armv7l)  LG_ARCH="armv6" ;;
        *) echo "Unsupported arch: $ARCH"; exit 1 ;;
    esac
    TEMP_DIR=$(mktemp -d)
    curl -sL "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_${LG_ARCH}.tar.gz" | tar xz -C "$TEMP_DIR" lazygit
    mkdir -p "$HOME/.local/bin"
    mv "$TEMP_DIR/lazygit" "$HOME/.local/bin/lazygit"
    chmod +x "$HOME/.local/bin/lazygit"
    rm -rf "$TEMP_DIR"
fi

# Neovim and lazygit config
echo "Configuring Neovim and Lazygit..."
mkdir -p "$HOME/.config/nvim"
mkdir -p "$HOME/.config/lazygit"
ln -sfT "$DOTFILES_DIR/nvim" "$HOME/.config/nvim"
ln -sf "$DOTFILES_DIR/lazygit/config.yml" "$HOME/.config/lazygit/config.yml"

# Disable Ubuntu dock extension in GNOME
if command -v gnome-extensions &> /dev/null; then
    echo "Disabling Ubuntu dock extension..."
    gnome-extensions disable ubuntu-dock@ubuntu.com || true
fi

# Fish shell configuration
if [[ ! -L "$HOME/.config/fish" ]]; then
    echo "Linking fish config..."
    rm -rf "$HOME/.config/fish"
    ln -sf "$DOTFILES_DIR/fish" "$HOME/.config/fish"
fi

# Kitty terminal configuration
if [[ ! -L "$HOME/.config/kitty" ]]; then
    echo "Linking kitty config..."
    rm -rf "$HOME/.config/kitty"
    ln -sf "$DOTFILES_DIR/kitty" "$HOME/.config/kitty"
fi

# Append extra-bash to .bashrc if not already present
if ! grep -q "source $DOTFILES_DIR/extra-bash" "$HOME/.bashrc"; then
    echo "Adding extra-bash to .bashrc"
    echo "source $DOTFILES_DIR/extra-bash" >> "$HOME/.bashrc"
fi

echo "Setup complete. Please restart your shell."
