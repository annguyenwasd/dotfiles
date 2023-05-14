#!/usr/bin/sh
yes|sudo pacman -S i3 zsh xorg dmenu alacritty firefox python node npm lazygit fzf ripgrep openssh xclip

zsh
chsh
sz

yes|aur nerd-fonts-meta
yes|aur google chrome

# python dependency for neovim
python -m ensurepip --upgradepython -m ensurepip --upgrade
pip3 install neovim

sudo npm i -g diff-so-fancy
