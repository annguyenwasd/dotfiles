#!/usr/bin/sh
yes|sudo pacman -S i3 zsh xorg dmenu alacritty firefox python node npm lazygit fzf ripgrep openssh xclip curl unzip feh

zsh
chsh
sz

yes|aur nerd-fonts-meta
yes|aur google chrome

# python dependency for neovim
python -m ensurepip --upgradepython -m ensurepip --upgrade
pip3 install neovim

sudo npm i -g diff-so-fancy
curl -fsSL https://fnm.vercel.app/install | bash

[ ! -d ~/workspace ] && mkdir ~/workspace
git clone https://github.com/linuxdotexe/nordic-wallpapers.git ~/workspace/nordic-wallpapers

# setup auto login
yes|sudo pacman -S util-linux
stty onlcr
echo "Please follow this link https://wiki.archlinux.org/title/Getty"
