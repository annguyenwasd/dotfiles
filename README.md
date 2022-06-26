
![my init.lua](.non-stow/docs/images/neovim.png)
_my init.lua file_

- font used: [SauceCodePro Nerd Font](https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/SourceCodePro/Regular/complete/Sauce%20Code%20Pro%20Nerd%20Font%20Complete.ttf)
- theme: `zenwritten` in [zenbones.nvim](https://github.com/zenbones.nvim)

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

## Details
### neovim config
### Plugins
#### Treesitter
- [nvim-treesitter](https://github.com/nvim-treesitter)
- [nvim-treesitter-textobjects](https://github.com/nvim-treesitter-textobjects)
- [nvim-ts-context-commentstring](https://github.com/nvim-ts-context-commentstring)

#### Telescope
- [telescope-fzf-native.nvim](https://github.com/telescope-fzf-native.nvim)
- [telescope-symbols.nvim](https://github.com/telescope-symbols.nvim)
- [telescope-ultisnips.nvim](https://github.com/telescope-ultisnips.nvim)
- [telescope.nvim](https://github.com/telescope.nvim)

#### Status line
- [lualine-lsp-progress](https://github.com/lualine-lsp-progress)
- [lualine.nvim](https://github.com/lualine.nvim)

#### LSP
- [lsp_signature.nvim](https://github.com/lsp_signature.nvim)
- [lspkind-nvim](https://github.com/lspkind-nvim)
- [nvim-lsp-installer](https://github.com/nvim-lsp-installer)
- [nvim-lsp-ts-utils](https://github.com/nvim-lsp-ts-utils)
- [nvim-lspconfig](https://github.com/nvim-lspconfig)
- [schemastore.nvim](https://github.com/schemastore.nvim)
- [ultisnips](https://github.com/ultisnips)

#### Completion
- [nvim-cmp](https://github.com/nvim-cmp)
- [cmp-buffer](https://github.com/cmp-buffer)
- [cmp-cmdline](https://github.com/cmp-cmdline)
- [cmp-nvim-lsp](https://github.com/cmp-nvim-lsp)
- [cmp-nvim-ultisnips](https://github.com/cmp-nvim-ultisnips)
- [cmp-path](https://github.com/cmp-path)

#### Explorer
- [nvim-tree.lua](https://github.com/nvim-tree.lua)

#### Tmux integration
- [vim-tmux-navigator](https://github.com/vim-tmux-navigator)

#### Git
- [gitsigns.nvim](https://github.com/gitsigns.nvim)
- [lazygit.nvim](https://github.com/lazygit.nvim)
- [vim-fugitive](https://github.com/vim-fugitive)

#### Theme
- [darcula](https://github.com/darcula)
- [lush.nvim](https://github.com/lush.nvim)
- [material.nvim](https://github.com/material.nvim)
- [vscode.nvim](https://github.com/vscode.nvim)
- [zenbones.nvim](https://github.com/zenbones.nvim)

#### Formatter
- [neoformat](https://github.com/neoformat)

#### Comment
- [Comment.nvim](https://github.com/Comment.nvim)

#### MISC
 - [BufOnly.nvim](https://github.com/BufOnly.nvim)
 - [asyncrun.vim](https://github.com/asyncrun.vim)
 - [golden_size](https://github.com/golden_size)
 - [harpoon](https://github.com/harpoon)
 - [markdown-preview.nvim](https://github.com/markdown-preview.nvim)
 - [plenary.nvim](https://github.com/plenary.nvim)
 - [popup.nvim](https://github.com/popup.nvim)
 - [tabular](https://github.com/tabular)
 - [mkdir.nvim](https://github.com/mkdir.nvim)
 - [nvim-bqf](https://github.com/nvim-bqf)
 - [nvim-colorizer.lua](https://github.com/nvim-colorizer.lua)
 - [nvim-web-devicons](https://github.com/nvim-web-devicons)
 - [vCoolor.vim](https://github.com/vCoolor.vim)
 - [vim-abolish](https://github.com/vim-abolish)
 - [vim-be-good](https://github.com/vim-be-good)
 - [vim-cool](https://github.com/vim-cool)
 - [vim-devicons](https://github.com/vim-devicons)
 - [vim-maximizer](https://github.com/vim-maximizer)
 - [vim-repeat](https://github.com/vim-repeat)
 - [vim-rooter](https://github.com/vim-rooter)
 - [vim-snippets](https://github.com/vim-snippets)
 - [vim-surround](https://github.com/vim-surround)
 - [vim-unimpaired](https://github.com/vim-unimpaired)

#### Debugger
- [nvim-dap](https://github.com/nvim-dap)
- [telescope-dap.nvim](https://github.com/telescope-dap.nvim)
- [undotree](https://github.com/undotree)



### tmux config
- prefix key map to `C-a` (`control + a`)
- press `v` to start selection in `copy` mode, press `y` to copy text
- support mouse's scroll wheel
- customize theme to show minial info
  - left: `[section name] [window number]:[window name] [Z: if has zoomed] [-: if last window used]
  - right: [time] [date]
![Tmux status line](.non-stow/docs/images/tmux.png)

### karabiner config
- homepage: https://karabiner-elements.pqrs.org/

### lazygit & lazydocker config
- lazygit homepage: https://github.com/jesseduffield/lazygit/
- lazy docker homepage: https://github.com/jesseduffield/lazydocker

### zsh config
#### aliases
#### custom functions
### etc.
