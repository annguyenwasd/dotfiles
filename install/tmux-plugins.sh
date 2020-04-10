#!/usr/bin/env bash

if [[ ! -d "$HOME/.tmux" ]]
then
    mkdir $HOME/.tmux
fi


if [[ ! -d "$HOME/.tmux/plugins" ]]
then
    mkdir $HOME/.tmux/plugins
fi

echo "Cloning plugins"
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

