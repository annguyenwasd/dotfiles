#!/usr/bin/sh
su
yes|sudo pacman -S i3 tmux git neovim vim stow zsh xorg dmenu alacritty firefox python node npm lazygit fzf ripgrep openssh xclip curl unzip feh pipewire pipewire-alsa wireplumber pipewire-pulse alsa-utils java-runtime-common java-environment-common jre-openjdk jdk-openjdk openjdk-doc openjdk-src os-prober polkit sudo vi

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

# setup grub with windows
sudo mount /dev/sda1 /mnt
sudo os-prober
sudo sed -i "s/#GRUB_DISABLE_OS_PROBER/GRUB_DISABLE_OS_PROBER/" /etc/default/grub
sudo grub-mkconfig -o /boot/grub/grub.cfg

systemctl --user --now enable pipewire pipewire-pulse wireplumber



echo "TODO:"
echo "[AUTOLOGIN] https://wiki.archlinux.org/title/Getty"
echo "[ROOTUSER] https://www.linuxtechi.com/create-configure-sudo-user-on-arch-linux/
