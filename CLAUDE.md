# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a personal dotfiles repository managing development environment configurations using GNU Stow for symlink management. The setup is designed for terminal-centric development with a focus on Neovim, Tmux, and Zsh on both Arch Linux and macOS.

## Architecture

### Stow-Based Organization
Each tool has its own directory that mirrors the home directory structure:
- `nvim/.config/nvim/` → `~/.config/nvim/`
- `tmux/.tmux.conf` → `~/.tmux.conf`
- etc.

Install configurations selectively with `stow <directory>` or all at once with `stow .`

### Key Environment Variables
Required for workflow scripts to function:
- `WORKSPACE_FOLDER`: Root directory containing projects
- `DOTFILES`: Path to this dotfiles repository
- `NVIM_HOME`: Neovim configuration directory

These are set in `zsh/.zshrc`

## Commit Message Conventions

Commits should be categorized based on the tool/directory being modified. Use the directory name as the prefix:

**Format:**
```
<category>: <describe the changes>

- Additional detail 1
- Additional detail 2
```

**Examples:**
```
nvim: add hover and preview keybinds for DAP

- Add dap.hover() mapping
- Add dap.preview() mapping

tmux: update pane splitting keybindings

- Change vertical split to C-a C-v
- Change horizontal split to C-a C-s

git: rename from An Nguyen to An Nguyen Van Chuc

- Update user.name in .gitconfig

mac: add nerd font SauceCodeProNerdFont

- Update Alacritty font configuration
- Install font via install.sh

zsh: add workspace navigation functions

- Add fw, ff, fff functions for project switching
```

**Common categories:**
- `nvim` - Neovim configuration changes
- `tmux` - Tmux configuration changes
- `zsh` - Zsh/shell configuration changes
- `git` - Git configuration changes
- `alacritty` - Alacritty terminal changes
- `yazi` - Yazi file manager changes
- `mac` - macOS-specific changes
- `arch` - Arch Linux / i3 changes
- `karabiner` - Keyboard remapping changes
- `wezterm` - Wezterm terminal changes
- `vscode` - VS Code configuration changes

**Multi-category commit rules:**

1. **Default behavior (split commits):** If staged changes contain files from multiple categories, create separate commits for each category.

   Example: If both `nvim/` and `tmux/` files are staged, create two commits:
   ```
   git add nvim/.config/nvim/lua/plugins/lsp.lua
   git commit -m "nvim: update LSP configuration"

   git add tmux/.tmux.conf
   git commit -m "tmux: add new keybinding for window splitting"
   ```

2. **Exception (commit all):** If the user explicitly uses the words "commit all" or "all" in their instruction, combine all changes into a single commit with multiple categories or a general prefix.

   Example with "commit all":
   ```
   git add .
   git commit -m "config: update multiple tool configurations

   - nvim: update LSP settings
   - tmux: add new keybindings
   - zsh: add utility functions"
   ```

**Single-category guideline:** For changes spanning multiple tools but representing a unified feature/fix, use the primary tool affected or a descriptive prefix like `setup`, `install`, or `config`.

## Branch Syncing Rules

This repository maintains two main branches with platform-specific configurations:

- `master` - Primary branch (Arch Linux focused)
- `mac` - macOS-specific branch

### Using Git Worktree for Syncing

**Important:** Always use git worktree when syncing to a **non-current** branch to prevent configuration flickering. Direct branch switching causes your active configurations (nvim, tmux, zsh, etc.) to change, disrupting your workflow.

**Rules:**
- No worktree needed for the current branch — merge directly
- Always run `git worktree list` first to check if the target branch already has a worktree
- Only create a worktree for branches you are NOT currently on

**Sync workflow:**

1. **Check existing worktrees and differences:**
   ```bash
   git worktree list
   git diff <source>...<target> --name-status
   ```

2. **For current branch (no worktree needed):**
   ```bash
   git merge <source-branch> --no-commit --no-ff

   # Restore excluded files to current branch version
   git checkout HEAD -- alacritty/.alacritty.toml \
     nvim/.config/nvim/lua/plugins/transparent.lua \
     nvim/.config/nvim/lua/themes/__output__.lua \
     zsh/.zshrc

   git commit -m "sync(...): ..."
   git push origin <current-branch>
   ```

3. **For non-current branch (use worktree):**
   ```bash
   git worktree add /tmp/dotfiles-<branch> <branch>
   cd /tmp/dotfiles-<branch>
   git merge <source-branch> --no-commit --no-ff

   # Restore excluded files to target branch version
   git checkout HEAD -- alacritty/.alacritty.toml \
     nvim/.config/nvim/lua/plugins/transparent.lua \
     nvim/.config/nvim/lua/themes/__output__.lua \
     zsh/.zshrc

   git commit -m "sync(...): ..."
   git push origin <branch>
   ```

4. **Clean up worktree after syncing:**
   ```bash
   cd <original-directory>
   git worktree remove /tmp/dotfiles-<branch>
   ```

### Syncing from Patch File

When syncing changes from an external patch file (e.g., from work laptop or another machine):

**Workflow:**

1. **Create worktree for master branch:**
   ```bash
   git worktree add /tmp/dotfiles-master master
   ```

2. **Apply patch to master branch in worktree:**
   ```bash
   cd /tmp/dotfiles-master
   git apply ~/Downloads/sync-YYYY-MM-DD.patch
   # Or if patch has commit info:
   git am ~/Downloads/sync-YYYY-MM-DD.patch
   ```

3. **Verify changes in worktree (don't mess with current env):**
   ```bash
   # Review what was changed
   git status
   git diff

   # Test/verify the changes are correct
   # nvim, tmux, zsh configs should be reviewed
   ```

4. **Commit changes in master branch:**
   ```bash
   git add <files>
   git commit -m "sync(patch): apply changes from <source>

   - Detail 1
   - Detail 2"

   git push origin master
   ```

5. **Sync back to mac branch (and other branches if needed):**
   ```bash
   # Go back to main repo
   cd /Users/annguyenvanchuc/workspace/dotfiles

   # Create worktree for mac branch
   git worktree add /tmp/dotfiles-mac mac

   cd /tmp/dotfiles-mac
   git merge master --no-commit --no-ff

   # Restore excluded files to mac branch version
   git checkout HEAD -- alacritty/.alacritty.toml \
     nvim/.config/nvim/lua/plugins/transparent.lua \
     nvim/.config/nvim/lua/themes/__output__.lua \
     zsh/.zshrc

   git commit -m "sync(master): sync patch changes to mac

   - Synced changes from master
   - Excluded: alacritty, transparent, theme, zshrc"

   git push origin mac
   ```

6. **Clean up all worktrees:**
   ```bash
   cd /Users/annguyenvanchuc/workspace/dotfiles
   git worktree remove /tmp/dotfiles-master
   git worktree remove /tmp/dotfiles-mac
   ```

**Important:**
- Always verify changes in the worktree before committing
- Follow sync exclusion rules when syncing back to other branches
- Ask if there are additional branches to sync to

### Sync Exclusions

When syncing between `master` and `mac` branches, the following files should **NOT** be synced due to platform-specific differences:

**Do not sync (platform-specific):**
- `alacritty/.alacritty.toml` - Different terminal configurations per platform
- `nvim/.config/nvim/lua/plugins/transparent.lua` - Transparency settings differ
- `nvim/.config/nvim/lua/themes/__output__.lua` - Theme preferences differ
- `zsh/.zshrc` - Contains platform-specific paths (PNPM_HOME, opencode, etc.)

### Sync Commit Format

```
sync(<branch-name>): <description>

- Detail about what was synced
- Detail about excluded files
```

**Example:**
```
sync(master): sync recent changes from master to mac

- Synced nvim plugin updates
- Synced tmux configuration changes
- Excluded: alacritty, transparent plugin, theme changes, zsh paths
```

## Common Commands

### Installation & Setup

**Arch Linux full installation:**
```bash
./install.sh
```
This installs all packages (X11, i3, Neovim, Tmux, etc.), sets up Yay, configures GRUB dual-boot, and enables GPU switching.

**Stow configurations:**
```bash
# Install all dotfiles
stow .

# Install specific tool
stow nvim
stow tmux
stow zsh

# Remove/unlink configurations
stow -D nvim
```

### Neovim Development

**Plugin management (uses Lazy.nvim):**
- Plugins auto-install on first launch
- Config entry point: `nvim/.config/nvim/init.lua`
- Plugin configs: `nvim/.config/nvim/lua/plugins/`

**Key configuration files:**
- `lua/settings.lua` - Editor options
- `lua/mappings.lua` - Custom keybindings
- `lua/plugins/lsp.lua` - Language server setup
- `lua/plugins/cmp.lua` - Completion engine
- `lua/themes/` - 15+ color schemes

### Workspace Navigation (Zsh Functions)

These functions are defined in `zsh/.zshrc` and use FZF for fuzzy finding:

```bash
fw    # Navigate to project folder in WORKSPACE_FOLDER
ff    # Navigate + open Neovim
fff   # Navigate + open Neovim + set tmux window name
dot   # Jump to DOTFILES and open in Neovim
```

**Utility functions:**
```bash
kp <port>           # Kill process using specified port
dn                  # Set tmux/zellij window name to current directory
ccc                 # Copy current path to clipboard
clean_all           # Remove all node_modules in workspace
```

## High-Level Architecture

### Neovim Configuration Structure

The Neovim config (~1,334 lines of Lua) is organized as:

```
init.lua                    # Entry point (Lazy.nvim bootstrap)
├── lua/
│   ├── settings.lua        # Editor options
│   ├── mappings.lua        # Global keybindings
│   ├── autocmd.lua         # Autocommands
│   ├── plugins/            # Plugin configurations (modular)
│   │   ├── lsp.lua         # LSP setup via Mason
│   │   ├── cmp.lua         # Completion (nvim-cmp)
│   │   ├── telescope.lua   # Fuzzy finder
│   │   ├── dap.lua         # Debugging
│   │   ├── git.lua         # Git integration
│   │   └── [17 more]
│   ├── themes/             # 15+ color schemes
│   └── utils/              # Helper utilities
└── snippets/               # Language-specific snippets
```

**Key integrations:**
- LSP via Mason (auto-installs language servers)
- Tree-sitter for syntax highlighting
- Telescope for fuzzy finding (files, buffers, symbols, grep)
- nvim-cmp for completion with multiple sources
- DAP for debugging with hover/preview support
- Gitsigns + Fugitive for Git workflow

### Tmux Configuration

**Custom prefix:** `Ctrl-a` (instead of default `Ctrl-b`)

**Important keybindings:**
- `C-a C-v` / `C-a C-s` - Split panes (vertical/horizontal)
- `C-a o` - Close all panes except current
- `C-a O` - Close all windows except current
- `C-a H/J/K/L` - Resize panes
- Vim-tmux-navigator integration for seamless pane navigation

**Custom scripts in `tmux/`:**
- `fzf_t_w.sh` - FZF-based window switching
- `zen.sh` / `uzen.sh` - Zen mode layouts

**Plugins (TPM):**
- tmux-resurrect + tmux-continuum - Session persistence
- vim-tmux-navigator - Smart Vim/Tmux pane navigation

### Zsh Configuration

**Shell features:**
- Vi-mode keybindings (via zsh-vi-mode plugin)
- Large history (10M lines with deduplication)
- FZF integration for reverse search and navigation
- Async prompt rendering

**Key plugins:**
- zsh-vi-mode
- zsh-z (directory jumping with frecency)
- zsh-command-time (execution timing)

### Git Configuration

**User:** An Nguyen Van Chuc (an.nguyenwasd@gmail.com)

**Important aliases in `git/.gitconfig`:**
```
co   = checkout
ca   = commit --amend
cae  = commit --amend --no-edit
ri   = rebase -i
pp   = push
pf   = push --force-with-lease
l    = log --graph --pretty=format:[custom]
dl   = diff -- . ':(exclude)package-lock.json' ':(exclude)*.lock'
```

**Merge tool:** Neovim with `Gdiffsplit!`

## Tool-Specific Notes

### Yazi File Manager
- Config: `yazi/.config/yazi/`
- Image preview via ueberzugpp
- Platform-specific openers for editing/opening files

### Alacritty Terminal
- Font: SauceCodePro Nerd Font
- 80% opacity with blur enabled
- Themes cloned from official Alacritty themes repo

### Karabiner (macOS)
- Complex keyboard modifications
- Config: `karabiner/.config/karabiner/karabiner.json`

### Arch Linux / i3
- Window manager config in `arch/`
- X11 initialization, status bar, xmodmap included

## Development Workflow

1. **Navigate to project:** Use `fw`, `ff`, or `fff` in terminal
2. **Edit code:** Neovim with full LSP, completion, debugging support
3. **Version control:** Git with custom aliases and Neovim merge tool
4. **Terminal multiplexing:** Tmux with session persistence and custom layouts
5. **File management:** Yazi for visual browsing, Telescope for fuzzy finding

## Repository Philosophy

**Goals:**
- Minimalism
- Speed
- Fun
- Personal customization

**Non-goals:**
- Becoming an IDE replacement
- Being a pre-configured distribution like LunarVim or AstroNvim
