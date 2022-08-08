#!/bin/bash

if [[ ! -f ~/.local/bin/mcfly ]]; then
    echo "Installing McFly" && \
    if [[ ! ":$PATH:" == *":/home/s0001483/.local/bin:"* ]]; then
        echo "/home/s0001483/.local/bin does not exist in PATH. Please add it manually" && \
        echo "Exiting..."
        exit 0
    fi
    echo "Fetching McFly file" && \
    curl -LSfs https://raw.githubusercontent.com/cantino/mcfly/master/ci/install.sh | sh -s -- --git cantino/mcfly --to ~/.local/bin
    if ! grep "mcfly init bash" ~/.bashrc
    then
        bashfile='/home/s0001483/.bashrc'
        echo "Adding eval to .bashrc" && \
        echo '#Evaluate McFly' >> $bashfile && \
        echo 'eval "$(mcfly init bash)"' >> $bashfile && \
        source $bashfile && \
        echo "Done! McFly is installed"
    fi
else
    echo "McFly is already installed!"
fi
