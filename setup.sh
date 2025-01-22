#!/bin/bash

# TMUX configuration
if [[ ! -f ~/.tmux.conf ]]
then
    echo "Creating tmux.conf file link" && \
    ln -s ~/dotfiles/.tmux.conf ~/.tmux.conf && \
    chmod +x ~/.tmux.conf
fi

# Add .bash_aliases
if [[ ! -f ~/.bash_aliases ]]
then
	echo "Adding bash_aliases" && \
	ln -s ~/dotfiles/.bash_aliases ~/.bash_aliases && \
	source ~/.bash_aliases
fi

# git alias configuration
echo "Adding additional git config"

git config --global alias.st status
git config --global alias.pl pull
git config --global alias.d diff
git config --global alias.aA "add ."
git config --global alias.l log
git config --global alias.b branch
git config --global core.editor	"nvim"

# Install fzf (Fuzzy Finder)
if [[ ! -d ~/.fzf/ ]]
then
	echo "Installing fzf..." && \
	git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && \
	~/.fzf/install && \
	# Set up fzf key bindings and fuzzy completion
	eval "$(fzf --bash)"
fi

# Install bat (a nicer cat)
if [[ ! -f /usr/bin/batcat ]]
then
  echo "Installing bat..." && \
  sudo apt install bat && \
  # the following commands are necessary because "bat" is installed as "batcat" due to name clashing
  mkdir -p ~/.local/bin && \
  ln -s /usr/bin/batcat ~/.local/bin/bat
fi

# Install ripgrep (rg) for Telescope live_grep
if [[ ! -f /usr/bin/rg ]]
then
  echo "Installing ripgrep for Telescope..." && \
  sudo apt-get install ripgrep
fi

# Install lazygit
if [[ ! -f /usr/local/bin/lazygit ]]
then
  echo "Installing Lazygit..." && \
  LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | \grep -Po '"tag_name": *"v\K[^"]*') && \
  curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz" && \
  tar xf lazygit.tar.gz lazygit && \
  rm lazygit.tar.gz
fi

# Move neovim config to ~/.config
echo "Copying Neovim config files..."
cp -r ~/dotfiles/nvim ~/.config/nvim

# What it says...
echo "Disabling gnome dock..."
gnome-extensions disable ubuntu-dock@ubuntu.com

# Append content of extra-bash to end of .bashrc
cat ~/dotfiles/extra-bash >> ~/.bashrc && source ~/.bashrc
