"{{{ Settings
syntax enable
filetype plugin indent on
let g:vimsyn_embed = 'lPr'

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
set nohlsearch 
set number 
set relativenumber 
set noerrorbells 
set cursorline
set exrc 
set secure
set signcolumn=yes
set clipboard=unnamed
set updatetime=50
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

augroup vimrc_help
  autocmd!
  autocmd BufEnter *.txt if &buftype == 'help' | wincmd L | endif
augroup END

augroup SetFileType
  autocmd!
  autocmd FileType vim set foldmethod=marker
  autocmd BufNewFile,BufRead *.zsh setlocal filetype=zsh
  autocmd FileType zsh set foldmethod=marker
  autocmd BufNewFile,BufRead *.conf setlocal filetype=conf
  autocmd FileType conf set foldmethod=marker
augroup END

"augroup CursorLineOnlyInActiveWindow
"  autocmd!
"  autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
"  autocmd WinLeave * setlocal nocursorline
"augroup END

fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun


"}}}

"{{{ Mappings
let mapleader=" "
let maplocalleader="\\"

nmap n nzozt
nmap N Nzozt
nmap * *zozt
nmap # #zozt

nnoremap Y y$
" Duplicate everything selected
vmap D y'>p
" Do search with selected text in VISUAL mode
vmap * y<cmd>let @/ = @"<cr><cmd>set hlsearch<cr>
" Highlight then back to original position
nnoremap <leader>h <cmd>History<cr>

" inoremap jk <esc><cmd>wa<cr><cmd>e<cr>
nnoremap <silent> <leader>cl <cmd>ccl<cr><cmd>lcl<cr><cmd>echo ''<cr>
nnoremap <leader><leader>r <cmd>so ~/.config/nvim/init.vim<cr>

" Resize
" nnoremap <silent> <Up> <cmd>res +5<cr>
" nnoremap <silent> <Down> <cmd>res -5<cr>
" nnoremap <silent> <Left> <cmd>vertical res -5<cr>
" nnoremap <silent> <Right> <cmd>vertical res +5<cr>
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

nnoremap <leader>ff <cmd>Files %:h<cr>
nnoremap <leader>e <cmd>b #<cr>
nnoremap <leader><leader>e <cmd>e<cr>
nnoremap <silent> <leader><leader>b <cmd>BufOnly<cr>

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

" Windows
nmap <c-w>v     <c-w>v <c-w>l
nmap <c-w><c-v> <c-w>v <c-w>l
nmap <c-w>s     <c-w>s <c-w>j
nmap <c-w><c-s> <c-w>s <c-w>j
nmap <c-w><c-w> <c-w>q

" Window navigations
nmap <c-h> <c-w>h
nmap <c-j> <c-w>j
nmap <c-k> <c-w>k
nmap <c-l> <c-w>l

nnoremap <leader>sc yiw}O<cr>const <c-r>" = styled.div``;<esc><c-o>
nnoremap <leader>rr "rciw
"}}}
