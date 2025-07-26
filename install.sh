#!/usr/bin/env sh

# Install essential packages and Yay AUR helper
sudo pacman -S --noconfirm --needed git base-devel && \
git clone https://aur.archlinux.org/yay.git && \
cd yay && \
makepkg -si

# Install additional packages using Yay
yay -S --noconfirm i3 tmux git neovim stow zsh xorg dmenu alacritty firefox python node \
  npm lazygit fzf ripgrep openssh xclip curl unzip feh os-prober polkit xdg-user-dirs \
  pulseaudio pulsemixer flameshot ttf-sourcecodepro-nerd google-chrome yazi mpv \
  ffmpegthumbnailer mediainfo xorg-xrandr hellwal picom

# Change default shell to zsh
chsh -s $(which zsh)
exec zsh

# mediainfo.yazi
# This is a Yazi plugin for previewing media files. The preview shows thumbnail using ffmpegthumbnailer if available and media metadata using mediainfo.
ya pack -a Ape/mediainfo

# Set up Alacritty themes
mkdir -p ~/.config/alacritty/themes
git clone https://github.com/alacritty/alacritty-theme ~/.config/alacritty/themes

# Install global npm packages and fnm
sudo npm i -g yarn pnpm
curl -fsSL https://fnm.vercel.app/install | bash

# Set up workspace and wallpapers
[ ! -d ~/workspace ] && mkdir ~/workspace
[ ! -d ~/walls ] && mkdir ~/walls
git clone https://github.com/linuxdotexe/nordic-wallpapers.git ~/walls/nordic-wallpapers
git clone https://github.com/annguyenwasd/walls ~/walls/walls

# Set up GRUB with Windows (check partition and setup before running)
sudo mount /dev/sda1 /mnt
sudo os-prober
sudo sed -i "s/#GRUB_DISABLE_OS_PROBER/GRUB_DISABLE_OS_PROBER/" /etc/default/grub
sudo grub-mkconfig -o /boot/grub/grub.cfg

# Create default user directories
xdg-user-dirs-update

# Print TODO items
echo "TODO:"
echo "[AUTOLOGIN] https://wiki.archlinux.org/title/Getty"
echo "[ROOTUSER] https://www.linuxtechi.com/create-configure-sudo-user-on-arch-linux/"
