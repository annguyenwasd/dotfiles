#!/usr/bin/env sh
set -e  # stop script if any command fails

# --- 1. Install essential packages and Yay ---
sudo pacman -S --noconfirm --needed git base-devel

if ! command -v yay >/dev/null 2>&1; then
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm
    cd ..
    rm -rf yay
fi

# --- 2. Install packages ---
sudo pacman -S --noconfirm \
  xorg xorg-xinit xorg-server xterm i3 \
  tmux git neovim stow zsh dmenu alacritty \
  firefox lazygit fzf ripgrep openssh xclip curl \
  unzip feh os-prober polkit xdg-user-dirs \
  pulseaudio pulsemixer flameshot ttf-sourcecodepro-nerd \
  yazi mpv ffmpegthumbnailer mediainfo xorg-xrandr picom fuse \
  nvidia nvidia-utils nvidia-settings mesa vulkan-intel

yay -S --noconfirm google-chrome hellwal node npm optimus-manager optimus-manager-qt ueberzugpp

# --- 3. Change default shell to zsh ---
if [ "$SHELL" != "$(which zsh)" ]; then
    chsh -s "$(which zsh)"
fi

# --- 5. Alacritty themes ---
mkdir -p ~/.config/alacritty/themes
if [ ! -d ~/.config/alacritty/themes/.git ]; then
    git clone --depth 1 https://github.com/alacritty/alacritty-theme ~/.config/alacritty/themes
fi

# --- 6. Global npm packages and FNM ---
sudo npm i -g yarn pnpm
if ! command -v fnm >/dev/null 2>&1; then
    curl -fsSL https://fnm.vercel.app/install | bash
fi

# --- 7. Wallpapers ---
[ ! -d ~/workspace/walls/ ] && git clone --depth 1 https://github.com/annguyenwasd/walls.git ~/workspace/walls

# --- 8. Setup GRUB with Windows ---
EFI_PART=$(lsblk -rno NAME,FSTYPE,SIZE,MOUNTPOINT | grep -E 'vfat|fat32' |grep -v 'boot'| awk '{print "/dev/"$1}' | head -n 1)
if [ -n "$EFI_PART" ]; then
    echo "Mounting EFI partition: $EFI_PART"
    sudo mount "$EFI_PART" /mnt
    sudo os-prober
    sudo sed -i 's/^#\?GRUB_DISABLE_OS_PROBER=.*/GRUB_DISABLE_OS_PROBER=false/' /etc/default/grub
    sudo grub-mkconfig -o /boot/grub/grub.cfg
else
    echo "⚠ No EFI partition detected. Skipping Windows GRUB setup."
fi

# --- 9. Create default user directories ---
xdg-user-dirs-update

# --- 10. Switch to Zsh at the end ---
exec zsh

# --- 11. Using GPU ---
sudo systemctl enable optimus-manager --now
