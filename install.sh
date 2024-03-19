#!/bin/bash

# Change your shell to Zsh (if you haven't already)
chsh -s $(which zsh)

# Run the Oh My Zsh installation script
~/.dotfiles/.oh-my-zsh/tools/install.sh

# Create a symbolic link to your custom directory within the Oh My Zsh directory
ln -s ~/.dotfiles/custom ~/.dotfiles/.oh-my-zsh/custom
