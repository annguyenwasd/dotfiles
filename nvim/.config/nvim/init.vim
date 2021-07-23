"{{{ Plugins
call plug#begin('~/.vim/plugged')
" LSP, debug
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'puremourning/vimspector'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" FZF
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" MISC
Plug 'rafamadriz/friendly-snippets'
Plug 'ryanoasis/vim-devicons'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-eunuch'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'kevinhwang91/nvim-bqf'
Plug 'JoosepAlviste/nvim-ts-context-commentstring'
Plug 'vim-scripts/BufOnly.vim'
Plug 'szw/vim-maximizer'
Plug 'mbbill/undotree'
Plug 'nvim-lua/plenary.nvim'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'KabbAmine/vCoolor.vim'
Plug 'skywind3000/asyncrun.vim'
Plug 'ThePrimeagen/vim-be-good'
Plug 'ThePrimeagen/harpoon'
Plug 'nvim-lua/popup.nvim'

" Tmux integration
Plug 'christoomey/vim-tmux-navigator'
Plug 'tmux-plugins/vim-tmux-focus-events'

"Git
Plug 'tpope/vim-fugitive'
Plug 'kdheepak/lazygit.nvim'
Plug 'lewis6991/gitsigns.nvim'

" Theme
Plug 'tjdevries/colorbuddy.vim'
Plug 'rktjmp/lush.nvim'

Plug 'lifepillar/vim-gruvbox8'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'bluz71/vim-nightfly-guicolors'
Plug 'yonlu/omni.vim'
Plug 'doums/darcula'
Plug 'chiendo97/intellij.vim'
Plug 'folke/tokyonight.nvim'
Plug 'sainnhe/sonokai'
Plug 'marko-cerovac/material.nvim'
Plug 'ChristianChiarulli/nvcode-color-schemes.vim'
Plug 'shaunsingh/moonlight.nvim'
Plug 'arzg/vim-colors-xcode'
Plug 'lourenci/github-colors'
Plug 'MordechaiHadad/nvim-papadark'
call plug#end()
"}}}

"{{{ Settings
syntax enable
filetype plugin indent on

set splitbelow
set splitright
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

augroup CursorLineOnlyInActiveWindow
  autocmd!
  autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  autocmd WinLeave * setlocal nocursorline
augroup END

fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun


let g:vimsyn_embed = 'lPr' " Highlight lua syntax inside vim
"}}}

"{{{ Mappings
let mapleader=" "
let maplocalleader="\\"

nmap n nzozz
nmap N nzozz
nmap * *zozz
nmap # #zozz

nnoremap Y y$
" Duplicate everything selected
vmap D y'>p
" Do search with selected text in VISUAL mode
vmap * y<cmd>let @/ = @"<cr><cmd>set hlsearch<cr>
" Highlight then back to original position
nnoremap <leader>h <cmd>History<cr>

" inoremap jk <esc><cmd>wa<cr><cmd>e<cr>
nnoremap <silent> <leader>cl <cmd>ccl<cr><cmd>lcl<cr>
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

nnoremap <leader>ff :call OpenFileInFolder()<cr>
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

command CFN :call CopyFileName()
command CFA :call CopyAbsouPathPath()
command CF :call CopyFileRelativePath()
command CFP :call CopyFileRelativePathFolder()
command GG :call GoogleJavaFormat()
command FF :call OpenFileInFolder()

function OpenFileInFolder()
  let current_folder = expand("%:h")
  call fzf#vim#files(current_folder, {'source' : 'ls'})
endfunction

function CopyFileName()
 let @* = expand("%:t")
 let @r = expand("%:t")
endfunction

function CopyAbsouPathPath()
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
  au ColorScheme * hi Visual guibg=Yellow guifg=Black
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

"}}}

"{{{ FZF configuration
nnoremap <Leader>o  <cmd>Files<cr>
nnoremap <Leader>i  <cmd>Buffers<cr>
nnoremap <Leader>/  <cmd>BLines<cr>
nnoremap <leader><Leader>/ <cmd>Lines<cr>
nnoremap <Leader>rg :RG<space>
nnoremap <leader>fh <cmd>Helptags<cr>
nnoremap <leader>ch <cmd>History:<cr>
nnoremap <leader>sh <cmd>History/<cr>
nnoremap <leader>fc <cmd>Commands<cr>
nnoremap <leader>fl <cmd>Lines<cr>
nnoremap <localleader>fc <cmd>Colors<cr>
nnoremap <leader>km <cmd>Maps<cr>

command! -bang -nargs=* RG
  \ call fzf#vim#grep(
  \   'rg --column --hidden --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)

"{{{ FZF layout
" Default fzf layout
" - Popup window (center of the screen)
" let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }

" - Popup window (center of the current window)
" let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6, 'relative': v:true } }

" - Popup window (anchored to the bottom of the current window)
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6, 'relative': v:true, 'yoffset': 1.0 } }

" - down / up / left / right
" let g:fzf_layout = { 'down': '30%' }

" - Window using a Vim command
" let g:fzf_layout = { 'window': 'enew' }
" let g:fzf_layout = { 'window': '-tabnew' }
" let g:fzf_layout = { 'window': '10new' }
"}}}


let g:fzf_buffers_jump = 1
let g:fzf_preview_window = ['right:60%:hidden', '?']
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal', 'Folded'],
  \ 'hl':      ['fg', 'Normal'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" An action can be a reference to a function that processes selected lines
function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction

let g:fzf_action = {
  \ 'ctrl-q': function('s:build_quickfix_list'),
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit'
  \}

let $FZF_DEFAULT_OPTS .= ' --inline-info --bind ctrl-b:preview-up,ctrl-f:preview-down --layout=reverse'

if executable('rg')
  let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'
  set grepprg=rg\ --vimgrep
  command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)
endif


"}}}

"{{{ LSP configuration

lua << EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained",
  highlight = {
    enable = true,
  }
}
EOF
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>":
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<cr>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Make <cr> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<cr>\<c-r>=coc#on_enter()\<cr>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

nmap <silent> ]s <cmd>CocCommand document.jumpToNextSymbol<cr>
nmap <silent> [s <cmd>CocCommand document.jumpToPrevSymbol<cr>

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<cr>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)
nnoremap <leader>cs :CocSearch<space>

" Formatting selected code.
xmap <leader>fm  <Plug>(coc-format-selected)
nmap <localleader>fm  <Plug>(coc-format-selected)
nmap <leader>fm :call CocActionAsync('format')<cr>

augroup CocSettings
  autocmd!
  " Highlight the symbol and its references when holding the cursor.
  autocmd CursorHold * silent call CocActionAsync('highlight')
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <localleader>ac  <Plug>(coc-codeaction)
nmap <leader>ac  <Plug>(coc-codeaction-line)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)
nmap <leader>af <cmd>CocCommand tsserver.executeAutofix<cr><cmd>CocCommand eslint.executeAutofix<cr>
if &filetype == "java"
  nnoremap <leader><leader>oi <cmd>CocCommand editor.action.organizeImport<cr>
else
  nnoremap <leader><leader>oi <cmd>CocCommand tsserver.organizeImports<cr>
endif

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

let g:coc_status_warning_sign=" "
let g:coc_status_error_sign=" "

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline=\ %{GetIcon()}\ %.40f\ %m%r\ %{coc#status()}%=%{GitBranchName()}\ %{GitAttributes()}\ \ %l/%L,%c

function GetIcon() abort
  let l:buffer_name = expand("%")
  if l:buffer_name == ''
    return ''
  endif

 return luaeval("require'nvim-web-devicons'.get_icon(vim.fn.expand(\"%:t\"), require'plenary.filetype'.detect(vim.api.nvim_buf_get_name(0)), { default = true })") 
endfunction

function GitAttributes()
 let l:git_signs = get(b:,'gitsigns_status_dict', {})
 let l:added = get(l:git_signs, 'added', '0')
 let l:removed = get(l:git_signs, 'removed', '0')
 let l:changed = get(l:git_signs, 'changed', '0')
 let l:head = get(l:git_signs, 'head', '')

 if l:head == ''
   return ''
 endif

  return "  " . l:added .  " 柳" . l:changed .  "  " . l:removed
endfunction

function GitBranchName()
 let l:git_signs = get(b:,'gitsigns_status_dict', {})
 let l:head = get(l:git_signs, 'head', '')
 let l:limit = 18

 if l:head == ''
   return ''
 endif

 if strlen(l:head) > l:limit
  return  "   " . strpart(l:head, 0, 8) . "..." . strpart(l:head, strlen(l:head) - 10)
endif

  return  "   " .  l:head
endfunction

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <leader>da  :<C-u>CocList diagnostics<cr>
nnoremap <silent><nowait> <localleader>da  <cmd>CocDiagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <leader>ce  :<C-u>CocList marketplace<cr>
" Show commands.
nnoremap <silent><nowait> <leader>cc  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <leader>co  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <leader>ws  :<C-u>CocList -I symbols<cr>
" Resume latest coc list.
nnoremap <silent><nowait> <leader>cr  :<C-u>CocListResume<cr>

" :h CocLocationsChange for detail
let g:coc_enable_locationlist = 0
augroup Coc
    autocmd!
    autocmd User CocLocationsChange ++nested call Coc_qf_jump2loc(g:coc_jump_locations)
augroup END

nmap <silent> gr <Plug>(coc-references)
nnoremap <silent> <leader>da <Cmd>call Coc_qf_diagnostic()<CR>

function! Coc_qf_diagnostic() abort
    let diagnostic_list = CocAction('diagnosticList')
    let items = []
    let loc_ranges = []
    for d in diagnostic_list
        let type = d.severity[0]
        let text = printf('[%s%s] %s [%s]', (empty(d.source) ? 'coc.nvim' : d.source),
                    \ (d.code ? ' ' . d.code : ''), split(d.message, '\n')[0], type)
        let item = {'filename': d.file, 'lnum': d.lnum, 'col': d.col, 'text': text, 'type': type}
        call add(loc_ranges, d.location.range)
        call add(items, item)
    endfor
    call setqflist([], ' ', {'title': 'CocDiagnosticList', 'items': items,
                \ 'context': {
                  \ 'bqf': {'lsp_ranges_hl': loc_ranges}
                  \}
                \})
    botright copen
endfunction

function! Coc_qf_jump2loc(locs) abort
    let loc_ranges = map(deepcopy(a:locs), 'v:val.range')
    call setloclist(0, [], ' ', {'title': 'CocLocationList', 'items': a:locs,
                \ 'context': {'bqf': {'lsp_ranges_hl': loc_ranges}
                \}
                \})
    let winid = getloclist(0, {'winid': 0}).winid
    if winid == 0
        aboveleft lwindow
    else
        call win_gotoid(winid)
    endif
  endfunction
"}}}

"{{{ Debug configuration
let g:vimspector_base_dir=expand( '$HOME/.vim/vimspector-config' )
if &filetype == "java"
  nnoremap <leader>dd :CocCommand java.debug.vimspector.start<cr>
else
  nnoremap <leader>dd :<c-u>call vimspector#Launch()<cr>
endif

nnoremap <leader>ds :VimspectorReset<cr>
nnoremap <leader>dS :<c-u>call vimspector#Stop()<cr>
nnoremap <leader>rs :<c-u>call vimspector#Restart()<cr>
nnoremap <leader>dp :<c-u>call vimspector#Pause()<cr>
nnoremap <leader>db :<c-u>call vimspector#ToggleBreakpoint()<cr>
nnoremap <leader>dB :<c-u>call vimspector#ToggleBreakpoint( { 'condition': input( 'Enter condition expression: ' ), 'hitCondition': input( 'Enter hit count expression: ' ) })<cr>
nnoremap <leader>fb :<c-u>call vimspector#AddFunctionBreakpoint( '<cexpr>' )<cr>
nnoremap <leader>cb :<c-u>call vimspector#ClearBreakpoints()<cr>
nnoremap <leader>rc :<c-u>call vimspector#RunToCursor()<cr>

nnoremap <leader>do :<c-u>call vimspector#StepOver()<cr>
nnoremap <leader>di :<c-u>call vimspector#StepInto()<cr>
nnoremap <leader>dO :<c-u>call vimspector#StepOut()<cr>
nnoremap <leader>dc :<c-u>call vimspector#Continue()<cr>

nnoremap <leader>dk :<c-u>call vimspector#UpFrame()<cr>
nnoremap <leader>dj :<c-u>call vimspector#DownFrame()<cr>

nnoremap <leader>dE :<Plug>VimspectorBalloonEval<space>
nnoremap <leader>de :VimspectorEval<space>
nnoremap <leader>dw :VimspectorWatch<space>


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
let g:lazygit_floating_window_winblend = 0
let g:lazygit_floating_window_scaling_factor = 0.9

augroup Fugitive
  autocmd!
  " Auto-clean fugitive buffers
  autocmd BufReadPost fugitive://* set bufhidden=delete
augroup END

function GitCommit() abort
  !git add -A
  vsplit term://git commit
endfunction

nnoremap <leader><leader>f <cmd>diffget //2 <cr> <cmd>w <cr> <cmd>diffupdate <cr>
nnoremap <leader><leader>j <cmd>diffget //3 <cr> <cmd>w <cr> <cmd>diffupdate <cr>

nnoremap <silent> <leader>lg <cmd>LazyGit<cr>
nnoremap <silent> <leader>gl <cmd>0Glog<cr>
nnoremap <silent> <leader>gs <cmd>G difftool --name-status<cr>
nnoremap <silent> <localleader>gs <cmd>G difftool<cr>
nnoremap <silent> <localleader>bl <cmd>G blame<cr>
nnoremap <silent> <leader>gc :call GitCommit()<cr>

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

    ['n ]c'] = { expr = true, "&diff ? ']c' : '<cmd>lua require\"gitsigns.actions\".next_hunk()<CR>zo'"},
    ['n [c'] = { expr = true, "&diff ? '[c' : '<cmd>lua require\"gitsigns.actions\".prev_hunk()<CR>zo'"},

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

"{{{ Other plugins
lua << EOF
require'colorizer'.setup()
require'nvim-web-devicons'.setup {
  override = {
    typescriptreact = {
        icon = "",
        color = "#519aba",
        name = "Tsx",
    },
    javascriptreact = {
        icon = "",
        color = "#519aba",
        name = "Jsx",
    },
    typescript = {
      icon = "",
      color = "#519aba",
      name = "Ts"
    }
  },
  default = true
}

require("harpoon").setup()

EOF

let g:tmux_navigator_disable_when_zoomed = 1

nnoremap <leader>u :UndotreeShow<cr>
nnoremap <leader>m :MaximizerToggle<cr>
nnoremap <leader>dt :CocCommand docthis.documentThis<cr>

nnoremap ma <cmd>lua require("harpoon.mark").add_file()<cr>
nnoremap '1 <cmd>lua require("harpoon.ui").nav_file(1)<cr>
nnoremap '2 <cmd>lua require("harpoon.ui").nav_file(2)<cr>
nnoremap '3 <cmd>lua require("harpoon.ui").nav_file(3)<cr>
nnoremap mq <cmd>lua require("harpoon.ui").toggle_quick_menu()<cr>
"}}}

"{{{ TODO
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
