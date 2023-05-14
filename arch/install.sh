#!/usr/bin/sh
yes|sudo pacman -S i3 tmux git neovim vim stow zsh xorg dmenu alacritty firefox python node npm lazygit fzf ripgrep openssh xclip curl unzip feh pipewire pipewire-alsa wireplumber pipewire-pulse alsa-utils

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


systemctl --user --now enable pipewire pipewire-pulse wireplumber
