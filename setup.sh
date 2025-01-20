#!/bin/bash

# TMUX configuration
if [[ ! -f ~/.tmux.conf ]]
then
    echo "Creating tmux.conf file link" && \
    ln -s ~/dotfiles/.tmux.conf ~/.tmux.conf && \
    chmod +x ~/.tmux.conf
fi

# git alias configuration
git config --global alias.st status
git config --global alias.pl pull
git config --global alias.d diff
git config --global alias.aA "add ."
git config --global alias.l log
git config --global alias.b branch

# Add .bash_aliases
if [[! -f ~/.bash_aliases ]]
then
	echo "Adding bash_aliases" && \
	ln -s ~/dotfiles/.bash_aliases ~/.bash_aliases && \
	chmod +r ~/.bash_aliases
fi
