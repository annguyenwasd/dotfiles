#!/usr/bin/env sh
set -e  # stop script if any command fails

# =============================================================================
# install-mac.sh - macOS setup script
# =============================================================================
#
# Usage: ./install-mac.sh
#
# This script sets up a fresh macOS installation with development tools,
# terminal-centric workflow (Neovim, Tmux, Zsh), and personal configurations.
#
# macOS differences from Arch/Manjaro:
#   - Uses Homebrew instead of pacman/yay
#   - No X11/i3/picom (macOS has native window management)
#   - No PipeWire (macOS handles audio natively)
#   - No GPU driver management (macOS handles this)
#   - No GRUB/dual-boot setup
#   - Vietnamese input is built into macOS (Settings > Keyboard > Input Sources)
#   - Zsh is the default shell on macOS
#   - Uses pbcopy/pbpaste instead of xclip
#   - Karabiner-Elements for keyboard remapping
#
# =============================================================================

# --- 1. Install Homebrew ---
if ! command -v brew >/dev/null 2>&1; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Add Homebrew to PATH for Apple Silicon Macs
    if [ -f /opt/homebrew/bin/brew ]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
fi

brew update

# --- 2. Install CLI tools ---
brew install \
  git \
  neovim \
  tmux \
  stow \
  fzf \
  ripgrep \
  curl \
  jq \
  gh \
  openssh \
  unzip

# --- 3. Install GUI applications ---
brew install --cask \
  alacritty \
  google-chrome \
  karabiner-elements \
  flameshot \
  evkey \
  alfred

# --- 4. Install terminal & development tools ---
# File explorer (yazi + preview dependencies)
brew install yazi ffmpegthumbnailer mediainfo

# Fonts (Nerd Font for terminal)
brew install --cask font-sauce-code-pro-nerd-font

# --- 5. Node.js environment ---
brew install node npm
mkdir -p ~/.node_modules
npm config set prefix ~/.node_modules
curl -fsSL https://get.pnpm.io/install.sh | sh -
npm i -g yarn
if ! command -v fnm >/dev/null 2>&1; then
    curl -fsSL https://fnm.vercel.app/install | bash
fi

# --- 6. Alacritty themes ---
mkdir -p ~/.config/alacritty/themes
if [ ! -d ~/.config/alacritty/themes/.git ]; then
    git clone --depth 1 https://github.com/alacritty/alacritty-theme ~/.config/alacritty/themes
fi

# --- 7. Wallpapers ---
mkdir -p ~/workspace
[ ! -d ~/workspace/walls/ ] && git clone --depth 1 https://github.com/annguyenwasd/walls.git ~/workspace/walls

# --- 8. macOS defaults ---
# Show hidden files in Finder
defaults write com.apple.finder AppleShowAllFiles -bool true

# Show path bar in Finder
defaults write com.apple.finder ShowPathbar -bool true

# Disable press-and-hold for keys in favor of key repeat
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# Fast key repeat rate
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15

# --- 9. Setup Vietnamese input ---
echo ""
echo "=== Vietnamese Input ==="
echo "macOS has built-in Vietnamese input support."
echo "Go to: System Settings > Keyboard > Input Sources > Edit"
echo "Add 'Vietnamese' > 'Telex' or 'VNI' input method"

# --- 10. Stow dotfiles ---
echo ""
echo "=== Setup complete! ==="
echo "Next steps:"
echo "  1. cd ~/workspace/dotfiles && stow ."
echo "  2. Restart terminal for all changes to take effect"
echo "  3. Set up Vietnamese input in System Settings"
echo "  4. Configure Karabiner-Elements if needed"
echo ""
echo "NOTE: Zsh is already the default shell on macOS."
