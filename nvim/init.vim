"{{{ Plugins
call plug#begin('~/.vim/plugged')
" LSP
Plug 'SirVer/ultisnips'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'puremourning/vimspector'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'ryanoasis/vim-devicons'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-obsession'
Plug 'mbbill/undotree'
Plug 'szw/vim-maximizer'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'KabbAmine/vCoolor.vim'
Plug 'junegunn/vim-easy-align'
Plug 'christoomey/vim-sort-motion'
Plug 'kevinhwang91/nvim-bqf'
Plug 'tpope/vim-eunuch'
Plug 'skywind3000/asyncrun.vim'
Plug 'n0v1c3/vira', { 'do': './install.sh' }
Plug 'JoosepAlviste/nvim-ts-context-commentstring'


" Tmux integration
Plug 'christoomey/vim-tmux-navigator'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'slarwise/vim-tmux-send'

"Git
Plug 'tpope/vim-fugitive'
Plug 'kdheepak/lazygit.nvim'

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
Plug 'wojciechkepka/vim-github-dark'
Plug 'shaunsingh/moonlight.nvim'
Plug 'arzg/vim-colors-xcode'
Plug 'lourenci/github-colors'
Plug 'MordechaiHadad/nvim-papadark'
call plug#end()
"}}}

"{{{ Settings
syntax enable
filetype plugin indent on

set wildmenu termguicolors nowrap hidden noswapfile ignorecase incsearch expandtab nohlsearch number relativenumber noerrorbells cursorline
set exrc secure " load user config
set signcolumn=yes:3
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

fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun


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
nnoremap <leader>h <cmd>History<cr>
nnoremap n nzz

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

command CF :call CopyFileName()
command CFF :call CopyFileFullPath()
command CFR :call CopyFileRelativePath()
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

colorscheme gruvbox

if get(g:, 'colors_name') == 'material' && get(g:, 'material_style') == 'oceanic'
  hi NormalFloat guibg=#1e577d
endif

if get(g:, 'colors_name') == 'gruvbox_hard' && &background == 'dark'
  hi StatusLine guifg=#A7AE08 guibg=#282a36
endif


"}}}

"{{{ FZF configuration
nnoremap <Leader>o  <cmd>Files<cr>
nnoremap <Leader>i  <cmd>Buffers<cr>
" nnoremap <Leader>ll  <cmd>Lines<cr>
nnoremap <Leader>rg <cmd>Rg<cr>
nnoremap <leader>fh <cmd>Helptags<cr>
nnoremap <leader>ch <cmd>History:<cr>
nnoremap <leader>sh <cmd>History/<cr>
nnoremap <leader>fc <cmd>Commands<cr>
nnoremap <leader>fl <cmd>Lines<cr>
nnoremap <localleader>fc <cmd>Colors<cr>

let g:fzf_buffers_jump = 1
let g:fzf_layout = { 'down': '~30%' }
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

let g:fzf_action = {
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit'
  \}

let $FZF_DEFAULT_OPTS .= ' --inline-info --bind ctrl-u:preview-up,ctrl-d:preview-down --layout=reverse'

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
nnoremap <Leader>ps :CocSearch<space>

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
nmap <localleader>e <cmd>CocCommand eslint.executeAutofix<cr>
nmap <localleader>t <cmd>CocCommand tsserver.executeAutofix<cr>
nnoremap `o <cmd>CocCommand tsserver.organizeImports<cr>
au FileType java nnoremap `o <cmd>CocCommand editor.action.organizeImport<cr>

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

let g:coc_status_error_sign=" "
let g:coc_status_warning_sign=" "

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline=%t\ %h%m%r%{get(b:,'coc_git_status','')}%{coc#status()}%=%-14.(%l,%c%V%)\ %P

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
" Do default action for next item.
nnoremap <silent><nowait> <leader>j  :<C-u>CocNext<cr>
" Do default action for previous item.
nnoremap <silent><nowait> <leader>k  :<C-u>CocPrev<cr>
" Resume latest coc list.
nnoremap <silent><nowait> <leader>cr  :<C-u>CocListResume<cr>

let g:vimspector_enable_mappings = 'HUMAN'
nnoremap <leader>dd :<c-u>call vimspector#Launch()<cr>
au FileType java nnoremap <leader>dd :CocCommand java.debug.vimspector.start<cr>
nnoremap <leader>ds :VimspectorReset<cr>
nnoremap <leader>de :VimspectorEval<space>
nnoremap <leader>dw :VimspectorWatch<space>

nnoremap <leader>dc :<c-u>call vimspector#Continue()<cr>
nnoremap <localleader>ds :<c-u>call vimspector#Stop()<cr>
nnoremap <leader>dr :<c-u>call vimspector#Restart()<cr>
nnoremap <leader>dp :<c-u>call vimspector#Pause()<cr>
nnoremap <leader>db :<c-u>call vimspector#ToggleBreakpoint()<cr>
nnoremap <localleader>db :<c-u>call vimspector#ToggleBreakpoint( { 'condition': input( 'Enter condition expression: ' ), 'hitCondition': input( 'Enter hit count expression: ' ) })<cr>
nnoremap <leader>DB :<c-u>call vimspector#AddFunctionBreakpoint( expand( '<cexpr>' ) )<cr>
nnoremap <leader>do :<c-u>call vimspector#StepOver()<cr>
nnoremap <leader>di :<c-u>call vimspector#StepInto()<cr>
nnoremap <leader>du :<c-u>call vimspector#StepOut()<cr>
nnoremap <leader>cb :<c-u>call vimspector#ClearBreakpoints()<cr>
nnoremap <leader>rc :<c-u>call vimspector#RunToCursor()<cr>

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

"{{{ File explorer configuration
nnoremap <silent> <leader>n :CocCommand explorer --toggle --quit-on-open<cr>
nnoremap <silent> <leader><leader>n :CocCommand explorer --toggle<cr>
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
nnoremap <silent> <leader>bl <cmd>G blame<cr>
nnoremap <silent> <leader>gs <cmd>G<cr><cmd>res 15<cr>
nnoremap <silent> <leader>gd <cmd>G difftool<cr>
nnoremap <silent> <leader>gm <cmd>G mergetool<cr>

let g:signify_sign_change = '~'

" navigate chunks of current buffer
nmap [c <Plug>(coc-git-prevchunk)
nmap ]c <Plug>(coc-git-nextchunk)
" navigate conflicts of current buffer
nmap [n <Plug>(coc-git-prevconflict)
nmap ]n <Plug>(coc-git-nextconflict)
nnoremap <silent> <localleader>gl <cmd>CocList --normal --tab bcommits<cr>
nnoremap <silent> <leader><leader>gl <cmd>CocList --normal --tab commits<cr>
nnoremap <silent> <leader>gs <cmd>CocList --normal --no-quit gstatus<cr>
nnoremap <silent> <leader>gc :CocCommand git.chunkInfo<cr>
nnoremap <silent> <leader>gu :CocCommand git.chunkUndo<cr>
nnoremap <silent> <leader>gi :CocCommand git.chunkStage<cr>
"}}}

"{{{ Other plugins
lua require'colorizer'.setup()

let g:tmux_navigator_disable_when_zoomed = 1
let g:UltiSnipsExpandTrigger             = "<s-tab>"
let g:UltiSnipsSnippetDirectories=["UltiSnips", $HOME.'/.config/ultisnips']

nnoremap <leader>u :UndotreeShow<cr>
nnoremap <leader>m :MaximizerToggle<cr>
nnoremap <leader><leader>m <cmd>Marks<cr>
nnoremap <leader>dt :CocCommand docthis.documentThis<cr>

xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

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

lua << EOF
require'nvim-treesitter.configs'.setup {
  context_commentstring = {
    enable = true
  }
}
EOF
"}}}

"{{{ Vira
let g:vira_config_file_servers = $HOME . '/workspace/secrets/vira/vira_servers.json'
let g:vira_config_file_projects = $HOME . '/workspace/secrets/vira/vira_projects.json'

"}}}

