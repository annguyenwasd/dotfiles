# AGENTS.md - Dotfiles Development Guide

## Overview

This is a personal dotfiles repository managing development environment configurations using GNU Stow for symlink management. The setup is designed for terminal-centric development with a focus on Neovim, Tmux, and Zsh on both Arch Linux and macOS.

## Repository Structure

```
dotfiles/
├── nvim/.config/nvim/     # Neovim configuration (~1334 lines of Lua)
├── tmux/.tmux.conf       # Tmux configuration
├── zsh/.zshrc            # Zsh configuration
├── git/.gitconfig        # Git configuration
├── alacritty/.alacritty.toml
├── yazi/.config/yazi/
├── karabiner/.config/karabiner/  # macOS only
└── arch/                 # Arch Linux/i3 configuration
```

## Build/Lint/Test Commands

### Neovim
- **Open Neovim**: `nvim`
- **Lazy (plugin manager)**: `:Lazy` (inside Neovim)
- **Check health**: `:checkhealth` (inside Neovim)
- **Lint/format check**: No formal linter configured for Lua configs
- **Single test**: N/A (no test framework)

### Shell Scripts
- **Install scripts**: `./install-arch.sh`, `./install-manjaro.sh`, `./install-mac.sh`
- **Shellcheck** (if available): `shellcheck script.sh`

### Git
- **Commit changes**: Use git commands directly (see Git Configuration below)
- **No CI/CD**: This is a personal dotfiles repo

## Code Style Guidelines

### General Principles
- Minimalism, speed, and personal customization
- Not aiming to be a distribution like LunarVim or AstroNvim

### Lua (Neovim)
- **Indentation**: 2 spaces
- **No comments**: Unless absolutely necessary for clarity
- **Formatting**: Use default Neovim Lua formatter (none enforced)
- **Imports**: Use `require("module")` for dependencies
- **Naming**: snake_case for variables and functions, PascalCase for modules/tables
- **Error handling**: Prefer defensive checks, minimal try/catch patterns
- **Types**: No TypeScript-style types; use clear variable names and comments when needed
- **Example**:
  ```lua
  local M = {}

  local setup_diagnostics = function(bufnr)
    local signs = require("utils.signs")
    vim.diagnostic.config({ signs = { text = { ... } } })
  end

  return M
  ```

### Shell (Zsh)
- **Shebang**: `#!/usr/bin/env zsh` for scripts
- **Indentation**: 2 spaces
- **Variables**: `$VAR` or `${VAR}`, use `local` for local scope
- **Functions**: `function_name() { ... }` or `function function_name; ...`

### Tmux
- **Configuration**: Flat config file, no scripting
- **Prefix**: Custom `Ctrl-a` (not default `Ctrl-b`)

### Git Configuration
- **User**: An Nguyen Van Chuc (an.nguyenwasd@gmail.com)

### Commit Message Format

**Format:**
```
<type>(<scope>): <description>

- Additional detail 1
- Additional detail 2
```

**Commit Types:**
- **Tool categories**: nvim, tmux, zsh, git, alacritty, yazi, mac, arch, karabiner, wezterm, vscode
- **Action types**: feat, fix, refactor, perf, docs, chore, sync, config, misc

**Examples:**
```
nvim: add lenient LSP root detection

- Add more root markers (.git, tsconfig.json, jsconfig.json, package.json)
- Add filetypes and autostart to ts_ls config
- Add BufReadPost autocmd to manually start ts_ls when no root markers found

tmux: update pane splitting keybindings

- Change vertical split to C-a C-v
- Change horizontal split to C-a C-s

docs: add AGENTS.md for agentic coding guidelines

- Add build/lint/test commands section
- Add code style guidelines for Lua, Shell, Tmux
```

### Multi-Category Commit Rules

1. **Default (split commits):** If staged changes contain files from multiple categories, create separate commits for each category.

   Example - if both `nvim/` and `tmux/` files are staged:
   ```
   git add nvim/.config/nvim/lua/plugins/lsp.lua
   git commit -m "nvim: update LSP configuration"

   git add tmux/.tmux.conf
   git commit -m "tmux: add new keybinding for window splitting"
   ```

2. **Exception (commit all):** If the user explicitly uses the words "commit all" or "all" in their instruction, combine all changes into a single commit with multiple categories.

   Example with "commit all":
   ```
   git add .
   git commit -m "config: update multiple tool configurations

   - nvim: update LSP settings
   - tmux: add new keybindings
   - zsh: add utility functions"
   ```

### Branch Strategy
- `master` - Primary branch (Arch Linux focused)
- `mac` - macOS-specific branch
- Use git worktree for syncing between branches (see CLAUDE.md)

## Common Development Tasks

### Stow Configurations
```bash
stow .              # Install all dotfiles
stow nvim           # Install specific tool
stow -D nvim        # Remove/unlink
```

### Neovim Development
- **Plugin configs**: `nvim/.config/nvim/lua/plugins/`
- **Entry point**: `nvim/.config/nvim/init.lua`
- **Key configs**:
  - `lua/settings.lua` - Editor options
  - `lua/mappings.lua` - Custom keybindings
  - `lua/plugins/lsp.lua` - LSP setup
  - `lua/plugins/cmp.lua` - Completion

### Workspace Navigation (Zsh)
- `fw` - Navigate to project folder in WORKSPACE_FOLDER
- `ff` - Navigate + open Neovim
- `fff` - Navigate + open Neovim + set tmux window name
- `dot` - Jump to DOTFILES and open in Neovim
- `kp <port>` - Kill process on port
- `dn` - Set tmux window name to current directory
- `ccc` - Copy current path to clipboard

### Syncing Between Branches
Always use git worktree for non-current branches:
```bash
git worktree add /tmp/dotfiles-<branch> <branch>
cd /tmp/dotfiles-<branch>
git merge <source-branch>
# Resolve conflicts, restore excluded files
git commit -m "sync(...): ..."
git push origin <branch>
git worktree remove /tmp/dotfiles-<branch>
```

### Excluded Files (platform-specific)
Do NOT sync between master and mac branches:
- `alacritty/.alacritty.toml`
- `nvim/.config/nvim/lua/plugins/transparent.lua`
- `nvim/.config/nvim/lua/themes/__output__.lua`

## Important Paths
- `WORKSPACE_FOLDER`: Root directory containing projects
- `DOTFILES`: Path to this dotfiles repository
- `NVIM_HOME`: Neovim configuration directory

These are set in `zsh/.zshrc`

## Testing Changes

Since this is a configuration repository:
1. Make changes to config files
2. Run `stow nvim` (or relevant tool) to sync
3. Restart the application to test
4. For Neovim: `:LspRestart` or restart completely
