#!/usr/bin/sh
# TODO: re-test. 1 install yay, then install deps by using yay
su
sudo pacman -S --noconfirm i3 tmux git neovim vim stow zsh xorg dmenu alacritty firefox python node npm lazygit fzf ripgrep openssh xclip curl unzip feh java-runtime-common java-environment-common jre-openjdk jdk-openjdk openjdk-doc openjdk-src os-prober polkit sudo vi xdg-user-dirs pulseaudio pulsemixer flameshot
sudo pacman -S --noconfirm --needed git base-devel && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si


# TODO is it a correct way to change shel?
zsh
chsh
sz
# We use Alacritty's default Linux config directory as our storage location here.
mkdir -p ~/.config/alacritty/themes
git clone https://github.com/alacritty/alacritty-theme ~/.config/alacritty/themes

yay -S --noconfirm extra/ttf-sourcecodepro-nerd
yay -S --noconfirm google chrome


# python dependency for neovim
python -m ensurepip --upgradepython -m ensurepip --upgrade
pip3 install neovim

sudo npm i -g yarn
curl -fsSL https://fnm.vercel.app/install | bash

[ ! -d ~/workspace ] && mkdir ~/workspace
# TODO install walls as well, move both to ~/wallpapers
git clone https://github.com/linuxdotexe/nordic-wallpapers.git ~/workspace/nordic-wallpapers

# setup auto login
sudo pacman -S --noconfirm util-linux
stty onlcr

# setup grub with windows
sudo mount /dev/sda1 /mnt
sudo os-prober
sudo sed -i "s/#GRUB_DISABLE_OS_PROBER/GRUB_DISABLE_OS_PROBER/" /etc/default/grub
sudo grub-mkconfig -o /boot/grub/grub.cfg

# Create default folders
xdg-user-dirs-update

# install android studio
yay -S --noconfirm aur/android-studio

echo "TODO:"
echo "[AUTOLOGIN] https://wiki.archlinux.org/title/Getty"
echo "[ROOTUSER] https://www.linuxtechi.com/create-configure-sudo-user-on-arch-linux/
