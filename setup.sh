#!/bin/bash

# TMUX configuration
if [[ ! -f ~/.tmux.conf ]]
then
    echo "Creating tmux.conf file link" && \
    ln -s ~/dotfiles/.tmux.conf ~/.tmux.conf && \
    chmod +x ~/.tmux.conf
fi

# Vim configuration
if [[ ! -f ~/.vimrc ]]
then
    echo "Creating .vimrc file link" && \
    ln -s ~/dotfiles/.vimrc ~/.vimrc
fi

# VSCode configuration
echo "Copying VS Code settings file to correct location"
cp ~/dotfiles/vscode_settings.json ~/.config/Code/User/settings.json

# git alias configuration
git config --global alias.st status
git config --global alias.pl pull
git config --global alias.d diff
git config --global alias.aA "add ."
git config --global.alias.l log

# Add all the extra bash commands to ~/.bashrc
cat extra-bash >> ~/.bashrc

#install McFly
./install_mcfly.sh
