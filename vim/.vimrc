"{{{ Default mappings

let mapleader=" "
let maplocalleader="\\"

nmap n nzozt
nmap N Nzozt
nmap * *zozt
nmap # #zozt

nnoremap Y y$
vmap D y'>p

nnoremap <silent> <leader>cl <cmd>cclose<cr><cmd>lclose<cr><cmd>pclose<cr><cmd>echo ''<cr><cmd>nohlsearch<cr>
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
nnoremap <leader>bl <cmd>G blame<cr>
nnoremap <leader>gc :G commit -m ""<left>
nnoremap <leader>Gc :execute 'Dispatch! ' . $VIM_AGENT_COMMIT_COMMAND . ' "Create a commit for all changed files"'<cr>
nnoremap <leader>gl :Git log --decorate=full<cr>
vnoremap <leader>gl :GcLog!<cr>
nnoremap <leader>gL <cmd>0GcLog<cr>
nnoremap <leader>ga <cmd>G add -A<cr>
nnoremap <leader>hA <cmd>Gwrite<cr>
nnoremap <leader>hD <cmd>Gread<cr>
nnoremap <leader>gw <cmd>G commit -n -m "WIP"<cr>
nnoremap <leader>gpp <cmd>Dispatch! git push -u origin $(git rev-parse --abbrev-ref HEAD)<cr>
nnoremap <leader>gpf <cmd>Dispatch! git push -u origin $(git rev-parse --abbrev-ref HEAD) --force-with-lease<cr>
nnoremap <leader>gpt gpt <cmd>Dispatch! git push -u origin $(git rev-parse --abbrev-ref HEAD) --force-with-lease --follow-tags<cr>

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
nnoremap <leader>fh <cmd>FuzzyHelps<cr>

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
let env = environ()
if has_key(env, 'ANNGUYENWASD_PROFILE') && env['ANNGUYENWASD_PROFILE'] ==? "work"
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
    nnoremap <buffer> gd <Cmd>execute v:count .. 'LspGotoDefinition'<CR>
    nnoremap <buffer> <C-W>gd <Cmd>execute 'botright ' .. v:count .. 'LspGotoDefinition'<CR>
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
endif
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

let g:DirDiffExcludes = ".git,personal.*,.DS_Store,**/packer_compiled.lua,**/*.add,**/*.spl,*.png,*.jpg,*.jpeg,Session.vim,*/state.yml,plugin/*,spell/*,node_modules/*,*node_modules*,wezterm,karabiner,feh,arch,work.lua,env.zsh,.luarc.json,docs,lazy-lock.json,.nx/*,dist"
nnoremap <leader>u <cmd>UndotreeToggle<cr>
nnoremap <leader>tt <cmd>TransparentToggle<cr>

" Jump to the end of quickfix list after dispatch completes
augroup DispatchQuickfix
    autocmd!
    autocmd QuickFixCmdPost Make,Dispatch if len(getqflist()) > 0 | cwindow | clast | endif
augroup END
"}}}

"{{{ netrw
" Salad
let g:no_plugin_maps=1
"}}}

"{{{ Custom functions

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
       execute "vertical Start! yarn workspace " . packageName . " build"
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
    execute "Dispatch! npm home " . shellescape(package_name)

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
    execute "Dispatch! open https://github.com/" . shellescape(package_name)

    let @@ = saved_unnamed_register
endfunction
nnoremap <leader>gh :set opfunc=GithubHome<CR>g@
vnoremap <leader>gh :<C-U>call GithubHome(visualmode())<CR>

function! CopyPath(mode)
    " Find the git root directory
    let l:git_root = system('git rev-parse --show-toplevel 2>/dev/null')[:-2]
    let l:full_path = expand('%:p')
    let l:path = ''

    if a:mode == 'relative'
        if v:shell_error == 0 && !empty(l:git_root)
            " If in a git repo, get path relative to git root
            let l:path = substitute(l:full_path, l:git_root . '/', '', '')
        else
            " Fallback to current directory relative path
            let l:path = fnamemodify(expand("%"), ":~:.")
        endif
    elseif a:mode == 'absolute'
        " Get absolute path from root
        let l:path = l:full_path
    elseif a:mode == 'detailed'
        " Get absolute path with function name or line number
        let l:path = l:full_path
        let l:line_num = line('.')
        let l:func_name = ''

        " First, check if current line contains the word 'function'
        let l:current_line = getline('.')
        if l:current_line =~ '\cfunction'
            " Extract the word after 'function' (case insensitive)
            let l:func_name = matchstr(l:current_line, '\cfunction\S*\s\+\zs\w\+')
        endif

        " If current line doesn't have function, search backwards
        if empty(l:func_name)
            let l:func_line = search('\cfunction', 'bnW')
            if l:func_line > 0
                let l:func_text = getline(l:func_line)
                let l:func_name = matchstr(l:func_text, '\cfunction\S*\s\+\zs\w\+')
            endif
        endif

        " Add function name or line number
        if !empty(l:func_name)
            let l:path = l:path . ' at ' . l:func_name . '() function'
        else
            let l:path = l:path . ':' . l:line_num
        endif
    elseif a:mode == 'range'
        " Get absolute path with visual selection line range
        let l:path = l:full_path . ':' . line("'<") . '-' . line("'>")
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


nnoremap <leader>cp :call CopyPath('relative')<CR>
nnoremap <leader>Cp :call CopyPath('absolute')<CR>
nnoremap <leader>CP :call CopyPath('detailed')<CR>
vnoremap <leader>cp <Esc>:call CopyPath('range')<CR>

function! ConsoleLog()
    let l:word = expand('<cword>')
    let l:file_path = expand('%')
    let l:line_num = line('.')
    let l:ext = expand('%:e')

    if index(['js', 'ts', 'jsx', 'tsx'], l:ext) >= 0
        let l:log_line = 'console.log("[XXXDEBUG:' . l:line_num . '] at ' . l:file_path . ', ' . l:word . ':", ' . l:word . ');'
        call append(line('.'), l:log_line)
        normal! j
    endif
endfunction

nnoremap <leader>ll :call ConsoleLog()<CR>
nnoremap <leader>LL :g/xxxDEBUG/ d<CR>

function! DetectPackageManager()
    " Auto-detect package manager based on lock files
    if filereadable('pnpm-lock.yaml')
        return 'pnpm'
    elseif filereadable('yarn.lock')
        return 'yarn'
    elseif filereadable('bun.lockb')
        return 'bun'
    elseif filereadable('package-lock.json')
        return 'npm'
    else
        " No lock file found, check package.json packageManager field
        if filereadable('package.json')
            let l:package_json = readfile('package.json')
            let l:json_string = join(l:package_json, "\n")

            " Try to extract packageManager field
            let l:pm_match = matchstr(l:json_string, '"packageManager"\s*:\s*"\zs[^@"]*')

            if !empty(l:pm_match)
                if l:pm_match =~ 'pnpm'
                    return 'pnpm'
                elseif l:pm_match =~ 'yarn'
                    return 'yarn'
                elseif l:pm_match =~ 'npm'
                    return 'npm'
                elseif l:pm_match =~ 'bun'
                    return 'bun'
                endif
            endif
        endif

        " No lock file and no packageManager field found
        return ''
    endif
endfunction

function! YarnInfo(flag)
    let l:col = col('.')
    let l:line = getline('.')
    let l:start = l:col
    let l:end = l:col
    let l:quote = '"'

    " Try double quotes first
    while l:start > 1 && l:line[l:start-2] != '"'
        let l:start -= 1
    endwhile

    while l:end <= len(l:line) && l:line[l:end-1] != '"'
        let l:end += 1
    endwhile

    " If no double quotes found, try single quotes
    if !(l:start > 1 && l:end <= len(l:line) && l:line[l:start-2] == '"' && l:line[l:end-1] == '"')
        let l:start = l:col
        let l:end = l:col
        let l:quote = "'"

        while l:start > 1 && l:line[l:start-2] != "'"
            let l:start -= 1
        endwhile

        while l:end <= len(l:line) && l:line[l:end-1] != "'"
            let l:end += 1
        endwhile
    endif

    if l:start > 1 && l:end <= len(l:line) && l:line[l:start-2] == l:quote && l:line[l:end-1] == l:quote
        let l:package = l:line[l:start-1:l:end-2]
        let l:pm = DetectPackageManager()

        " Check if package manager was detected
        if empty(l:pm)
            echo "No package manager detected. Please ensure you have a lock file (yarn.lock, pnpm-lock.yaml, package-lock.json, bun.lockb) or packageManager field in package.json"
            return
        endif

        if a:flag == 'dist-tags'
            if l:pm == 'yarn'
                execute 'vertical Dispatch yarn info ' . shellescape(l:package) . ' dist-tags'
            elseif l:pm == 'pnpm'
                execute 'vertical Dispatch pnpm view ' . shellescape(l:package) . ' dist-tags'
            elseif l:pm == 'npm'
                execute 'vertical Dispatch npm view ' . shellescape(l:package) . ' dist-tags'
            elseif l:pm == 'bun'
                execute 'vertical Dispatch bun pm view ' . shellescape(l:package) . ' dist-tags'
            endif
        elseif a:flag == 'versions'
            if l:pm == 'yarn'
                execute 'vertical Dispatch yarn info ' . shellescape(l:package) . ' versions'
            elseif l:pm == 'pnpm'
                execute 'vertical Dispatch pnpm view ' . shellescape(l:package) . ' versions'
            elseif l:pm == 'npm'
                execute 'vertical Dispatch npm view ' . shellescape(l:package) . ' versions'
            elseif l:pm == 'bun'
                execute 'vertical Dispatch bun pm view ' . shellescape(l:package) . ' versions'
            endif
        elseif a:flag == 'why'
            if l:pm == 'yarn'
                execute 'vertical Dispatch yarn why ' . shellescape(l:package)
            elseif l:pm == 'pnpm'
                execute 'vertical Dispatch pnpm why ' . shellescape(l:package)
            elseif l:pm == 'npm'
                execute 'vertical Dispatch npm explain ' . shellescape(l:package)
            elseif l:pm == 'bun'
                execute 'vertical Dispatch bun pm ls ' . shellescape(l:package)
            endif
        elseif a:flag == 'list'
            if l:pm == 'yarn'
                execute 'vertical Dispatch yarn list --pattern ' . shellescape(l:package)
            elseif l:pm == 'pnpm'
                execute 'vertical Dispatch pnpm list ' . shellescape(l:package)
            elseif l:pm == 'npm'
                execute 'vertical Dispatch npm list ' . shellescape(l:package)
            elseif l:pm == 'bun'
                execute 'vertical Dispatch bun pm ls ' . shellescape(l:package)
            endif
        endif
    else
        echo "Cursor not inside quoted package name"
    endif
endfunction

nnoremap <leader>yid :call YarnInfo('dist-tags')<CR>
nnoremap <leader>yiv :call YarnInfo('versions')<CR>
nnoremap <leader>yy :call YarnInfo('why')<CR>
nnoremap <leader>yl :call YarnInfo('list')<CR>

" %bdelete:
" This deletes all buffers. The % range means "all buffers," and bdelete (or bd) deletes a buffer.
" edit #:
" After deleting all buffers, this command re-opens the previously active buffer. The # register refers to the alternate file, which is typically the last buffer you were editing.
" bdelete#:
" This deletes any "No Name" buffer that might have been created as a side effect of the previous commands.
command! BufOnly execute "%bd|e#|bd#"

fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun
command! TrimWhitespace call TrimWhitespace()

function! YarnTestFile()
    let l:file = expand('%')
    if empty(l:file)
        echo "No file to test"
        return
    endif
    cclose
    execute 'vertical Start!  yarn test -u --no-coverage ' . shellescape(l:file)
endfunction

function! YarnTestIt()
    let l:file = expand('%')
    if empty(l:file)
        echo "No file to test"
        return
    endif
    let l:current_line = line('.')
    let l:it_line = search('\s*it(', 'bnW')
    if l:it_line == 0
        echo "No it() function found"
        return
    endif
    let l:test_name = matchstr(getline(l:it_line), 'it(\s*["'']\zs[^"'']*\ze["'']')
    if empty(l:test_name)
        echo "Could not extract test name"
        return
    endif
    cclose
    execute 'vertical Start! yarn test -u --no-coverage ' . shellescape(l:file) . ' -t ' . shellescape(l:test_name)
endfunction

nnoremap <leader>gg :call YarnTestFile()<CR>
nnoremap <leader>GG :call YarnTestIt()<CR>

function! ZenMode()
  set statusline=%<%t\ %h%m%r
  only
  execute 'topleft ' .. (v:count ? v:count : '70') .. 'vnew'
  wincmd l
endfunction

nnoremap <leader>zz :call ZenMode()<CR>

function! OpenMarkdownBrowser()
    if &filetype != 'markdown'
        echo "Not a markdown file"
        return
    endif

    if executable('mdbrowse')
        execute 'Spawn! mdbrowse %'
    else
        echo "mdbrowse not found, installing..."
        execute 'Spawn! npm install md-browse -g'
    endif
endfunction

nnoremap <leader>md :call OpenMarkdownBrowser()<CR>
"}}}

"{{{ Custom mappings
let g:asyncrun_rootmarks = ['.svn', '.git', '.gitignore', 'yarn.lock']
nnoremap <leader>fl :set foldlevel=
" This one for jump into \" \" when do space rg
cnoremap <expr> "" getcmdpos() > 20 ? repeat('<Left>', 50) : '""'
nnoremap <leader>rg :Ggrep! -r -I -i --untracked -e "" -- :^**/dist/** :^/*.lock :^**/test/** :^*.test.* :^**/*.snap :^**/*.md<left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left>
nnoremap <leader>RG :Ggrep! -r -I -i --untracked -e "<c-r><c-w>" -- :^**/test/** :^*.test.* :^**/*.snap :^**/*.md
nnoremap D y'>p

" Open or switch to agent interactive terminal
" Reads $VIM_AGENT_INTERACTIVE_COMMAND from environment (set in agent.zsh)
function! OpenAgent()
    " First, close all finished terminal buffers
    call CloseFinishedBuffers()

    let l:agent_cmd = $VIM_AGENT_INTERACTIVE_COMMAND
    if empty(l:agent_cmd)
        echo "VIM_AGENT_INTERACTIVE_COMMAND not set. Source agent.zsh first."
        return
    endif

    " Look for existing agent terminal
    for l:buf in getbufinfo()
        if getbufvar(l:buf.bufnr, '&buftype') == 'terminal'
            let l:bufname = bufname(l:buf.bufnr)
            if l:bufname =~ l:agent_cmd
                " Found existing agent terminal, switch to it
                execute 'buffer ' . l:buf.bufnr
                return
            endif
        endif
    endfor
    " No existing agent terminal found, create new one
    " Strip leading ! from the buffer name pattern to get the actual command
    execute 'vertical terminal ' . substitute(l:agent_cmd, '^!', '', '')
endfunction

nnoremap <leader>cc :call OpenAgent()<CR>

" Close all buffers with [finished] tag
function! CloseFinishedBuffers()
    let l:finished_count = 0
    let l:buffers = getbufinfo()
    for l:buf in l:buffers
        " Check if buffer is a terminal and get its status
        if getbufvar(l:buf.bufnr, '&buftype') == 'terminal'
            let l:term_status = term_getstatus(l:buf.bufnr)
            " Check if terminal is finished (not running)
            if l:term_status =~ 'finished' || l:term_status =~ 'normal'
                " Check if the job is actually done
                let l:job = term_getjob(l:buf.bufnr)
                if job_status(l:job) == 'dead'
                    execute 'bdelete! ' . l:buf.bufnr
                    let l:finished_count += 1
                endif
            endif
        endif
    endfor
    if l:finished_count > 0
        echo 'Closed ' . l:finished_count . ' finished terminal buffer(s)'
    else
        echo 'No finished terminal buffers found'
    endif
endfunction

nnoremap <leader>bf :call CloseFinishedBuffers()<CR>

" Synced from mappings.lua:8 — Search for selected text in visual mode
vnoremap * y<cmd>let @/ = @"<cr><cmd>set hlsearch<cr>

" Synced from mappings.lua:23 — Create new file in same folder (vertical split)
nnoremap <leader>fv :vsp %:h/

" Synced from mappings.lua:24 — Create new file in same folder (horizontal split)
nnoremap <leader>fs :sp %:h/

" Synced from mappings.lua:25 — Edit file in current file's directory
nnoremap <leader>fe :e %:h/

" Synced from mappings.lua:124 — Set current window width to 120
nnoremap <leader>vm :vert res 120<cr>

"}}}

"{{{ Plugins Declaration
" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

call plug#begin()
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-scriptease'
Plug 'tpope/vim-speeddating'
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
Plug 'godlygeek/tabular'
Plug 'airblade/vim-rooter'
Plug 'will133/vim-dirdiff', { 'on': 'DirDiff' }
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
Plug 'christoomey/vim-tmux-navigator'
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
set smartcase
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
set nolist
set laststatus=2
set showmode
set lazyredraw
set nobackup
set nowritebackup
set regexpengine=2
set path+=**

color retrobox
" color quiet
" color nord
" color zaibatsu
" color morning
" hi SpecialKey ctermfg=66 guifg=#ffffff
" hi! link Folded NonText
" hi! link LineNr NonText
" hi! link Comment NonText
" hi NonText guifg=#030552
" hi SpecialKey guifg=#030552

packadd cfilter

function! FileEncoding()
     if strchars(&fileencoding) == 0
       return '[?enc]'
     else
       return '['.. &fileencoding ..']'
   endif
endfunction

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

set statusline=[%n]\ %<%F\ %h%m%r%=%(%l,%c%V%)\ %P\ %{FileEncoding()}\ %{EOLSymbol()}
"}}}
