#!/bin/bash

# Change your shell to Zsh (if you haven't already)
chsh -s $(which zsh)

# Run the Oh My Zsh installation script
# ~/.dotfiles/.oh-my-zsh/tools/install.sh

# Create a symbolic link to your custom directory within the Oh My Zsh directory
ln -s ~/.dotfiles/custom/zsh-aliases.zsh ~/.dotfiles/ohmyzsh/.oh-my-zsh/custom/aliases.zsh
# ln -sn ~/.dotfiles/custom/themes/powerlevel10k ~/.dotfiles/ohmyzsh/.oh-my-zsh/custom/themes/powerlevel10k
