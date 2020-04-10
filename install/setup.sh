#!/usr/bin/env bash

echo "Hello $(whoami)! Let's get you set up."
export DOTFILES_DIR=$HOME/workspace/dotfiles

sh $DOTFILES_DIR/install/install-tools.sh
sh $DOTFILES_DIR/install/tmux-plugins.sh
sh $DOTFILES_DIR/install/link-files.sh
sh $DOTFILES_DIR/install/configure-settings

