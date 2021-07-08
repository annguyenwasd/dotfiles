" TODO 
" [] convert snipet to vim-vsnip
" [] debugger
" [] format on save 
  " [] format styled component
" [] OpenFileInFolder
" [] lsp get code actions from eslint

"{{{ Plugins
call plug#begin('~/.vim/plugged')
" LSP
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} 
Plug 'neovim/nvim-lspconfig'
Plug 'kabouzeid/nvim-lspinstall'
Plug 'hrsh7th/nvim-compe'
Plug 'glepnir/lspsaga.nvim'
Plug 'hrsh7th/vim-vsnip'
Plug 'nvim-lua/lsp-status.nvim'
Plug 'folke/lsp-colors.nvim'
Plug 'folke/trouble.nvim'
Plug 'folke/todo-comments.nvim'
Plug 'onsails/lspkind-nvim'
Plug 'mfussenegger/nvim-jdtls'

" Debugger
Plug 'mfussenegger/nvim-dap'

" Telescope
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'xiyaowong/telescope-emoji.nvim'

" Snippet
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'
Plug 'rafamadriz/friendly-snippets'

Plug 'kyazdani42/nvim-tree.lua'
Plug 'ryanoasis/vim-devicons'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-commentary'
Plug 'JoosepAlviste/nvim-ts-context-commentstring'
Plug 'mbbill/undotree'
Plug 'szw/vim-maximizer'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'KabbAmine/vCoolor.vim'
Plug 'kevinhwang91/nvim-bqf'
Plug 'skywind3000/asyncrun.vim'
Plug 'vim-scripts/BufOnly.vim'


Plug 'n0v1c3/vira', { 'do': './install.sh' }


" Tmux integration
Plug 'christoomey/vim-tmux-navigator'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'slarwise/vim-tmux-send'

"Git
Plug 'tpope/vim-fugitive'
Plug 'kdheepak/lazygit.nvim'
Plug 'lewis6991/gitsigns.nvim'

" Theme
Plug 'tjdevries/colorbuddy.vim'
Plug 'rktjmp/lush.nvim'

Plug 'charliesbot/night-owl.vim'
Plug 'lifepillar/vim-gruvbox8'
Plug 'mhartington/oceanic-next'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'bluz71/vim-nightfly-guicolors'
Plug 'yonlu/omni.vim'
Plug 'doums/darcula'
Plug 'chiendo97/intellij.vim'
Plug 'Th3Whit3Wolf/space-nvim'
Plug 'Th3Whit3Wolf/one-nvim'
Plug 'Th3Whit3Wolf/onebuddy'
Plug 'folke/tokyonight.nvim'
Plug 'sainnhe/sonokai'
Plug 'marko-cerovac/material.nvim'
Plug 'GlennLeo/cobalt2'
Plug 'google/vim-colorscheme-primary'
Plug 'ChristianChiarulli/nvcode-color-schemes.vim'
Plug 'shaunsingh/moonlight.nvim'
Plug 'arzg/vim-colors-xcode'
Plug 'lourenci/github-colors'
Plug 'MordechaiHadad/nvim-papadark'
Plug 'projekt0n/github-nvim-theme'
call plug#end()
"}}}

"{{{ Settings
syntax enable
filetype plugin indent on
             
set wildmenu termguicolors nowrap hidden noswapfile ignorecase incsearch expandtab nohlsearch number relativenumber noerrorbells cursorline
set exrc secure " load user config
set signcolumn=yes
set clipboard=unnamed
set updatetime=50
set inccommand=nosplit
set mouse=a
set scrolloff=8
set shortmess+=c
set completeopt=menuone,noinsert,noselect
set smartindent
set shiftwidth=2
set softtabstop=2
set tabstop=2
set undofile
set udir=$HOME/.vim/undo
set cmdheight=2
set listchars=eol:¬,tab:▹\ ,trail:+,space:·
set nolist

augroup SetFileType
  autocmd!
  autocmd FileType vim set foldmethod=marker
  autocmd BufNewFile,BufRead *.zsh setlocal filetype=zsh
  autocmd FileType zsh set foldmethod=marker
  autocmd BufNewFile,BufRead *.conf setlocal filetype=conf
  autocmd FileType conf set foldmethod=marker
augroup END

augroup CursorLineOnlyInActiveWindow
  autocmd!
  autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  autocmd WinLeave * setlocal nocursorline
augroup END

let g:vimsyn_embed = 'lPr' " Highlight lua syntax inside vim
let g:python3_host_prog = '/usr/local/bin/python3'
"}}}

"{{{ Mappings
let mapleader=" "
let maplocalleader="\\"

nnoremap Y y$
" Duplicate everything selected
vmap D y'>p
" Do search with selected text in VISUAL mode
vmap * y<cmd>let @/ = @"<cr><cmd>set hlsearch<cr>
" Highlight then back to original position
nnoremap n nzz

nnoremap <silent> <leader>cl <cmd>ccl<cr><cmd>lcl<cr><cmd>TroubleClose<cr>
nnoremap <leader><leader>r <cmd>so ~/.config/nvim/init.vim<cr>

nnoremap <silent> <c-w><c-e> <c-w>=

" Moving around in command mode
cnoremap <c-h> <left>
cnoremap <c-j> <down>
cnoremap <c-k> <up>
cnoremap <c-l> <right>

inoremap <c-h> <left>
inoremap <c-j> <down>
inoremap <c-k> <up>
inoremap <c-l> <right>

nnoremap <leader>ff :call OpenFileInFolder()<cr>
nnoremap <leader>e <cmd>b #<cr>
nnoremap <leader><leader>e <cmd>e<cr>
nnoremap <silent> <leader><leader>b <cmd>bufdo bwipeout<cr><cmd>intro<cr>

" Create file at same folder with vsplit/split
nnoremap <localleader>vf :vsp %:h/
nnoremap <localleader>sf :sp %:h/
nnoremap <localleader>ff :e %:h/

nnoremap <leader><leader>h yi" :!npm home <c-r>"<cr>
nnoremap <leader><leader>H yi' :!npm home <c-r>"<cr>
nnoremap <leader><leader>oj 0/[DT-<cr>yi[<cmd>nohl<cr> :!open -a google\ chrome https://dolenglish.atlassian.net/browse/<c-r>"<cr>
nnoremap <leader><leader>oe <cmd>!open -a textedit %<cr>
nnoremap <leader><leader>ov <cmd>!open -a vimr %<cr>
nnoremap <leader><leader>oc <cmd>!open -a visual\ studio\ code %<cr>
nnoremap <leader><leader>og <cmd>!open -a google\ chrome %<cr>

cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

command CFN :call CopyFileName()
command CFA :call CopyFileFullPath()
command CF :call CopyFileRelativePath()
command CFP :call CopyFileRelativePathFolder()
command GG :call GoogleJavaFormat()

function CopyFileName()
 let @* = expand("%:t")
 let @r = expand("%:t")
endfunction

function CopyFileFullPath()
 let @* = expand("%:p")
 let @r = expand("%:p")
endfunction

function CopyFileRelativePath()
 let @* = expand("%")
 let @r = expand("%")
endfunction

function CopyFileRelativePathFolder()
 let @* = expand("%:h")
 let @r = expand("%:h")
endfunction

function GoogleJavaFormat() 
  !google-java-format --replace %
endfunction

" Windows
nmap <c-w>v     <c-w>v <c-w>l
nmap <c-w><c-v> <c-w>v <c-w>l
nmap <c-w>s     <c-w>s <c-w>j
nmap <c-w><c-s> <c-w>s <c-w>j
nmap <c-w><c-w> <c-w>q

nnoremap <leader>sc yiw}O<cr>const <c-r>" = styled.div``;<esc><c-o>
nnoremap <leader>rr "rciw
"}}}

"{{{ Theme configuration

let g:oceanic_next_terminal_bold = 1
let g:oceanic_next_terminal_italic = 1

let g:material_flat_ui=1
" darker lighter default oceanic palenight deep ocean
let g:material_style = 'oceanic'
let g:material_italic_comments=1
let g:material_italic_keywords=1
let g:material_italic_functions=1
" let g:gh_color = "soft"


let g:calvera_italic_comments = 1
let g:calvera_italic_keywords = 1
let g:calvera_italic_functions = 1
let g:calvera_contrast = 1
 

if (has("termguicolors"))
    set termguicolors
    " hi LineNr ctermbg=NONE guibg=NONE
endif

let g:moonlight_italic_comments = 1
let g:moonlight_italic_keywords = 1
let g:moonlight_italic_functions = 1
let g:moonlight_italic_variables = 0
let g:moonlight_contrast = 1
let g:moonlight_borders = 1 
let g:moonlight_disable_background = 0

augroup StatusLine
  autocmd!

  au ColorScheme nord hi Folded guifg=#54627A guibg=#2E3440 gui=NONE
  au ColorScheme nord hi StatusLine guifg=#D8DEE9

  au ColorScheme OceanicNext hi StatusLine guibg=#E5E8E8
  au ColorScheme OceanicNext hi CursorLineNr guibg=NONE guifg=#ffffff

augroup END

augroup ThemeGroup
  autocmd!
  " au ColorScheme * hi Visual guibg=Yellow guifg=Black
  au ColorScheme * hi SignifySignAdd guibg=NONE
  au ColorScheme * hi SignifySignChange guibg=NONE
  au ColorScheme * hi SignifySignChangeDelete guibg=NONE
  au ColorScheme * hi SignifySignDelete guibg=NONE
  au ColorScheme * hi SignifySignDeleteFirstLine guibg=NONE
  au ColorScheme * hi EndOfBuffer guibg=NONE
  au ColorScheme * hi LineNr guibg=NONE
  au ColorScheme * hi SignColumn guibg=NONE
  au ColorScheme * hi Normal guibg=NONE " transparent

augroup END

colorscheme nvcode

if get(g:, 'colors_name') == 'material' && get(g:, 'material_style') == 'oceanic'
  hi NormalFloat guibg=#1e577d
endif

if get(g:, 'colors_name') == 'gruvbox_hard' && &background == 'dark'
  hi StatusLine guifg=#A7AE08 guibg=#282a36
endif


"}}}

"{{{ Telescope configuration
lua << EOF
local actions = require('telescope.actions')

require("telescope").load_extension("emoji")
require('telescope').setup{
  defaults = {
    prompt_prefix = "🔍 ",
    selection_caret = "➡️ ",
    path_display = {},
    mappings = {
      i = {
        ["<C-w>"] = actions.send_selected_to_qflist,
        ["<C-q>"] = actions.send_to_qflist,
      },
      n = {
        ["<C-w>"] = actions.send_selected_to_qflist,
        ["<C-q>"] = actions.send_to_qflist,
      },
    },
  },
  pickers = {
    find_files = { theme = "ivy", previewer = false },
    git_files = { theme = "ivy", previewer = false },
    buffers = { theme = "ivy", previewer = false },
  }
}
EOF
nnoremap <leader>o <cmd>Telescope git_files<cr>
nnoremap <leader>p <cmd>Telescope find_files find_command=rg,--ignore,--hidden,--files prompt_prefix=🔍<cr>
nnoremap <leader>rg <cmd>Telescope live_grep<cr>
nnoremap <leader>gr <cmd>Telescope grep_string<cr>
nnoremap <leader>i <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader><leader>fh <cmd>Telescope man_pages<cr>
nnoremap <leader>fc <cmd>Telescope commands<cr>
nnoremap <leader>km <cmd>Telescope keymaps<cr>
nnoremap <localleader>fc <cmd>Telescope colorscheme<cr>
nnoremap <leader>/ <cmd>Telescope current_buffer_fuzzy_find<cr>
nnoremap <leader>fe <cmd>Telescope emoji search<cr>

" command FF :call OpenFileInFolder()

" function OpenFileInFolder()
"   let current_folder = expand("%:h")
"   call fzf#vim#files(current_folder, {'source' : 'ls'})
" endfunction

"}}}

"{{{ LSP configuration

lua << EOF
local lsp_status = require('lsp-status')
local signs = { Error = " ", Warning = " ", Hint = " ", Information = " " }
lsp_status.config({
  current_function = false,
  status_symbol = ' ',
  indicator_hint = signs.Hint,
  indicator_errors = signs.Error,
  indicator_warnings = signs.Warning,
  indicator_ok = ' '
});
lsp_status.register_progress()

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Register client for messages and set up buffer autocommands to update 
  -- the statusline and the current function.
  lsp_status.on_attach(client)

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', 'gy', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap("n", "<leader>fm", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

end

-- Configure lua language server for neovim development
local lua_settings = {
  Lua = {
    runtime = {
      -- LuaJIT in the case of Neovim
      version = "LuaJIT",
      path = vim.split(package.path, ";"),
    },
    diagnostics = {
      -- Get the language server to recognize the `vim` global
      globals = { "vim" },
    },
    workspace = {
      -- Make the server aware of Neovim runtime files
      library = {
        [vim.fn.expand("$VIMRUNTIME/lua")] = true,
        [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
      },
    },
  },
}

-- config that activates keymaps and enables snippet support
local function make_config()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {
      'documentation',
      'detail',
      'additionalTextEdits',
    }
  }
  capabilities.textDocument.colorProvider = { dynamicRegistration = false }
  return {
    -- enable snippet support
    capabilities = capabilities,
    -- map buffer local keybindings when the language server attaches
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 500,
    },
    handlers = {
     ["textDocument/publishDiagnostics"] = vim.lsp.with(
       vim.lsp.diagnostic.on_publish_diagnostics, {
         -- Disable virtual_text
         virtual_text = false
       }
     ),
    }
  }
end

  local prettier = {
    formatCommand = "prettier --stdin-filepath ${INPUT}",
    formatStdin = true,
  }
  
  local java = {
    formatCommand = "google-java-format ${INPUT}",
    formatStdin = true,
  }

  local eslint = {
    lintCommand = "eslint -f visualstudio --stdin --stdin-filename ${INPUT}",
    lintIgnoreExitCode = true,
    lintStdin = true,
    lintFormats = { "%f(%l,%c): %tarning %m", "%f(%l,%c): %rror %m" },
    lintSource = "eslint"
  }

  local shellcheck =  {
      lintCommand = "shellcheck -f gcc -x -",
      lintStdin = true,
      lintFormats = {"%f=%l:%c: %trror: %m", "%f=%l:%c: %tarning: %m", "%f=%l:%c: %tote: %m"},
      lintSource = "shellcheck"
  }

--[[  
  local luafmt = {
    formatCommand = "luafmt ${-i:tabWidth} --stdin",
    formatStdin = true
  }
]]

  local vint = {
      lintCommand = "vint -",
      lintStdin = true,
      lintFormats = {"%f:%l:%c: %m"},
      lintSource = "vint"
  }

-- lsp-install
local function setup_servers()
  require"lspinstall".setup()

  -- get all installed servers
  local servers = require"lspinstall".installed_servers()
  --local servers = {'typescript'}
  for _, server in pairs(servers) do
    local config = make_config()
    config.capabilities = vim.tbl_extend('keep', config.capabilities or {}, lsp_status.capabilities)

    -- language specific config
    if server == "lua" then
      config.settings = lua_settings
      config.root_dir = function(fname)
        if fname:match("lush_theme") ~= nil then return nil end
          local util = require "lspconfig/util"
          return util.find_git_ancestor(fname) or util.path.dirname(fname)
        end
    end

    if server == "vim" then config.init_options = { isNeovim = true } end

    if server == "efm" then
      config.filetypes = { "html", "css", "yaml", "javascript", "javascriptreact", "typescript", "typescriptreact", "java", "json" }
      config.settings = {
        cmd = { "/usr/local/bin/efm-langserver" },
        rootMarkers = { ".git/", "package.json", "pom.xml" },
        init_options = { 
          documentFormatting = true,
          hover = true,
          documentSymbol = true,
          codeAction = true,
          completion = true
        },
        languages = {
          html = { prettier },
          css = { prettier },
          json = { prettier },
          yaml = { prettier },
          java = {java},
          javascript = { eslint },
          javascriptreact = { eslint },
          typescript = {  eslint },
          typescriptreact = {  eslint },
          vim = {vint},
          --lua = {luafmt},
          scss = {prettier},
          markdown = {prettier},
          sh = {shellcheck},
        },
      }
    end

    require"lspconfig"[server].setup(config)
  end
end

setup_servers()


-- Automatically reload after `:LspInstall <server>` so we don't have to restart neovim
require'lspinstall'.post_install_hook = function ()
  setup_servers() -- reload installed servers
  vim.cmd("bufdo e") -- this triggers the FileType autocmd that starts the server
end

require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  resolve_timeout = 800;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = {
    border = { '', '' ,'', ' ', '', '', '', ' ' }, -- the border option is the same as `|help nvim_open_win|`
    winhighlight = "NormalFloat:CompeDocumentation,FloatBorder:CompeDocumentationBorder",
    max_width = 120,
    min_width = 60,
    max_height = math.floor(vim.o.lines * 0.3),
    min_height = 1,
  };

  source = {
    path = true;
    buffer = true;
    calc = true;
    nvim_lsp = true;
    nvim_lua = true;
    vsnip = true;
  };
}

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  elseif vim.fn['vsnip#available'](1) == 1 then
    return t "<Plug>(vsnip-expand-or-jump)"
  elseif check_back_space() then
    return t "<Tab>"
  else
    return vim.fn['compe#complete']()
  end
end

_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  elseif vim.fn['vsnip#jumpable'](-1) == 1 then
    return t "<Plug>(vsnip-jump-prev)"
  else
    -- If <S-Tab> is not working in your terminal, change it to <C-h>
    return t "<S-Tab>"
  end
end

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
EOF

inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <CR>      compe#confirm('<CR>')
inoremap <silent><expr> <C-e>     compe#close('<C-e>')
inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })

nnoremap <silent><leader>ac :Lspsaga code_action<CR>
vnoremap <silent><leader>ac :<C-U>Lspsaga range_code_action<CR>
nnoremap <silent> K :call <SID>show_documentation()<cr>
nnoremap <silent> <C-f> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>
nnoremap <silent> <C-b> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>
nnoremap <silent><leader>sh :Lspsaga signature_help<CR>
nnoremap <silent><leader>rn :Lspsaga rename<CR>
nnoremap <silent><leader>gd :Lspsaga preview_definition<CR>
nnoremap <silent> [g :Lspsaga diagnostic_jump_prev<CR>
nnoremap <silent> ]g :Lspsaga diagnostic_jump_next<CR>

nnoremap <silent> <leader>dl :Lspsaga show_line_diagnostics<CR>
nnoremap <silent><leader>dc <cmd>lua require'lspsaga.diagnostic'.show_cursor_diagnostics()<CR>

nnoremap <silent> <leader>co :Telescope lsp_document_symbols<CR>
nnoremap <silent> <leader>ws :Telescope lsp_dynamic_workspace_symbols<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (luaeval("vim.lsp.buf.server_ready()"))
  :Lspsaga hover_doc
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

function! LspStatus() abort
  if luaeval('#vim.lsp.buf_get_clients() > 0')
    return luaeval("require('lsp-status').status()")
  endif

  return ''
endfunction

set statusline=\ %t\ %h%m%r%{LspStatus()}\ %{get(b:,'gitsigns_status','')}%=%-14.(%l,%c%V%)\ %P

lua <<EOF
_G.setup_java = function()
    local on_attach = function(client, bufnr)
      require'jdtls.setup'.add_commands()
      require'jdtls'.setup_dap()
      require'lsp-status'.register_progress()

      local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
      local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

      buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

      -- Mappings.
      local opts = { noremap=true, silent=true }
      buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
      buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
      buf_set_keymap('n', 'gy', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
      buf_set_keymap("n", "<leader>fm", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

      -- Java specific
      buf_set_keymap("n", "<leader>di", "<Cmd>lua require'jdtls'.organize_imports()<CR>", opts)
      buf_set_keymap("n", "<leader>dt", "<Cmd>lua require'jdtls'.test_class()<CR>", opts)
      buf_set_keymap("n", "<leader>dn", "<Cmd>lua require'jdtls'.test_nearest_method()<CR>", opts)
      buf_set_keymap("v", "<leader>de", "<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>", opts)
      buf_set_keymap("n", "<leader>de", "<Cmd>lua require('jdtls').extract_variable()<CR>", opts)
      buf_set_keymap("v", "<leader>dm", "<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>", opts)

      vim.api.nvim_exec([[
          augroup lsp_document_highlight
            autocmd!
            autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
            autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
          augroup END
      ]], false)

    end

    local root_markers = {'gradlew', 'pom.xml'}
    local root_dir = require('jdtls.setup').find_root(root_markers)
    local home = os.getenv('HOME')

    local capabilities = {
        workspace = {
            configuration = true
        },
        textDocument = {
            completion = {
                completionItem = {
                    snippetSupport = true
                }
            }
        }
    }

    local workspace_folder = home .. "/.workspace" .. vim.fn.fnamemodify(root_dir, ":p:h:t")
    local config = {
        flags = {
          allow_incremental_sync = true,
        };
        capabilities = capabilities,
        on_attach = on_attach,
    }

    config.settings = {
        ['java.format.settings.url'] = home .. "/workspace/dotfiles/java-google-formatter.xml",
        ['java.format.settings.profile'] = "GoogleStyle",
        java = {
          signatureHelp = { enabled = true };
          contentProvider = { preferred = 'fernflower' };
          completion = {
            favoriteStaticMembers = {
              "org.hamcrest.MatcherAssert.assertThat",
              "org.hamcrest.Matchers.*",
              "org.hamcrest.CoreMatchers.*",
              "org.junit.jupiter.api.Assertions.*",
              "java.util.Objects.requireNonNull",
              "java.util.Objects.requireNonNullElse",
              "org.mockito.Mockito.*"
            }
          };
          sources = {
            organizeImports = {
              starThreshold = 9999;
              staticStarThreshold = 9999;
            };
          };
          codeGeneration = {
            toString = {
              template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}"
            }
          };
          configuration = {
            runtimes = {
              {
                name = "JavaSE-11",
                path = home .. "/.sdkman/candidates/java/11.0.2-open/",
              },
            }
          };
        };
    }
    config.cmd = {'jdtls.sh', workspace_folder}
    config.on_attach = on_attach
    config.on_init = function(client, _)
        client.notify('workspace/didChangeConfiguration', { settings = config.settings })
    end

    local extendedClientCapabilities = require'jdtls'.extendedClientCapabilities
    extendedClientCapabilities.resolveAdditionalTextEditsSupport = true
    config.init_options = {
      -- bundles = bundles;
      extendedClientCapabilities = extendedClientCapabilities;
    }

    -- UI
    local finders = require'telescope.finders'
    local sorters = require'telescope.sorters'
    local actions = require'telescope.actions'
    local pickers = require'telescope.pickers'
    require('jdtls.ui').pick_one_async = function(items, prompt, label_fn, cb)
      local opts = {}
      pickers.new(opts, {
        prompt_title = prompt,
        finder    = finders.new_table {
          results = items,
          entry_maker = function(entry)
            return {
              value = entry,
              display = label_fn(entry),
              ordinal = label_fn(entry),
            }
          end,
        },
        sorter = sorters.get_generic_fuzzy_sorter(),
        attach_mappings = function(prompt_bufnr)
          actions.goto_file_selection_edit:replace(function()
            local selection = actions.get_selected_entry(prompt_bufnr)
            actions.close(prompt_bufnr)

            cb(selection.value)
          end)

          return true
        end,
      }):find()
    end

    -- Server
    require('jdtls').start_or_attach(config)
end

vim.api.nvim_exec([[
  augroup jdtls_lsp
    autocmd!
    autocmd FileType java lua setup_java()
  augroup end
]], true)
EOF

lua << EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained",
  highlight = {
    enable = true,
    custom_captures = {},
  }
}

-- Lua
require("lsp-colors").setup({
  Error = "#db4b4b",
  Warning = "#e0af68",
  Information = "#0db9d7",
  Hint = "#10B981"
})

local saga = require 'lspsaga'
saga.init_lsp_saga {
  code_action_prompt = {
    enable = true,
    sign = false,
    sign_priority = 20,
    virtual_text = false,
  }
}

require("trouble").setup {}

vim.api.nvim_set_keymap("n", "<leader>xx", "<cmd>Trouble<cr>",
  {silent = true, noremap = true}
)
vim.api.nvim_set_keymap("n", "<leader>zz", "<cmd>TroubleClose<cr>",
  {silent = true, noremap = true}
)
vim.api.nvim_set_keymap("n", "<leader>da", "<cmd>Trouble lsp_workspace_diagnostics<cr>",
  {silent = true, noremap = true}
)
vim.api.nvim_set_keymap("n", "<localleader>da", "<cmd>Trouble lsp_document_diagnostics<cr>",
  {silent = true, noremap = true}
)
vim.api.nvim_set_keymap("n", "<leader>xl", "<cmd>Trouble loclist<cr>",
  {silent = true, noremap = true}
)
vim.api.nvim_set_keymap("n", "<leader>xq", "<cmd>Trouble quickfix<cr>",
  {silent = true, noremap = true}
)
vim.api.nvim_set_keymap("n", "gr", "<cmd>Trouble lsp_references<cr>",
  {silent = true, noremap = true}
)

require('lspkind').init({
    -- enables text annotations
    --
    -- default: true
    with_text = true,

    -- default symbol map
    -- can be either 'default' or
    -- 'codicons' for codicon preset (requires vscode-codicons font installed)
    --
    -- default: 'default'
    preset = 'codicons',

    -- override preset symbols
    --
    -- default: {}
    symbol_map = {
      Text = '',
      Method = 'ƒ',
      Function = '',
      Constructor = '',
      Variable = '',
      Class = '',
      Interface = 'ﰮ',
      Module = '',
      Property = '',
      Unit = '',
      Value = '',
      Enum = '了',
      Keyword = '',
      Snippet = '﬌',
      Color = '',
      File = '',
      Folder = '',
      EnumMember = '',
      Constant = '',
      Struct = ''
    },
})

require("todo-comments").setup { }
EOF

"}}}

"{{{ File explorer configuration
lua <<EOF
local tree_cb = require'nvim-tree.config'.nvim_tree_callback
vim.g.nvim_tree_bindings = {
  { key = {"l"}, cb = tree_cb("edit") },
  { key = {"h"}, cb = tree_cb("close_node") },
}
EOF

let g:nvim_tree_width = 40 "30 by default, can be width_in_columns or 'width_in_percent%'
let g:nvim_tree_quit_on_open = 1 "0 by default, closes the tree when you open a file
let g:nvim_tree_follow = 1 "0 by default, this option allows the cursor to be updated when entering a buffer
let g:nvim_tree_indent_markers = 0 "0 by default, this option shows indent markers when folders are open

nnoremap <silent> <leader>n <cmd>NvimTreeToggle<cr>
"}}}

"{{{ Git configuration
" Not gonna show shit messages when run git hook via husky
let g:fugitive_pty = 0

augroup Fugitive
  autocmd!
  " Auto-clean fugitive buffers
  autocmd BufReadPost fugitive://* set bufhidden=delete
augroup END

nnoremap <leader><leader>f <cmd>diffget //2 <cr> <cmd>w <cr> <cmd>diffupdate <cr>
nnoremap <leader><leader>j <cmd>diffget //3 <cr> <cmd>w <cr> <cmd>diffupdate <cr>

let g:lazygit_floating_window_winblend = 0
let g:lazygit_floating_window_scaling_factor = 0.9
nnoremap <silent> <leader>lg <cmd>LazyGit<cr>
nnoremap <silent> <leader>gl <cmd>0Glog<cr>
nnoremap <silent> <leader>gs <cmd>G difftool --name-status<cr>
nnoremap <silent> <localleader>gs <cmd>G difftool<cr>

lua << EOF
require('gitsigns').setup {
  signs = {
    add          = {hl = 'GitSignsAdd'   , text = '│', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
    change       = {hl = 'GitSignsChange', text = '│', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
    delete       = {hl = 'GitSignsDelete', text = '_', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    topdelete    = {hl = 'GitSignsDelete', text = '‾', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    changedelete = {hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
  },
  numhl = false,
  linehl = false,
  keymaps = {
    -- Default keymap options
    noremap = true,
    buffer = true,

    ['n ]c'] = { expr = true, "&diff ? ']c' : '<cmd>lua require\"gitsigns.actions\".next_hunk()<CR>'"},
    ['n [c'] = { expr = true, "&diff ? '[c' : '<cmd>lua require\"gitsigns.actions\".prev_hunk()<CR>'"},

    ['n <leader>ha'] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
    ['v <leader>ha'] = '<cmd>lua require"gitsigns".stage_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
    ['n <leader>hu'] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
    ['n <leader>hd'] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
    ['v <leader>hd'] = '<cmd>lua require"gitsigns".reset_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
    ['n <leader>hD'] = '<cmd>lua require"gitsigns".reset_buffer()<CR>',
    ['n <leader>hc'] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
    ['n <leader>bl'] = '<cmd>lua require"gitsigns".blame_line(true)<CR>',

    -- Text objects
    ['o ih'] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>',
    ['x ih'] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>'
  },
  watch_index = {
    interval = 1000,
    follow_files = true
  },
  current_line_blame = false,
  current_line_blame_delay = 1000,
  current_line_blame_position = 'eol',
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil, -- Use default
  word_diff = false,
  use_decoration_api = true,
  use_internal_diff = true,  -- If luajit is present
}

EOF

"}}}

"{{{ Vira
let g:vira_config_file_servers = $HOME . '/workspace/secrets/vira/vira_servers.json'
let g:vira_config_file_projects = $HOME . '/workspace/secrets/vira/vira_projects.json'

"}}}

"{{{ Other plugins
lua require'colorizer'.setup()

let g:tmux_navigator_disable_when_zoomed = 1
let g:vsnip_snippet_dir = $HOME . '/workspace/dotfiles/vsnip'
let g:vsnip_filetypes = {}
let g:vsnip_filetypes.javascriptreact = ['javascript']
let g:vsnip_filetypes.typescript = ['javascript', 'typescript']
let g:vsnip_filetypes.typescriptreact = ['javascript', 'typescript']

nnoremap <leader>u :UndotreeShow<cr>
nnoremap <leader>m :MaximizerToggle<cr>

" Vim syntax file
" Language: Todo
" Maintainer: Huy Tran
" Latest Revision: 14 June 2020

if exists("b:current_syntax")
  finish
endif

" Custom conceal
syntax match todoCheckbox "\[\ \]" conceal cchar=
syntax match todoCheckbox "\[x\]" conceal cchar=

let b:current_syntax = "todo"

hi def link todoCheckbox Todo
hi Conceal guibg=NONE

setlocal cole=1
" End todo

"}}}

