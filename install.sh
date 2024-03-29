#!/bin/bash

mkdir -p ~/.config
mkdir -p ~/.gnupg

ln -s ~/dotfiles/.curlrc ~/.curlrc
ln -s ~/dotfiles/.psqlrc ~/.psqlrc
ln -s ~/dotfiles/.vim ~/.config/nvim
ln -s ~/dotfiles/.vim ~/.vim
ln -s ~/dotfiles/.vimrc ~/.vimrc
ln -s ~/dotfiles/.zshrc ~/.zshrc
ln -s ~/dotfiles/gitconfig ~/.gitconfig
ln -s ~/dotfiles/tmux.conf ~/.tmux.conf
ln -s ~/dotfiles/gitignore_global ~/.gitignore_global
ln -s ~/dotfiles/gpg-agent.conf ~/.gnupg/gpg-agent.conf
