#!/bin/bash

ln -s ~/dotfiles/.bin/.Brewfile ~/.Brewfile
source ./.bin/brew.sh
ln -s ~/dotfiles/.zshrc ~/.zshrc
source ~/.zshrc
ln -s ~/dotfiles/.git ~/.git

