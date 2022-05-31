
![my init.lua](.non-stow/docs/images/neovim.png)
_my init.lua file_

## Installation

Make sure you installed [stow](https://formulae.brew.sh/formula/stow)

```sh
brew install stow
```

After that, just clone my repo to your home directory

```sh
cd ~ && git clone git@github.com:annguyenwasd/dotfiles.git && cd ~/dotfiles && rm -rf .non-stow && stow . && git stash -u
```

if you just want to use neovim, just
```sh
stow neovim
```

## What includes

- tmux config
- neovim confix
- karabiner config
- lazygit & lazydocker config
- zsh config
- etc.
