#!/bin/bash

# TMUX configuration
if [[ ! -f ~/.tmux.conf ]]
then
    echo "Creating tmux.conf file link" && \
    ln -s ~/dotfiles/.tmux.conf ~/.tmux.conf && \
    chmod +x ~/.tmux.conf
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

# Add .bash_aliases
if [[ ! -f ~/.bash_aliases ]]
then
	echo "Adding bash_aliases" && \
	ln -s ~/dotfiles/.bash_aliases ~/.bash_aliases && \
	source ~/.bash_aliases
fi

# Instsall fzf (Fuzzy Finder)
if [[ ! -d ~/.fzf/ ]]
then
	echo "Installing fzf..." && \
	git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && \
	~/.fzf/install && \
	# Set up fzf key bindings and fuzzy completion
	eval "$(fzf --bash)"
fi

# Move neovim config to ~/.config
echo "Copying Neovim config files..."
cp -r ~/dotfiles/nvim ~/.config/nvim

# What it says...
echo "Disabling gnome dock..."
gnome-extensions disable ubuntu-dock@ubuntu.com

# Append content of extra-bash to end of .bashrc
cat ~/dotfiles/extra-bash >> ~/.bashrc && source ~/.bashrc
