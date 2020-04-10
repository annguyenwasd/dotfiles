#!/bin/bash
#      -F    If the target file already exists and is a directory, then remove it so that the link may occur.  The -F option should be used with
#            either -f or -i options.  If none is specified, -f is implied.  The -F option is a no-op unless -s option is specified.

#      -h    If the target_file or target_dir is a symbolic link, do not follow it.  This is most useful with the -f option, to replace a symlink
#            which may point to a directory.

#      -f    If the target file already exists, then unlink it so that the link may occur.  (The -f option overrides any previous -i options.)

#      -s    Create a symbolic link.

#      -v    Cause ln to be verbose, showing files as they are processed.
export DOTFILES_DIR=~/workspace/dotfiles
echo "Linking dotfiles"
ln -sfFv "${DOTFILES_DIR}/.zshrc" "${HOME}/.zshrc"
ln -sfFv "${DOTFILES_DIR}/.sandboxrc" "${HOME}/.sandboxrc"
ln -sfFv "${DOTFILES_DIR}/.tmux.conf" "${HOME}/.tmux.conf"
ln -sfFv "${DOTFILES_DIR}/.czrc" "${HOME}/.czrc"
ln -sfFv "${DOTFILES_DIR}/.dir_colors" "${HOME}/.dir_colors"
ln -sfFhv "${DOTFILES_DIR}/alacritty" "${HOME}/.config/alacritty"
ln -sfFhv "${DOTFILES_DIR}/lazygit-config.yml" "${HOME}/Library/Application Support/jesseduffield/lazygit/config.yml"
ln -sfFhv "${DOTFILES_DIR}/lazydocker-config.yml" "${HOME}/Library/Application Support/jesseduffield/lazydocker/config.yml"
ln -sfFhv "${DOTFILES_DIR}/kitty.conf" "${HOME}/.config/kitty/kitty.conf"
ln -sfFv "/usr/local/opt/ripgrep/share/zsh/site-functions/_rg" "$HOME/.oh-my-zsh/completions"

if [ ! -d "${HOME}/.config" ];then
  echo "Folder ~/.config does not exist. Creating..."
  mkdir ${HOME}/.config
fi

ln -sfFhv "${DOTFILES_DIR}/nvim" "${HOME}/.config/nvim"
ln -sfFhv "${DOTFILES_DIR}/tmuxinator" "${HOME}/.config/tmuxinator"
ln -sfFhv "${DOTFILES_DIR}/ultisnips" "${HOME}/.config/ultisnips"
ln -sfFhv "${DOTFILES_DIR}/alias" "${HOME}/.config/alias"
ln -sfFhv "${DOTFILES_DIR}/karabiner" "${HOME}/.config/karabiner"
ln -sfFhv "${DOTFILES_DIR}/package.json" "${HOME}/.config/coc/extensions/package.json"
ln -sfFhv "${DOTFILES_DIR}/.gitconfig" "${HOME}/.gitconfig"
