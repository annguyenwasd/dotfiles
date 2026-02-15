# Personal Development Environment

### Prerequisites
- Set `WORKSPACE_FOLDER` to your folder containing your projects
- Set `DOTFILES` to your dotfiles folder

### Keybindings

[All keybinds for tmux/neovim/vim](./keybinds.md)

### Tmux (same with Zellij) + FZF

By setting `WORKSPACE_FOLDER` in the `.zshrc` file, navigates between project become easier when combines
with `fzf`

Mappings:
- `fw` show list of folder under `WORKSPACE_FOLDER`. Press `Enter` will `cd` into that folder
- `ff` show list of folder under `WORKSPACE_FOLDER`. Press `Enter` will `cd` into that folder, and open `nvim`
- `fff` show list of folder under `WORKSPACE_FOLDER`. Press `Enter` will `cd` into that folder, open `nvim`, and change the `tmux` window's name by the current directory's name

- `dot` will cd to `DOTFILES` folder, open `nvim` and set tmux window to folder's name

- `c-a` + `o` will close all panes in current window
- `c-a` + `O` (capital `O`) will close all window in current session and re-index current window to `1`

## Installation

### Platform-specific install scripts

| Script | Platform | Description |
|---|---|---|
| `install-arch.sh` | Arch Linux | Full setup from minimal Arch install (X11, i3, yay, GPU drivers, audio, etc.) |
| `install-manjaro.sh` | Manjaro Linux | Lighter setup - skips pre-installed packages, uses mhwd for GPU drivers |
| `install-mac.sh` | macOS | Homebrew-based setup, ports Linux tools to macOS equivalents |

```sh
# Arch Linux
./install-arch.sh

# Manjaro
./install-manjaro.sh

# macOS
./install-mac.sh
```

### Stow

Make sure you installed [stow](https://formulae.brew.sh/formula/stow)

```sh
# macOS
brew install stow

# Arch/Manjaro
sudo pacman -S stow
```

After that, just clone the repo and stow:

```sh
cd ~/workspace && git clone git@github.com:annguyenwasd/dotfiles.git && cd dotfiles && stow alacritty arch claude feh git hellwal karabiner misc nvim tmux vim vscode wezterm yazi zellij --target=$HOME
zsh
```

If you just want to use neovim:

```sh
stow nvim
```

## Goal

- Minimalism
- Speed
- Fun
- Fully personal customization

## Non-Goal
- Become an IDE
- Alternative pre-configured repos: Lunar.nvim, Astro.nvim, etc.
