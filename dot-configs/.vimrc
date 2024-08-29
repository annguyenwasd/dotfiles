if !has('gui_running')
  set t_Co=256

endif

syntax enable
filetype plugin indent on
let g:vimsyn_embed = 'lPr'
setlocal regexpengine=2
set noerrorbells
set splitbelow
set splitright
set wildmenu
set termguicolors
set nowrap
set hidden
set noswapfile
set ignorecase
set incsearch
set hlsearch
set expandtab
set number
set relativenumber
set noerrorbells
set nocursorline
set exrc
set secure
set signcolumn=yes
set clipboard=unnamed
set updatetime=100
set mouse=a
set scrolloff=8
set shortmess+=c
set completeopt=menuone,noinsert,noselect
set smartindent
set shiftwidth=2
set softtabstop=2
set tabstop=2
set undofile
set udir=$HOME/.vim/undo-vim
set listchars=eol:¬,tab:▹\ ,trail:+,lead:·
set list
set laststatus=2
set showmode
set lazyredraw
set nobackup
set nowritebackup
set regexpengine=1

fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun
command! TrimWhitespace call TrimWhitespace()

let mapleader=" "
let maplocalleader="\\"

nmap n nzozt
nmap N Nzozt
nmap * *zozt
nmap # #zozt

nnoremap Y y$
vmap D y'>p

nnoremap <silent> <leader>cl <cmd>ccl<cr><cmd>lcl<cr><cmd>echo ''<cr><cmd>nohlsearch<cr>
nnoremap <leader><leader>r <cmd>so ~/.vimrc<cr>
nnoremap <leader><leader>R <cmd>so ~/.vimrc<cr><cmd>PlugInstall<cr>
vnoremap <leader>p "_dP

nnoremap <silent> <c-w><c-e> <c-w>=

cnoremap <c-h> <left>
cnoremap <c-j> <down>
cnoremap <c-k> <up>
cnoremap <c-l> <right>

inoremap <c-h> <left>
inoremap <c-j> <down>
inoremap <c-k> <up>
inoremap <c-l> <right>

nnoremap <leader>e <cmd>b #<cr>

cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

nmap <c-w>v <c-w>v <c-w>l
nmap <c-w><c-v> <c-w>v <c-w>l
nmap <c-w>s <c-w>s <c-w>j
nmap <c-w><c-s> <c-w>s <c-w>j
nmap <c-w><c-w> <c-w>q

nmap <c-h> <c-w>h
nmap <c-j> <c-w>j
nmap <c-k> <c-w>k
nmap <c-l> <c-w>l

color retrobox

if has("gui_macvim")
  color default
endif

call plug#begin()
Plug 'preservim/nerdtree'
Plug 'PhilRunninger/nerdtree-visual-selection'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-fugitive'
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
Plug 'skywind3000/asyncrun.vim'
Plug 'godlygeek/tabular'
Plug 'airblade/vim-rooter'
Plug 'will133/vim-dirdiff', { 'on': 'DirDiff' }
Plug 'tpope/vim-commentary'
Plug 'airblade/vim-gitgutter'
Plug 'Donaldttt/fuzzyy'
Plug 'yegappan/lsp'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'
Plug 'rafamadriz/friendly-snippets'
call plug#end()


let g:NERDTreeWinSize = 45
let NERDTreeWinPos = "right"
let NERDTreeMinimalUI = 1
let NERDTreeShowHidden = 1
let NERDTreeQuitOnOpen = 1
nnoremap <leader>n <cmd>NERDTreeToggle<cr>
nnoremap - <cmd>NERDTreeFind<cr>

let g:asyncrun_open = 10

let g:fugitive_pty = 0
nnoremap <leader>gf <cmd>diffget //2 <cr> <cmd>w <cr> <cmd>diffupdate <cr>
nnoremap <leader>gj <cmd>diffget //3 <cr> <cmd>w <cr> <cmd>diffupdate <cr>
nnoremap <leader>gL <cmd>GcLog<cr>
nnoremap <leader>Gs <cmd>G difftool --name-status<cr>
nnoremap <leader>gs <cmd>G<cr>
nnoremap <leader><leader>gs <cmd>G difftool<cr>
nnoremap <leader><leader>bl <cmd>G blame<cr>
nnoremap <leader>gc :G commit -m ""<left>
nnoremap <leader>ga <cmd>G add -A<cr>
nnoremap <leader>gw <cmd>G commit -n -m "WIP"<cr>
nnoremap gpp <cmd>AsyncRun git push -u origin $(git rev-parse --abbrev-ref HEAD) --force-with-lease<cr>
nnoremap gpt <cmd>AsyncRun git push -u origin $(git rev-parse --abbrev-ref HEAD) --force-with-lease --follow-tags<cr>

let g:rooter_patterns = [ ".git" ]
let g:rooter_manual_only = 1

let g:DirDiffExcludes = ".git,personal.*,.DS_Store,**/packer_compiled.lua,**/*.add,**/*.spl,*.png,*.jpg,*.jpeg,Session.vim,*/state.yml,plugin/*,spell/*,node_modules/*,*node_modules*"
nnoremap <leader>u <cmd>UndotreeShow<cr>

let g:enable_fuzzyy_keymaps = 0
let g:files_respect_gitignore = 1
let g:fuzzyy_files_ignore_file = ['*.beam', '*.so', '*.exe', '*.dll', '*.dump', '*.core', '*.swn', '*.swp']
let g:fuzzyy_files_ignore_dir = ['.git', '.hg', '.svn', '.rebar', '.eunit']
let g:fuzzyy_devicons = 0
let g:fuzzyy_dropdown = 1
nnoremap <leader>o <cmd>FuzzyFiles<cr>
nnoremap <leader>i <cmd>FuzzyBuffers<cr>
nnoremap <leader>/ <cmd>FuzzyInBuffer<cr>
nnoremap <leader><leader>/ :FuzzyInBuffer <c-r><c-w><cr>
nnoremap <leader><leader>fc <cmd>FuzzyCommands<cr>
nnoremap <leader>ch <cmd>FuzzyCmdHistory<cr>
nnoremap <leader>rg <cmd>FuzzyGrep<cr>
nnoremap <leader>RG :FuzzyGrep <C-R><C-W><cr>
nnoremap <leader>fh <cmd>FuzzyHelps<cr>
nnoremap <leader>fc <cmd>FuzzyColors<cr>

let lspOpts = #{
      \ autoHighlightDiags: v:true,
      \ showDiagOnStatusLine: v:true,
      \ showDiagWithSign: v:true,
      \ snippetSupport: v:true,
      \ usePopupInCodeAction: v:true,
      \ useQuickfixForLocations: v:true,
      \ useBufferCompletion: v:true,
      \ filterCompletionDuplicates: v:true,
      \ vsnipSupport: v:true,
      \ showInlayHints: v:false,
      \ showDiagWithVirtualText: v:false}
autocmd User LspSetup call LspOptionsSet(lspOpts)

let lspServers = [#{
	\    name: 'typescriptlang',
	\    filetype: ['javascript', 'typescript', 'typescriptreact', 'javascriptreact'],
	\    path: expand('~') . '/.node_modules/bin/typescript-language-server',
	\    args: ['--stdio'],
	\  }]
autocmd User LspSetup call LspAddServer(lspServers)

function! OnAttach()
  nnoremap <buffer> <leader>ca <cmd>LspCodeAction<cr>
  nnoremap <buffer> <leader>ld <cmd>LspDiag current<cr>
  nnoremap <buffer> <leader>da <cmd>LspDiag show<cr>
  nnoremap <buffer> <leader>ds <cmd>LspDocumentSymbol<cr>
  nnoremap <buffer> <leader>ws <cmd>LspSymbolSearch<cr>
  nnoremap <buffer> <leader>lf <cmd>LspFold<cr>
  nnoremap <buffer> ]d <cmd>LspDiag next<cr>
  nnoremap <buffer> [d <cmd>LspDiag prev<cr>
  nnoremap <buffer> <leader>fm <cmd>LspFormat<cr>
  nnoremap <buffer> gd <cmd>LspGotoDefinition<cr>
  nnoremap <buffer> gr <cmd>LspShowReferences<cr>
  nnoremap <buffer> gD <cmd>LspGotoDeclaration<cr>
  nnoremap <buffer> gi <cmd>LspGotoImpl<cr>
  nnoremap <buffer> gy <cmd>LspGotoTypeDef<cr>
  nnoremap <buffer> K <cmd>LspHover<cr>
  nnoremap <buffer> <leader>rn <cmd>LspRename<cr>
  vnoremap <buffer> [ <cmd>LspSelectionExpand<cr>
  vnoremap <buffer> ] <cmd>LspSelectionShrink<cr>
  nnoremap <buffer> <c-s> <cmd>LspShowSignature<cr>
  nnoremap <buffer> ghl <cmd>LspHighlight<cr>
  nnoremap <buffer> ghc <cmd>LspHighlightClear<cr>
endfunction
autocmd User LspAttached call OnAttach()

imap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'
smap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'
imap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
smap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
imap <expr> <c-l>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
smap <expr> <c-l>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
imap <expr> <c-h> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
smap <expr> <c-h> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'

nmap        s   <Plug>(vsnip-select-text)
xmap        s   <Plug>(vsnip-select-text)
nmap        S   <Plug>(vsnip-cut-text)
xmap        S   <Plug>(vsnip-cut-text)

" If you want to use snippet for multiple filetypes, you can `g:vsnip_filetypes` for it.
let g:vsnip_filetypes = {}
let g:vsnip_filetypes.javascriptreact = ['javascript']
let g:vsnip_filetypes.typescriptreact = ['typescript']

let g:gitgutter_map_keys = 0

nmap <leader>hc <Plug>(GitGutterPreviewHunk)
nmap <leader>ha <Plug>(GitGutterStageHunk)
nmap <leader>hd <Plug>(GitGutterUndoHunk)
nmap [c <Plug>(GitGutterPrevHunk)
nmap ]c <Plug>(GitGutterNextHunk)
omap ih <Plug>(GitGutterTextObjectInnerPending)
omap ah <Plug>(GitGutterTextObjectOuterPending)
xmap ih <Plug>(GitGutterTextObjectInnerVisual)
xmap ah <Plug>(GitGutterTextObjectOuterVisual)
