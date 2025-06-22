"{{{ Default mappings

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

if has("gui_macvim")
  color default
endif

augroup SetFileType
  autocmd!
  autocmd FileType vim set foldmethod=marker
  autocmd BufNewFile,BufRead *.zsh setlocal filetype=zsh
  autocmd FileType zsh set foldmethod=marker
  autocmd BufNewFile,BufRead *.conf setlocal filetype=conf
  autocmd FileType conf set foldmethod=marker
augroup END
"}}}

"{{{ Env file
if filereadable(expand("~/.env.vim"))
    source ~/.env.vim
endif
"}}}

"{{{ Git
let g:fugitive_pty = 0
nnoremap <leader>gf <cmd>diffget //2 <cr> <cmd>w <cr> <cmd>diffupdate <cr>
nnoremap <leader>gj <cmd>diffget //3 <cr> <cmd>w <cr> <cmd>diffupdate <cr>
nnoremap <leader>Gs <cmd>G difftool --name-status<cr>
nnoremap <leader>gs <cmd>G<cr>
nnoremap <leader><leader>gs <cmd>G difftool<cr>
nnoremap <leader><leader>bl <cmd>G blame<cr>
nnoremap <leader>gc :G commit -m ""<left>
nnoremap <leader>gl :GcLog<cr>
vnoremap <leader>gl :GcLog<cr>
nnoremap <leader>gL <cmd>0GcLog<cr>
nnoremap <leader>ga <cmd>G add -A<cr>
nnoremap <leader>hA <cmd>Gwrite<cr>
nnoremap <leader>hD <cmd>Gread<cr>
nnoremap <leader>gw <cmd>G commit -n -m "WIP"<cr>
nnoremap gpp <cmd>Dispatch git push -u origin $(git rev-parse --abbrev-ref HEAD) --force-with-lease<cr>
nnoremap gpt <cmd>Dispatch git push -u origin $(git rev-parse --abbrev-ref HEAD) --force-with-lease --follow-tags<cr>

nnoremap <leader>gy <cmd>GBrowse<cr>
vnoremap <leader>gy :GBrowse<cr>

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
"}}}

"{{{ Fuzzy Finder
let g:enable_fuzzyy_keymaps = 0
let g:files_respect_gitignore = 1
let g:fuzzyy_files_ignore_file = ['*.beam', '*.so', '*.exe', '*.dll', '*.dump', '*.core', '*.swn', '*.swp']
let g:fuzzyy_files_ignore_dir = ['.git', '.hg', '.svn', '.rebar', '.eunit', 'node_modules']
let g:fuzzyy_devicons = 0
let g:fuzzyy_dropdown = 0
nnoremap <leader>fc <cmd>FuzzyColors<cr>

hi! link CtrlPMatch Search
let g:ctrlp_root_markers = ['.git', 'yarn.lock', 'packages']
let g:ctrlp_show_hidden = 1
let g:ctrlp_regexp = 0
let g:ctrlp_map = '<leader>o'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$|node_modules|dist|module',
  \ 'file': '\v\.(exe|so|dll|DS_Store|d.ts|map)$',
  \ }
let g:ctrlp_prompt_mappings = {
  \ 'PrtBS()':              ['<bs>', '<c-]>'],
  \ 'PrtDelete()':          ['<del>'],
  \ 'PrtDeleteWord()':      ['<c-w>'],
  \ 'PrtClear()':           ['<c-u>'],
  \ 'PrtSelectMove("j")':   ['<c-j>', '<down>'],
  \ 'PrtSelectMove("k")':   ['<c-k>', '<up>'],
  \ 'PrtSelectMove("t")':   ['<Home>', '<kHome>'],
  \ 'PrtSelectMove("b")':   ['<End>', '<kEnd>'],
  \ 'PrtSelectMove("u")':   ['<PageUp>', '<kPageUp>'],
  \ 'PrtSelectMove("d")':   ['<PageDown>', '<kPageDown>'],
  \ 'PrtHistory(-1)':       ['<c-n>'],
  \ 'PrtHistory(1)':        ['<c-p>'],
  \ 'AcceptSelection("e")': ['<cr>', '<2-LeftMouse>'],
  \ 'AcceptSelection("h")': ['<c-x>', '<c-cr>', '<c-s>'],
  \ 'AcceptSelection("t")': ['<c-t>'],
  \ 'AcceptSelection("v")': ['<c-v>', '<RightMouse>'],
  \ 'ToggleFocus()':        ['<s-tab>'],
  \ 'ToggleRegex()':        ['<c-r>'],
  \ 'ToggleByFname()':      ['<c-d>'],
  \ 'ToggleType(1)':        ['<c-f>', '<c-up>'],
  \ 'ToggleType(-1)':       ['<c-b>', '<c-down>'],
  \ 'PrtExpandDir()':       ['<tab>'],
  \ 'PrtInsert("c")':       ['<MiddleMouse>', '<insert>'],
  \ 'PrtInsert()':          ['<c-\>'],
  \ 'PrtCurStart()':        ['<c-a>'],
  \ 'PrtCurEnd()':          ['<c-e>'],
  \ 'PrtCurLeft()':         ['<c-h>', '<left>', '<c-^>'],
  \ 'PrtCurRight()':        ['<c-l>', '<right>'],
  \ 'PrtClearCache()':      ['<F5>'],
  \ 'PrtDeleteEnt()':       ['<F7>'],
  \ 'CreateNewFile()':      ['<c-y>'],
  \ 'MarkToOpen()':         ['<c-m>'],
  \ 'OpenMulti()':          ['<c-o>'],
  \ 'PrtExit()':            ['<esc>', '<c-c>', '<c-g>'],
  \ }
" start search from the cwd instead of the current file's directory
let g:ctrlp_working_path_mode = ''
let g:ctrlp_match_func = {'match': 'ctrlp_matchfuzzy#matcher'}
nnoremap <leader>i <cmd>CtrlPBuffer<cr>
nnoremap <leader>/ <cmd>CtrlPLine<cr>
nnoremap <leader>tr <cmd>CtrlPLastMode<cr>
nnoremap <leader>ds <cmd>CtrlPFunky<cr>
nnoremap <leader>DS :execute 'CtrlPFunky ' . expand('<cword>')<cr>

let g:find_files_method='ctrlp'
function! SwitchFindFiles()
  if g:find_files_method == 'ctrlp'
    let g:find_files_method='fuzzy'
    echo "Using FuzzyFiles"
    nnoremap <leader>o <cmd>FuzzyFiles<cr>
  else
    let g:find_files_method='ctrlp'
    echo "Using CtrlP"
    nnoremap <leader>o <cmd>CtrlP<cr>
  endif
endfunction

nnoremap <leader>sf :call SwitchFindFiles()<cr>
"}}}

"{{{ LSP
let lspOpts = #{
      \ autoHighlightDiags: v:true,
      \ showDiagOnStatusLine: v:true,
      \ showDiagWithSign: v:true,
      \ usePopupInCodeAction: v:true,
      \ useQuickfixForLocations: v:true,
      \ useBufferCompletion: v:true,
      \ filterCompletionDuplicates: v:true,
      \ snippetSupport: v:false,
      \ vsnipSupport: v:false,
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
"}}}

"{{{ Snippets
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"

imap <expr> <C-j> vsnip#expandable() ? '<Plug>(vsnip-expand)' : '<C-j>'
smap <expr> <C-j> vsnip#expandable() ? '<Plug>(vsnip-expand)' : '<C-j>'
imap <expr> <C-l> vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
smap <expr> <C-l> vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
imap <expr> <c-l> vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)' : '<Tab>'
smap <expr> <c-l> vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)' : '<Tab>'
imap <expr> <c-h> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>'
smap <expr> <c-h> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>'

nmap s <Plug>(vsnip-select-text)
xmap s <Plug>(vsnip-select-text)
nmap S <Plug>(vsnip-cut-text)
xmap S <Plug>(vsnip-cut-text)

" If you want to use snippet for multiple filetypes, you can `g:vsnip_filetypes` for it.
let g:vsnip_filetypes = {}
let g:vsnip_filetypes.javascriptreact = ['javascript']
let g:vsnip_filetypes.typescriptreact = ['typescript']
"}}}

"{{{ Prettier
nmap <leader>fm <cmd>PrettierAsync<cr>
"}}}

"{{{ MISC Plugin
let g:asyncrun_open = 10

let g:rooter_patterns = [ ".git" ]
let g:rooter_manual_only = 1

let g:DirDiffExcludes = ".git,personal.*,.DS_Store,**/packer_compiled.lua,**/*.add,**/*.spl,*.png,*.jpg,*.jpeg,Session.vim,*/state.yml,plugin/*,spell/*,node_modules/*,*node_modules*,wezterm,karabiner,feh,arch,work.lua,env.zsh,.luarc.json,docs,lazy-lock.json"
nnoremap <leader>u <cmd>UndotreeToggle<cr>
"}}}

"{{{ netrw
" Salad
let g:no_plugin_maps=1
"}}}

"{{{ Custom functions
function! EOLSymbol()
   if &fileformat == 'dos'
       return '[CRLF(dos)]'
   elseif &fileformat == 'unix'
       return '[LF(unix)]'
   elseif &fileformat == 'mac'
       return '[CR:(mac)]'
   else
       return '[?eol]'
   endif
endfunction

function! FileEncoding()
     if strchars(&fileencoding) == 0
       return '[?enc]'
     else
       return '['.. &fileencoding ..']'
   endif
endfunction

function! BuildNearest()
   let package = findfile("package.json", ".;")
   if package != "package.json"
       let file = readfile(package, "b")
       if empty(file)
           echom "no package.json found"
           return
       endif
       let jsonString = join(file, "\n")
       let t = json_decode(jsonString)
       let packageName = t["name"]
       echom "Building " . packageName
       execute "Dispatch yarn workspace " . packageName . " build"
   endif
endfunction

nnoremap <leader>bd :call BuildNearest()<CR>

function! OpenNearestPackageJson()
    let package = findfile("package.json", ".;")
    if package != "package.json"
        execute "edit " . package
    endif
endfunction

nnoremap <leader>bp :call OpenNearestPackageJson()<CR>

function! GoToBuiltFile()
    let path = expand("%")
    let dist_path = substitute(path, "src", "dist", "")
    let js_file = ""
    if dist_path =~ ".tsx"
        let js_file = substitute(dist_path, ".tsx", ".js", "")
    else
        let js_file = substitute(dist_path, ".ts", ".js", "")
    endif
    if filereadable(js_file)
        execute "edit " . js_file
    else
        echom "Dist file not found"
    endif
endfunction

function! GoToSourceFile()
    let path = expand("%")
    let src_path = substitute(path, "dist", "src", "")
    let ts_file = substitute(src_path, ".js", ".ts", "")
    let tsx_file = substitute(src_path, ".js", ".tsx", "")
    if filereadable(ts_file)
        execute "edit " . ts_file
        return
    endif
    if filereadable(tsx_file)
        execute "edit " . tsx_file
        return
    endif
    echom "Source file not found"
endfunction

nnoremap <leader>gd :call GoToBuiltFile()<CR>
nnoremap <leader>GD :call GoToSourceFile()<CR>

function! NpmHome(type)
    let saved_unnamed_register = @@

    if a:type ==# 'v'
        normal! `<v`>y
    elseif a:type ==# 'char'
        normal! `[v`]y
    else
        return
    endif

    let package_name = @@
    execute "Dispatch npm home " . shellescape(package_name)

    let @@ = saved_unnamed_register
endfunction
nnoremap <leader>nh :set opfunc=NpmHome<CR>g@
vnoremap <leader>nh :<C-U>call NpmHome(visualmode())<CR>

function! GithubHome(type)
    let saved_unnamed_register = @@

    if a:type ==# 'v'
        normal! `<v`>y
    elseif a:type ==# 'char'
        normal! `[v`]y
    else
        return
    endif

    let package_name = @@
    execute "Dispatch open https://github.com/" . shellescape(package_name)

    let @@ = saved_unnamed_register
endfunction
nnoremap <leader>gh :set opfunc=GithubHome<CR>g@
vnoremap <leader>gh :<C-U>call GithubHome(visualmode())<CR>

function! CopyPath(isRelative)
    " Find the git root directory
    let l:git_root = system('git rev-parse --show-toplevel 2>/dev/null')[:-2]
    let l:full_path = expand('%:p')
    
    if a:isRelative
        if v:shell_error == 0 && !empty(l:git_root)
            " If in a git repo, get path relative to git root
            let l:path = substitute(l:full_path, l:git_root . '/', '', '')
        else
            " Fallback to current directory relative path
            let l:path = fnamemodify(expand("%"), ":~:.")
        endif
    else
        " Get absolute path from root
        let l:path = l:full_path
    endif
    
    " Copy to clipboard
    if has('unix')
        let @+ = l:path
        let @* = l:path
    else
        let @* = l:path
    endif
    
    echo "Copied: " . l:path
endfunction


nnoremap <leader>cp :call CopyPath(1)<CR>
nnoremap <leader>cP :call CopyPath(0)<CR>
"}}}

"{{{ Custom mappings
let g:asyncrun_rootmarks = ['.svn', '.git', '.gitignore', 'yarn.lock']
nnoremap <leader>fl :set foldlevel=
" This one for jump into \" \" when do space rg
cnoremap <expr> "" getcmdpos() > 20 ? repeat('<Left>', 50) : '""'
nnoremap <leader>rg :Ggrep -r -I -i --untracked -e "" -- :^**/dist/** :^/*.lock :^**/test/** :^*.test.* :^**/*.snap :^**/*.md<left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left>
nnoremap <leader>RG :Ggrep -r -I -i --untracked -e "<c-r><c-w>" -- :^**/test/** :^*.test.* :^**/*.snap :^**/*.md
nnoremap D y'>p
"}}}

"{{{ Plugins Declaration
call plug#begin()
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-eunuch'
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
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
Plug 'tpope/vim-vinegar'
Plug 'saccarosium/vim-netrw-salad'
" Plug 'tribela/vim-transparent'
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install --frozen-lockfile --production',
  \ 'for': ['javascript','javascriptreact', 'typescript',  'typescriptreact','css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'svelte', 'yaml', 'html'] }
Plug 'tpope/vim-dispatch'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tacahiroy/ctrlp-funky'
Plug 'mattn/ctrlp-matchfuzzy'
Plug 'nordtheme/vim'
Plug 'zhixiao-zhang/vim-light-pink'
call plug#end()
"}}}

"{{{ Settings
syntax on
filetype plugin indent on
set synmaxcol=0
let g:vimsyn_embed = 'lPr'
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
set cursorline
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
set regexpengine=2
set path+=**

" color retrobox
" color quiet
" color nord
color zaibatsu
" color morning
hi SpecialKey ctermfg=66 guifg=#ffffff
hi! link Folded NonText
hi! link LineNr NonText
" hi! link Comment NonText
hi NonText guifg=#030552
hi SpecialKey guifg=#030552

packadd cfilter
set statusline=[%n]\ %<%F\ %h%m%r%=%(%l,%c%V%)\ %P\ %{FileEncoding()}\ %{EOLSymbol()}
"}}}
