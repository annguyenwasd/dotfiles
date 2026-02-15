#!/usr/bin/env sh
set -e  # stop script if any command fails

# =============================================================================
# install-manjaro.sh - Manjaro Linux setup script
# =============================================================================
#
# Usage: ./install-manjaro.sh
#
# This script sets up a fresh Manjaro i3 installation with development tools,
# terminal-centric workflow (Neovim, Tmux, Zsh), and personal configurations.
#
# Manjaro differences from Arch:
#   - yay is pre-installed on Manjaro
#   - mhwd handles GPU drivers (no manual nvidia/mesa packages needed)
#   - PipeWire + audio stack comes pre-configured
#   - X11, i3, xorg packages are pre-installed on Manjaro i3 edition
#   - lightdm is the default display manager (no manual autologin setup)
#   - Many base-devel tools are pre-installed
#
# =============================================================================

# --- 1. Refresh keyrings and update system ---
# Manjaro occasionally has keyring issues after fresh install or long gaps
# between updates. Refreshing keyrings ensures package signatures are valid.
sudo pacman-key --init
sudo pacman-key --populate archlinux manjaro
sudo pacman-key --refresh-keys
sudo pacman -Syyu --noconfirm

# --- 2. Install essential build tools ---
# Manjaro i3 ships with most base-devel, but ensure git and base-devel are present
sudo pacman -S --noconfirm --needed git base-devel

# --- 3. Install packages ---

# Core development tools
# NOTE: xorg, i3, dmenu, picom, xorg-xrandr are pre-installed on Manjaro i3 edition
# NOTE: pipewire, pipewire-pulse, pipewire-alsa, wireplumber, pavucontrol are pre-installed
sudo pacman -S --noconfirm --needed \
  tmux \
  neovim \
  stow \
  zsh \
  alacritty \
  fzf \
  ripgrep \
  openssh \
  xclip \
  curl \
  unzip \
  jq \
  github-cli

# Image/wallpaper tools
sudo pacman -S --noconfirm --needed feh flameshot

# File explorer (yazi + preview dependencies)
sudo pacman -S --noconfirm --needed yazi ffmpegthumbnailer mediainfo

# System utilities
# NOTE: os-prober, polkit, xdg-user-dirs are pre-installed on Manjaro
sudo pacman -S --noconfirm --needed fuse

# Vietnamese input
sudo pacman -S --noconfirm --needed fcitx5-im fcitx5-unikey fcitx5-configtool

# Fonts
sudo pacman -S --noconfirm --needed ttf-sourcecodepro-nerd

# AUR packages (yay is pre-installed on Manjaro)
yay -S --noconfirm --needed google-chrome hellwal ueberzugpp

# --- 4. GPU drivers via mhwd ---
# Manjaro uses mhwd for hardware detection and driver management.
# This is preferred over manually installing nvidia/mesa/vulkan packages.
echo "Current GPU configuration:"
mhwd -li
echo ""
echo "Available GPU drivers:"
mhwd -l
echo ""
echo "To install a GPU driver, run: sudo mhwd -a pci nonfree 0300"
echo "Or for open-source: sudo mhwd -a pci free 0300"

# --- 5. Change default shell to zsh ---
if [ "$SHELL" != "$(which zsh)" ]; then
    chsh -s "$(which zsh)"
fi

# --- 6. Set Vietnamese input vars ---
grep -q 'GTK_IM_MODULE=fcitx' /etc/environment || echo 'GTK_IM_MODULE=fcitx'  | sudo tee -a /etc/environment
grep -q 'QT_IM_MODULE=fcitx' /etc/environment  || echo 'QT_IM_MODULE=fcitx'   | sudo tee -a /etc/environment
grep -q 'XMODIFIERS=@im=fcitx' /etc/environment || echo 'XMODIFIERS=@im=fcitx' | sudo tee -a /etc/environment

# --- 7. Alacritty themes ---
mkdir -p ~/.config/alacritty/themes
if [ ! -d ~/.config/alacritty/themes/.git ]; then
    git clone --depth 1 https://github.com/alacritty/alacritty-theme ~/.config/alacritty/themes
fi

# --- 8. Global npm/pnpm packages and FNM ---
mkdir -p ~/.node_modules
npm config set prefix ~/.node_modules
sudo pacman -S --noconfirm --needed pnpm
npm i -g yarn
if ! command -v fnm >/dev/null 2>&1; then
    curl -fsSL https://fnm.vercel.app/install | bash
fi

# --- 9. Wallpapers ---
[ ! -d ~/workspace/walls/ ] && git clone --depth 1 https://github.com/annguyenwasd/walls.git ~/workspace/walls

# --- 10. Setup GRUB with Windows (dual-boot) ---
EFI_PART=$(lsblk -rno NAME,FSTYPE,SIZE,MOUNTPOINT | grep -E 'vfat|fat32' | grep -v 'boot' | awk '{print "/dev/"$1}' | head -n 1)
if [ -n "$EFI_PART" ]; then
    echo "Mounting EFI partition: $EFI_PART"
    sudo mount "$EFI_PART" /mnt
    sudo os-prober
    sudo sed -i 's/^#\?GRUB_DISABLE_OS_PROBER=.*/GRUB_DISABLE_OS_PROBER=false/' /etc/default/grub
    sudo grub-mkconfig -o /boot/grub/grub.cfg
else
    echo "No EFI partition detected. Skipping Windows GRUB setup."
fi

# --- 11. Create default user directories ---
xdg-user-dirs-update

# --- 12. Stow dotfiles ---
echo ""
echo "=== Setup complete! ==="
echo "Next steps:"
echo "  1. cd ~/workspace/dotfiles && stow ."
echo "  2. Log out and log back in for fcitx5 and zsh changes to take effect"
echo "  3. Configure GPU driver if needed: sudo mhwd -a pci nonfree 0300"
echo ""

# --- 13. Switch to Zsh ---
exec zsh
