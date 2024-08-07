# Personal Development Environment


### Prerequisites
- Set `WORKSPACE_FOLDER` to your folder containing your projects
- Set `DOTFILES` to your dotifles folder


### Tmux (same with Zellij) + FZF

By setting `WORKSPACE_FOLDER` in the `.zshrc` file, navigates between project become eaziser when combines
with `fzf`

Mappings:
- `fw` show list of folder under `WORKSPACE_FOLDER`. Press `Enter` will `cd` into that folder
- `ff` show list of folder under `WORKSPACE_FOLDER`. Press `Enter` will `cd` into that folder, and open `nvim`
- `fff` show list of folder under `WORKSPACE_FOLDER`. Press `Enter` will `cd` into that folder, open `nvim`, and change the `tmux` window's name by the current directory's name

- `dot` will cd to `DOTFILES` folder, open `nvim` and set tmux window to folder's name

- `c-a` + `o` will close all panes in current window
- `c-a` + `O` (capital `O`) will close all window in current session and re-index current window to `1`


### Neovim

[Keybindings](./keys.md)

## Installation

### Stow

Make sure you installed [stow](https://formulae.brew.sh/formula/stow)

```sh
brew install stow
```

After that, just clone my repo to your home directory

```sh
cd ~ && git clone git@github.aus.thenational.com:P820087/dotfiles.git && cd ~/dotfiles && rm -rf .non-stow && stow . && git stash -u
```

if you just want to use neovim, just

```sh
stow neovim
```

## Goal

- Minimalism
- Speed
- Fun
- Fully personal customization

## Non-Goal
- Become an IDE
- Alternative pre-configured repos: Lunar.nvim, Astro.nvim, etc.

