#!/usr/bin/env bash

echo "=============================================="
echo "installing homebrew"
echo "=============================================="
sudo chown -R $(whoami) /usr/local/var/homebrew
# install homebrew https://brew.sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo "brew installing stuff"
# hub: a github-specific version of git
# tree: really handy for listing out directories in text
brew bundle install

echo "installing pynvim for neovim"
pip3 install --user pynvim

# Close any open System Preferences panes, to prevent them from overriding
# settings we’re about to change
osascript -e 'tell application "System Preferences" to quit'

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

echo "installing a few global npm packages"
npm install --global 
\ serve semantic-release-cli yarn neovim alacritty-theme-switch

echo "Change zsh to default shell"
chsh -s /bin/zsh

echo "Installing ohmyzsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# install terminal info -> for tmux italic fonts
tic termcolors/screen-256color.terminfo
