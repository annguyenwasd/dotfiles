#!/usr/bin/env bash

echo "Hello $(whoami)! Let's get you set up."

sh $DOTFILES/install/install-tools.sh
sh $DOTFILES/install/configure-settings

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

