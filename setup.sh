#!/bin/bash

# TMUX configuration
ln -s ~/dotfiles/.tmux.conf ~/.tmux.conf
chmod +x ~/.tmux.conf
tmux source-file ~/.tmux.conf

# Vim configuration
ln -s ~/dotfiles/.vimrc ~/.vimrc
