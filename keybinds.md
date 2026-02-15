# Keybindings Reference

A comprehensive reference of all custom keybindings configured across Neovim, Vim, and Tmux in this dotfiles repository. Use this as a quick lookup when you forget a binding or want to discover available shortcuts. Each section includes a search input for filtering — useful when previewing this file in a markdown viewer.

> Last update: 15 Feb 2026

<style>
table thead th {
  position: sticky;
  top: 0;
  background: var(--color-canvas-default, #fff);
  z-index: 1;
}
</style>

## Table of Contents

- [Neovim](#neovim)
- [Vim](#vim)
- [Tmux](#tmux)


## Neovim

`<leader>` = Space, `<localleader>` = `\`
Modes: `n` = normal, `v` = visual, `i` = insert, `c` = command, `t` = terminal, `o` = operator-pending, `x` = visual+select, `s` = select

| lhs | rhs | key | desc | location |
|-----|-----|-----|------|----------|
| `n` | `nzt` | n | Next occurrence, cursor top | `nvim/.config/nvim/lua/mappings.lua:4` |
| `N` | `Nzt` | n | Prev occurrence, cursor top | `nvim/.config/nvim/lua/mappings.lua:5` |
| `*` | `*zt` | n | Next whole word, cursor top | `nvim/.config/nvim/lua/mappings.lua:6` |
| `#` | `#zt` | n | Prev whole word, cursor top | `nvim/.config/nvim/lua/mappings.lua:7` |
| `*` | `y<cmd>let @/ = @"<cr><cmd>set hlsearch<cr>` | v | Search with selected text | `nvim/.config/nvim/lua/mappings.lua:8` |
| `<leader>cl` | close qf/loclist/preview/noh/clear refs | n | Close quickfix/location list windows | `nvim/.config/nvim/lua/mappings.lua:9` |
| `<leader>p` | `"_dP` | v | Paste without replacing register | `nvim/.config/nvim/lua/mappings.lua:12` |
| `D` | `y'>p` | v | Duplicate selection | `nvim/.config/nvim/lua/mappings.lua:13` |
| `<C-w><C-e>` | `<C-w>=` | n | Make windows equally sized | `nvim/.config/nvim/lua/mappings.lua:14` |
| `<C-h>` | `<left>` | c, i | Go left (cmd/insert mode) | `nvim/.config/nvim/lua/mappings.lua:17` |
| `<C-j>` | `<down>` | c, i | Go down (cmd/insert mode) | `nvim/.config/nvim/lua/mappings.lua:18` |
| `<C-k>` | `<up>` | c, i | Go up (cmd/insert mode) | `nvim/.config/nvim/lua/mappings.lua:19` |
| `<C-l>` | `<right>` | c, i | Go right (cmd/insert mode) | `nvim/.config/nvim/lua/mappings.lua:20` |
| `<leader>fv` | `:vsp %:h/` | n | New file in same folder (vsplit) | `nvim/.config/nvim/lua/mappings.lua:23` |
| `<leader>fs` | `:sp %:h/` | n | New file in same folder (split) | `nvim/.config/nvim/lua/mappings.lua:24` |
| `<leader>fe` | `:e %:h/` | n | Edit file in current folder | `nvim/.config/nvim/lua/mappings.lua:25` |
| `<C-w>v` | `<C-w>v <C-w>l` | n | Vertical split and move right | `nvim/.config/nvim/lua/mappings.lua:28` |
| `<C-w><C-v>` | `<C-w>v <C-w>l` | n | Vertical split and move right | `nvim/.config/nvim/lua/mappings.lua:29` |
| `<C-w>s` | `<C-w>s <C-w>j` | n | Horizontal split and move down | `nvim/.config/nvim/lua/mappings.lua:30` |
| `<C-w><C-s>` | `<C-w>s <C-w>j` | n | Horizontal split and move down | `nvim/.config/nvim/lua/mappings.lua:31` |
| `<C-w><C-w>` | `<C-w>q` | n | Close current window/split | `nvim/.config/nvim/lua/mappings.lua:32` |
| `<leader>tm` | `:!tmux neww ` | n | Run command in new tmux window | `nvim/.config/nvim/lua/mappings.lua:34` |
| `<leader>tM` | `:!tmux splitw ` | n | Run command in new tmux pane | `nvim/.config/nvim/lua/mappings.lua:35` |
| `<leader>vt` | `:vsplit term://` | n | Open terminal (vsplit) | `nvim/.config/nvim/lua/mappings.lua:38` |
| `<leader>st` | `:split term://` | n | Open terminal (split) | `nvim/.config/nvim/lua/mappings.lua:44` |
| `<leader>vT` | `:vsplit term://$SHELL<cr>` | n | Open shell terminal (vsplit) | `nvim/.config/nvim/lua/mappings.lua:51` |
| `<leader>sT` | `:split term://$SHELL<cr>` | n | Open shell terminal (split) | `nvim/.config/nvim/lua/mappings.lua:58` |
| `<leader>bd` | (fn) build nearest package | n | Find nearest package.json and build | `nvim/.config/nvim/lua/mappings.lua:66` |
| `<leader>bp` | (fn) open nearest package.json | n | Open nearest package.json | `nvim/.config/nvim/lua/mappings.lua:88` |
| `<leader>sr` | script-runner picker | n | Run script from nearest package.json | `nvim/.config/nvim/lua/mappings.lua:95` |
| `<leader>cp` | copy relative path | n | Copy relative path | `nvim/.config/nvim/lua/mappings.lua:102` |
| `<leader>cP` | copy absolute path | n | Copy absolute path | `nvim/.config/nvim/lua/mappings.lua:105` |
| `<leader>CP` | copy detailed path | n, v | Copy path with function name/line range | `nvim/.config/nvim/lua/mappings.lua:109` |
| `<leader>yz` | open yazi | n | Open yazi file manager | `nvim/.config/nvim/lua/mappings.lua:120` |
| `%%` | expand current file's dir | c | Current file's directory path | `nvim/.config/nvim/lua/mappings.lua:123` |
| `<leader>e` | `<cmd>b #<cr>` | n | Swap to alternate buffer | `nvim/.config/nvim/lua/mappings.lua:131` |
| `<leader>fl` | `:set foldlevel=` | n | Set custom fold level | `nvim/.config/nvim/lua/mappings.lua:132` |
| `<leader>vm` | `:vert res 120<cr>` | n | Set window width to 120 | `nvim/.config/nvim/lua/mappings.lua:133` |
| `<Esc><Esc>` | `<C-\><C-n>` | t | Exit terminal mode | `nvim/.config/nvim/lua/mappings.lua:138` |
| `<leader>ll` | (fn) insert console.log | n | Insert console.log debug line | `nvim/.config/nvim/lua/mappings.lua:141` |
| `<leader>LL` | `<cmd>g/xxxDEBUG/ d<cr>` | n | Remove all XXXDEBUG lines | `nvim/.config/nvim/lua/mappings.lua:154` |
| `<leader>zz` | (fn) zen mode | n | Toggle zen mode | `nvim/.config/nvim/lua/mappings.lua:157` |
| `<leader>md` | (fn) open markdown in browser | n | Open markdown in browser | `nvim/.config/nvim/lua/mappings.lua:166` |
| `<leader>Gc` | (fn) agent commit via Dispatch | n | Agent commit via Dispatch | `nvim/.config/nvim/lua/mappings.lua:179` |
| `<leader>cc` | (fn) open/switch to agent terminal | n | Open or switch to agent terminal | `nvim/.config/nvim/lua/mappings.lua:189` |
| `<leader>bf` | (fn) close finished terminal buffers | n | Close all finished terminal buffers | `nvim/.config/nvim/lua/mappings.lua:223` |
| `<leader>gg` | (fn) run test for file | n | Run yarn test for current file | `nvim/.config/nvim/lua/mappings.lua:242` |
| `<leader>GG` | (fn) run test for nearest it() | n | Run yarn test for nearest it() block | `nvim/.config/nvim/lua/mappings.lua:253` |
| `<C-f>` | telescope find files in netrw dir | n | netrw: Find files under directory | `nvim/.config/nvim/lua/autocmd.lua:14` |
| `<C-g>` | telescope live grep in netrw dir | n | netrw: Live grep under directory | `nvim/.config/nvim/lua/autocmd.lua:20` |
| `<leader>o` | telescope find files | n | telescope: Find files | `nvim/.config/nvim/lua/plugins/telescope.lua:57` |
| `<leader>O` | telescope find files (include ignored) | n | telescope: Find files with ignored | `nvim/.config/nvim/lua/plugins/telescope.lua:62` |
| `<leader>i` | telescope buffers | n | telescope: Show opened buffers | `nvim/.config/nvim/lua/plugins/telescope.lua:69` |
| `<leader>/` | telescope current buffer fuzzy find | n | telescope: Current buffer fuzzy find | `nvim/.config/nvim/lua/plugins/telescope.lua:80` |
| `<leader>fc` | theme chooser | n | telescope: Theme chooser | `nvim/.config/nvim/lua/plugins/telescope.lua:85` |
| `<leader>fh` | telescope help tags | n | telescope: Help tags | `nvim/.config/nvim/lua/plugins/telescope.lua:91` |
| `<leader>ch` | telescope command history | n | telescope: Command history | `nvim/.config/nvim/lua/plugins/telescope.lua:96` |
| `<leader>sh` | telescope search history | n | telescope: Search history | `nvim/.config/nvim/lua/plugins/telescope.lua:101` |
| `<leader><leader>fc` | telescope commands | n | telescope: Commands | `nvim/.config/nvim/lua/plugins/telescope.lua:106` |
| `<leader>km` | telescope keymaps | n | telescope: Keymaps | `nvim/.config/nvim/lua/plugins/telescope.lua:110` |
| `<leader>tr` | telescope resume | n | telescope: Resume last picker | `nvim/.config/nvim/lua/plugins/telescope.lua:112` |
| `<leader>ds` | telescope lsp document symbols | n | telescope: LSP document symbols | `nvim/.config/nvim/lua/plugins/telescope.lua:119` |
| `<leader>ws` | telescope lsp workspace symbols | n | telescope: LSP workspace symbols | `nvim/.config/nvim/lua/plugins/telescope.lua:126` |
| `<leader>qf` | `:Telescope quickfix<cr>` | n | telescope: From quickfix list | `nvim/.config/nvim/lua/plugins/telescope.lua:132` |
| `<leader>qh` | `:Telescope quickfixhistory<cr>` | n | telescope: Quickfix history | `nvim/.config/nvim/lua/plugins/telescope.lua:138` |
| `<leader>RG` | `:Telescope grep_string<cr>` | n | telescope: Grep current word | `nvim/.config/nvim/lua/plugins/telescope.lua:144` |
| `<leader>ss` | `:Telescope spell_suggest<cr>` | n | telescope: Spell suggest | `nvim/.config/nvim/lua/plugins/telescope.lua:150` |
| `<leader>rg` | egrepify live grep | n | telescope: Live grep (egrepify) | `nvim/.config/nvim/lua/plugins/telescope.lua:213` |
| `<C-e>` | send selected to qflist | i, n (telescope) | telescope: Send to quickfix | `nvim/.config/nvim/lua/plugins/telescope.lua:41` |
| `<C-s>` | open horizontal split | i, n (telescope) | telescope: Open in split | `nvim/.config/nvim/lua/plugins/telescope.lua:42` |
| `<C-\>` | toggle preview | i, n (telescope) | telescope: Toggle preview | `nvim/.config/nvim/lua/plugins/telescope.lua:43` |
| `<C-d>` | delete buffer | n (telescope) | telescope: Delete buffer | `nvim/.config/nvim/lua/plugins/telescope.lua:48` |
| `<C-z>` | toggle prefixes | i (egrepify) | egrepify: Toggle prefixes | `nvim/.config/nvim/lua/plugins/telescope.lua:199` |
| `<C-x>` | toggle AND | i (egrepify) | egrepify: Toggle AND matching | `nvim/.config/nvim/lua/plugins/telescope.lua:201` |
| `<C-r>` | toggle permutations | i (egrepify) | egrepify: Toggle permutations | `nvim/.config/nvim/lua/plugins/telescope.lua:203` |
| `<leader>gf` | `diffget //2` | n | git: Select left (merge) | `nvim/.config/nvim/lua/plugins/git.lua:12` |
| `<leader>gj` | `diffget //3` | n | git: Select right (merge) | `nvim/.config/nvim/lua/plugins/git.lua:17` |
| `<leader>gl` | `:Git log --decorate=full<cr>` | n | git: Show log | `nvim/.config/nvim/lua/plugins/git.lua:20` |
| `<leader>gl` | `:Gclog!<cr>` | v | git: Show log (visual selection) | `nvim/.config/nvim/lua/plugins/git.lua:21` |
| `<leader>gL` | `:0GcLog<cr>` | n, v | git: Show log (current file) | `nvim/.config/nvim/lua/plugins/git.lua:22` |
| `<leader>ge` | `<cmd>Gedit<cr>` | n | git: Gedit | `nvim/.config/nvim/lua/plugins/git.lua:24` |
| `<leader>gs` | `<cmd>G<cr>` | n | git: Open fugitive status | `nvim/.config/nvim/lua/plugins/git.lua:29` |
| `<leader><leader>gs` | `<cmd>G difftool<cr>` | n | git: Show all changes in qflist | `nvim/.config/nvim/lua/plugins/git.lua:34` |
| `<leader><leader>bl` | `<cmd>G blame<cr>` | n | git: Show all lines blame | `nvim/.config/nvim/lua/plugins/git.lua:38` |
| `<leader>gc` | (fn) split terminal git commit | n | git: Commit via terminal | `nvim/.config/nvim/lua/plugins/git.lua:40` |
| `<leader><leader>gc` | `:G commit -m ""<left>` | n | git: Commit with message | `nvim/.config/nvim/lua/plugins/git.lua:47` |
| `<leader>ga` | `<cmd>G add -A<cr>` | n | git: Add all files | `nvim/.config/nvim/lua/plugins/git.lua:52` |
| `<leader>gw` | add all + WIP commit | n | git: Add new WIP commit | `nvim/.config/nvim/lua/plugins/git.lua:54` |
| `<leader>GW` | add all + WIP + force push | n | git: WIP commit and push | `nvim/.config/nvim/lua/plugins/git.lua:59` |
| `<leader>gpp` | push to origin | n | git: Push to origin | `nvim/.config/nvim/lua/plugins/git.lua:69` |
| `<leader>gpf` | push force-with-lease | n | git: Push force-with-lease | `nvim/.config/nvim/lua/plugins/git.lua:75` |
| `gpt` | push with tags | n | git: Push with follow-tags | `nvim/.config/nvim/lua/plugins/git.lua:81` |
| `]c` | (fn) next hunk | n | git: Next change | `nvim/.config/nvim/lua/plugins/git.lua:99` |
| `[c` | (fn) prev hunk | n | git: Prev change | `nvim/.config/nvim/lua/plugins/git.lua:109` |
| `<leader>ha` | `:Gitsigns stage_hunk<CR>` | n, v | git: Stage hunk | `nvim/.config/nvim/lua/plugins/git.lua:120` |
| `<leader>hd` | `:Gitsigns reset_hunk<CR>` | n, v | git: Reset hunk | `nvim/.config/nvim/lua/plugins/git.lua:127` |
| `<leader>hA` | `gs.stage_buffer` | n | git: Stage entire buffer | `nvim/.config/nvim/lua/plugins/git.lua:134` |
| `<leader>hu` | `gs.undo_stage_hunk` | n | git: Undo stage hunk | `nvim/.config/nvim/lua/plugins/git.lua:141` |
| `<leader>hD` | `gs.reset_buffer` | n | git: Reset buffer | `nvim/.config/nvim/lua/plugins/git.lua:148` |
| `<leader>hc` | `gs.preview_hunk` | n | git: Preview hunk | `nvim/.config/nvim/lua/plugins/git.lua:154` |
| `<leader>bl` | `gs.blame_line({full=true})` | n | git: Blame line | `nvim/.config/nvim/lua/plugins/git.lua:161` |
| `<leader>tb` | `gs.toggle_current_line_blame` | n | git: Toggle line blame | `nvim/.config/nvim/lua/plugins/git.lua:165` |
| `<leader>td` | `gs.toggle_deleted` | n | git: Toggle deleted | `nvim/.config/nvim/lua/plugins/git.lua:171` |
| `ih` | `Gitsigns select_hunk` | o, x | git: Select hunk (textobject) | `nvim/.config/nvim/lua/plugins/git.lua:178` |
| `<leader>gy` | `:GBrowse<cr>` | n, v | git: Open file in browser | `nvim/.config/nvim/lua/plugins/git.lua:192` |
| `<localleader>bb` | `dap.toggle_breakpoint()` | n | debug: Toggle breakpoint | `nvim/.config/nvim/lua/plugins/dap.lua:9` |
| `<localleader>bc` | `dap.set_breakpoint(condition)` | n | debug: Conditional breakpoint | `nvim/.config/nvim/lua/plugins/dap.lua:10` |
| `<localleader>bl` | `dap.set_breakpoint(nil, nil, log_msg)` | n | debug: Log point message | `nvim/.config/nvim/lua/plugins/dap.lua:11` |
| `<localleader>BB` | `dap.list_breakpoints()` | n | debug: List breakpoints | `nvim/.config/nvim/lua/plugins/dap.lua:12` |
| `` `BB `` | `dap.clear_breakpoints()` | n | debug: Clear all breakpoints | `nvim/.config/nvim/lua/plugins/dap.lua:13` |
| `<localleader>c` | `dap.continue()` | n | debug: Continue/start | `nvim/.config/nvim/lua/plugins/dap.lua:14` |
| `` `o `` | `dap.step_over()` | n | debug: Step over | `nvim/.config/nvim/lua/plugins/dap.lua:15` |
| `` `hk `` | `dap.ui.widgets.hover()` | n, v | debug: Hover float | `nvim/.config/nvim/lua/plugins/dap.lua:16` |
| `` `hh `` | `dap.ui.widgets.preview()` | n, v | debug: Preview window | `nvim/.config/nvim/lua/plugins/dap.lua:17` |
| `` `i `` | `dap.step_into()` | n | debug: Step into | `nvim/.config/nvim/lua/plugins/dap.lua:18` |
| `` `u `` | `dap.step_out()` | n | debug: Step out | `nvim/.config/nvim/lua/plugins/dap.lua:19` |
| `` `j `` | `dap.down()` | n | debug: Down in stacktrace | `nvim/.config/nvim/lua/plugins/dap.lua:20` |
| `` `k `` | `dap.up()` | n | debug: Up in stacktrace | `nvim/.config/nvim/lua/plugins/dap.lua:21` |
| `<localleader>dt` | `dap.terminate({all=true})` | n | debug: Terminate | `nvim/.config/nvim/lua/plugins/dap.lua:22` |
| `<localleader>dr` | `dap.repl.toggle()` | n | debug: Toggle REPL | `nvim/.config/nvim/lua/plugins/dap.lua:23` |
| `<localleader>dc` | `dap.run_to_cursor()` | n | debug: Run to cursor | `nvim/.config/nvim/lua/plugins/dap.lua:24` |
| `<localleader>ds` | (fn) scopes sidebar | n | debug: Widget scopes | `nvim/.config/nvim/lua/plugins/dap.lua:25` |
| `<localleader>df` | (fn) frames sidebar | n | debug: Widget frames | `nvim/.config/nvim/lua/plugins/dap.lua:26` |
| `<leader>n` | `<cmd>NvimTreeToggle<cr>` | n | nvim-tree: Toggle | `nvim/.config/nvim/lua/plugins/explorer.lua:12` |
| `l` | `api.node.open.edit` | n (nvim-tree) | nvim-tree: Open | `nvim/.config/nvim/lua/plugins/explorer.lua:23` |
| `<C-y>` | open current dir in yazi | n (nvim-tree) | nvim-tree: Open in yazi | `nvim/.config/nvim/lua/plugins/explorer.lua:29` |
| `h` | `api.node.navigate.parent_close` | n (nvim-tree) | nvim-tree: Close directory | `nvim/.config/nvim/lua/plugins/explorer.lua:42` |
| `H` | `api.tree.collapse_all` | n (nvim-tree) | nvim-tree: Collapse all | `nvim/.config/nvim/lua/plugins/explorer.lua:57` |
| `<C-f>` | telescope find files | n (nvim-tree) | nvim-tree: Find files | `nvim/.config/nvim/lua/plugins/explorer.lua:62` |
| `<C-g>` | telescope live grep | n (nvim-tree) | nvim-tree: Live grep | `nvim/.config/nvim/lua/plugins/explorer.lua:69` |
| `<Esc>` | `api.tree.close` | n (nvim-tree) | nvim-tree: Close | `nvim/.config/nvim/lua/plugins/explorer.lua:77` |
| `ma` | `harpoon:list():add()` | n | harpoon: Add file | `nvim/.config/nvim/lua/plugins/harpoon.lua:11` |
| `mq` | `harpoon.ui:toggle_quick_menu` | n | harpoon: Show list | `nvim/.config/nvim/lua/plugins/harpoon.lua:12` |
| `'1` - `'9` | `harpoon:list():select(N)` | n | harpoon: Navigate to file #N | `nvim/.config/nvim/lua/plugins/harpoon.lua:14-22` |
| `<C-v>` | open in vsplit | n (harpoon) | harpoon: Open in vsplit | `nvim/.config/nvim/lua/plugins/harpoon.lua:26` |
| `<C-s>` | open in split | n (harpoon) | harpoon: Open in split | `nvim/.config/nvim/lua/plugins/harpoon.lua:30` |
| `<C-t>` | open in new tab | n (harpoon) | harpoon: Open in tab | `nvim/.config/nvim/lua/plugins/harpoon.lua:34` |
| `<leader>bo` | `:BufOnly<CR>` | n | Close all other buffers | `nvim/.config/nvim/lua/plugins/buffer.lua:32` |
| `<leader>mm` | `:MaximizerToggle<cr>` | n | Toggle maximizer | `nvim/.config/nvim/lua/plugins/misc.lua:8` |
| `<leader>u` | `:UndotreeShow<cr>` | n | Toggle Undotree | `nvim/.config/nvim/lua/plugins/misc.lua:22` |
| `<leader>tc` | `<cmd>ColorizerToggle<cr>` | n | Toggle colorizer | `nvim/.config/nvim/lua/plugins/misc.lua:39` |
| `gst` | `treesj.toggle()` | n | treesj: Toggle join/split | `nvim/.config/nvim/lua/plugins/misc.lua:49` |
| `gss` | `treesj.split()` | n | treesj: Split lines | `nvim/.config/nvim/lua/plugins/misc.lua:56` |
| `gsj` | `treesj.join()` | n | treesj: Join lines | `nvim/.config/nvim/lua/plugins/misc.lua:63` |
| `<leader>gh` | `<cmd>URLOpenUnderCursor<cr>` | n | Open URL under cursor | `nvim/.config/nvim/lua/plugins/misc.lua:91` |
| `<leader>Rg` | grep string with motion (yop) | n, v | Telescope: Grep with motion | `nvim/.config/nvim/lua/plugins/misc.lua:100` |
| `<leader>ho` | npm home with motion (yop) | n, v | Open npm home page | `nvim/.config/nvim/lua/plugins/misc.lua:104` |
| `<leader>fm` | `conform.format()` | n, v | Format file/range | `nvim/.config/nvim/lua/plugins/formatting.lua:22` |
| `<leader>LI` | `lint.try_lint()` | n | Trigger linting | `nvim/.config/nvim/lua/plugins/linting.lua:14` |
| `<leader>tt` | `<cmd>TransparentToggle<cr>` | n | Toggle transparent | `nvim/.config/nvim/lua/plugins/transparent.lua:20` |
| `g?p` | debugprint below | n | debugprint: Print debug below | `nvim/.config/nvim/lua/plugins/debugprint.lua:33` |
| `g?P` | debugprint above | n | debugprint: Print debug above | `nvim/.config/nvim/lua/plugins/debugprint.lua:34` |
| `g?v` | variable debug below | n | debugprint: Variable debug below | `nvim/.config/nvim/lua/plugins/debugprint.lua:37` |
| `g?V` | variable debug above | n | debugprint: Variable debug above | `nvim/.config/nvim/lua/plugins/debugprint.lua:38` |
| `g?d` | delete all debug prints | n | debugprint: Remove all debug lines | `nvim/.config/nvim/lua/plugins/debugprint.lua:40` |
| `<leader>vv` | (fn) toggle diagram mode | n | diagram: Toggle diagram mode | `nvim/.config/nvim/lua/plugins/diagram.lua:5` |
| `J/K/L/H` | draw line (diagram mode) | n (diagram) | diagram: Draw down/up/right/left | `nvim/.config/nvim/lua/plugins/diagram.lua:14-29` |
| `f` | `:VBox<CR>` | v (diagram) | diagram: Draw box | `nvim/.config/nvim/lua/plugins/diagram.lua:34` |
| `<leader>rn` | `vim.lsp.buf.rename` | n | lsp: Rename | `nvim/.config/nvim/lua/utils/lsp.lua:43` |
| `gd` | `vim.lsp.buf.definition` | n | lsp: Go to definition | `nvim/.config/nvim/lua/utils/lsp.lua:44` |
| `gD` | `vim.lsp.buf.declaration` | n | lsp: Go to declaration | `nvim/.config/nvim/lua/utils/lsp.lua:45` |
| `<leader>ca` | `vim.lsp.buf.code_action` | n, v | lsp: Code action | `nvim/.config/nvim/lua/utils/lsp.lua:47` |
| `<leader>CA` | `LspTypescriptSourceAction` | n, v | lsp: TypeScript source action | `nvim/.config/nvim/lua/utils/lsp.lua:48` |
| `<leader>hl` | `vim.lsp.buf.document_highlight` | n, v | lsp: Highlight references | `nvim/.config/nvim/lua/utils/lsp.lua:49` |
| `<leader>ld` | `vim.diagnostic.open_float` | n | lsp: Show diagnostics | `nvim/.config/nvim/lua/utils/lsp.lua:19` |
| `<leader>dw` | (fn) workspace diagnostics in qflist | n | lsp: Workspace diagnostics | `nvim/.config/nvim/lua/utils/lsp.lua:21` |
| `<leader>da` | (fn) document diagnostics in qflist | n | lsp: Document diagnostics | `nvim/.config/nvim/lua/utils/lsp.lua:26` |
| `<leader>dt` | (fn) toggle diagnostics | n | lsp: Toggle diagnostics | `nvim/.config/nvim/lua/utils/lsp.lua:33` |
| `<leader>ts` | `material.functions.toggle_style` | n | Toggle material theme style | `nvim/.config/nvim/lua/themes/material.lua:4` |
| `<Tab>` | select next item | i (cmp) | cmp: Next item | `nvim/.config/nvim/lua/plugins/cmp.lua:18` |
| `<C-n>` | select next item | i (cmp) | cmp: Next item | `nvim/.config/nvim/lua/plugins/cmp.lua:25` |
| `<C-p>` | select prev item | i (cmp) | cmp: Prev item | `nvim/.config/nvim/lua/plugins/cmp.lua:32` |
| `<C-d>` | scroll docs up | i (cmp) | cmp: Scroll docs up | `nvim/.config/nvim/lua/plugins/cmp.lua:39` |
| `<C-f>` | scroll docs down | i (cmp) | cmp: Scroll docs down | `nvim/.config/nvim/lua/plugins/cmp.lua:40` |
| `<C-y>` | trigger completion | i (cmp) | cmp: Trigger completion | `nvim/.config/nvim/lua/plugins/cmp.lua:41` |
| `<CR>` | confirm selection | i (cmp) | cmp: Confirm | `nvim/.config/nvim/lua/plugins/cmp.lua:42` |
| `<C-a>` | abort | i (cmp) | cmp: Abort | `nvim/.config/nvim/lua/plugins/cmp.lua:43` |
| `<C-j>` | expand snippet | i, s | snippy: Expand | `nvim/.config/nvim/lua/plugins/cmp.lua:78` |
| `<C-l>` | next placeholder | i, s | snippy: Next | `nvim/.config/nvim/lua/plugins/cmp.lua:79` |
| `<C-h>` | prev placeholder | i, s | snippy: Previous | `nvim/.config/nvim/lua/plugins/cmp.lua:80` |
| `<leader>x` | cut text | n, x | snippy: Cut text | `nvim/.config/nvim/lua/plugins/cmp.lua:83` |

---

## Vim

`<leader>` = Space, `<localleader>` = `\`
Modes: `n` = normal, `v` = visual, `i` = insert, `c` = command, `t` = terminal, `o` = operator-pending, `x` = visual+select, `s` = select


| lhs | rhs | key | desc | location |
|-----|-----|-----|------|----------|
| `n` | `nzozt` | n | Next occurrence, center and top | `vim/.vimrc:6` |
| `N` | `Nzozt` | n | Prev occurrence, center and top | `vim/.vimrc:7` |
| `*` | `*zozt` | n | Next whole word, center and top | `vim/.vimrc:8` |
| `#` | `#zozt` | n | Prev whole word, center and top | `vim/.vimrc:9` |
| `Y` | `y$` | n | Yank to end of line | `vim/.vimrc:11` |
| `D` | `y'>p` | v | Duplicate selection | `vim/.vimrc:12` |
| `<leader>cl` | close qf/loclist/preview/noh | n | Close quickfix/location/preview | `vim/.vimrc:14` |
| `<leader><leader>r` | `:so ~/.vimrc<cr>` | n | Source vimrc | `vim/.vimrc:15` |
| `<leader><leader>R` | `:so ~/.vimrc` + `:PlugInstall` | n | Source vimrc and install plugins | `vim/.vimrc:16` |
| `<leader>p` | `"_dP` | v | Paste without replacing register | `vim/.vimrc:17` |
| `<C-w><C-e>` | `<C-w>=` | n | Equalize window sizes | `vim/.vimrc:19` |
| `<C-h>` | `<left>` | c, i | Go left | `vim/.vimrc:21-26` |
| `<C-j>` | `<down>` | c, i | Go down | `vim/.vimrc:22-27` |
| `<C-k>` | `<up>` | c, i | Go up | `vim/.vimrc:23-28` |
| `<C-l>` | `<right>` | c, i | Go right | `vim/.vimrc:24-29` |
| `<leader>e` | `<cmd>b #<cr>` | n | Switch to alternate buffer | `vim/.vimrc:31` |
| `%%` | expand current file's dir | c | Current file's directory path | `vim/.vimrc:33` |
| `<C-w>v` | `<C-w>v <C-w>l` | n | Vsplit and move right | `vim/.vimrc:35` |
| `<C-w><C-v>` | `<C-w>v <C-w>l` | n | Vsplit and move right | `vim/.vimrc:36` |
| `<C-w>s` | `<C-w>s <C-w>j` | n | Split and move down | `vim/.vimrc:37` |
| `<C-w><C-s>` | `<C-w>s <C-w>j` | n | Split and move down | `vim/.vimrc:38` |
| `<C-w><C-w>` | `<C-w>q` | n | Close window | `vim/.vimrc:39` |
| `<C-h>` | `<C-w>h` | n | Navigate to left pane | `vim/.vimrc:41` |
| `<C-j>` | `<C-w>j` | n | Navigate to bottom pane | `vim/.vimrc:42` |
| `<C-k>` | `<C-w>k` | n | Navigate to top pane | `vim/.vimrc:43` |
| `<C-l>` | `<C-w>l` | n | Navigate to right pane | `vim/.vimrc:44` |
| `<Esc><Esc>` | `<C-\><C-n>` | t | Exit terminal mode | `vim/.vimrc:47` |
| `<leader>gf` | `diffget //2` | n | git: Select left (merge) | `vim/.vimrc:71` |
| `<leader>gj` | `diffget //3` | n | git: Select right (merge) | `vim/.vimrc:72` |
| `<leader>Gs` | `:G difftool --name-status<cr>` | n | git: Difftool name status | `vim/.vimrc:73` |
| `<leader>gs` | `<cmd>G<cr>` | n | git: Fugitive status | `vim/.vimrc:74` |
| `<leader><leader>gs` | `<cmd>G difftool<cr>` | n | git: Difftool | `vim/.vimrc:75` |
| `<leader>bl` | `<cmd>G blame<cr>` | n | git: Blame | `vim/.vimrc:76` |
| `<leader>gc` | `:G commit -m ""<left>` | n | git: Commit with message | `vim/.vimrc:77` |
| `<leader>Gc` | agent commit via Dispatch | n | git: Agent commit | `vim/.vimrc:78` |
| `<leader>gl` | `:Git log --decorate=full<cr>` | n | git: Show log | `vim/.vimrc:79` |
| `<leader>gl` | `:GcLog!<cr>` | v | git: Show log (visual) | `vim/.vimrc:80` |
| `<leader>gL` | `<cmd>0GcLog<cr>` | n | git: Log current file | `vim/.vimrc:81` |
| `<leader>ga` | `<cmd>G add -A<cr>` | n | git: Add all | `vim/.vimrc:82` |
| `<leader>hA` | `<cmd>Gwrite<cr>` | n | git: Stage file | `vim/.vimrc:83` |
| `<leader>hD` | `<cmd>Gread<cr>` | n | git: Reset file | `vim/.vimrc:84` |
| `<leader>gw` | `G commit -n -m "WIP"` | n | git: WIP commit | `vim/.vimrc:85` |
| `<leader>gpp` | push to origin | n | git: Push | `vim/.vimrc:86` |
| `<leader>gpf` | push force-with-lease | n | git: Push force | `vim/.vimrc:87` |
| `<leader>gy` | `:GBrowse<cr>` | n, v | git: Open in browser | `vim/.vimrc:90-91` |
| `<leader>hc` | `GitGutterPreviewHunk` | n | git: Preview hunk | `vim/.vimrc:95` |
| `<leader>ha` | `GitGutterStageHunk` | n | git: Stage hunk | `vim/.vimrc:96` |
| `<leader>hd` | `GitGutterUndoHunk` | n | git: Undo hunk | `vim/.vimrc:97` |
| `[c` | `GitGutterPrevHunk` | n | git: Prev hunk | `vim/.vimrc:98` |
| `]c` | `GitGutterNextHunk` | n | git: Next hunk | `vim/.vimrc:99` |
| `ih` / `ah` | GitGutter textobjects | o, x | git: Hunk textobjects | `vim/.vimrc:100-103` |
| `<leader>fc` | `:FuzzyColors<cr>` | n | fuzzy: Colors | `vim/.vimrc:113` |
| `<leader>fh` | `:FuzzyHelps<cr>` | n | fuzzy: Help tags | `vim/.vimrc:114` |
| `<leader>o` | CtrlP (find files) | n | CtrlP: Find files | `vim/.vimrc:120` |
| `<leader>i` | `:CtrlPBuffer<cr>` | n | CtrlP: Buffer list | `vim/.vimrc:164` |
| `<leader>/` | `:CtrlPLine<cr>` | n | CtrlP: Line search | `vim/.vimrc:165` |
| `<leader>tr` | `:CtrlPLastMode<cr>` | n | CtrlP: Resume last mode | `vim/.vimrc:166` |
| `<leader>ds` | `:CtrlPFunky<cr>` | n | CtrlP: Document symbols | `vim/.vimrc:167` |
| `<leader>DS` | CtrlPFunky with word under cursor | n | CtrlP: Symbol under cursor | `vim/.vimrc:168` |
| `<leader>sf` | (fn) switch between CtrlP/Fuzzy | n | Switch file finder | `vim/.vimrc:183` |
| `<leader>ca` | `LspCodeAction` | n | lsp: Code action | `vim/.vimrc:212` |
| `<leader>ld` | `LspDiag current` | n | lsp: Current diagnostic | `vim/.vimrc:213` |
| `<leader>da` | `LspDiag show` | n | lsp: Show all diagnostics | `vim/.vimrc:214` |
| `]d` / `[d` | `LspDiag next/prev` | n | lsp: Next/prev diagnostic | `vim/.vimrc:218-219` |
| `gd` | `LspGotoDefinition` | n | lsp: Go to definition | `vim/.vimrc:220` |
| `<C-W>gd` | `LspGotoDefinition` (split) | n | lsp: Definition in split | `vim/.vimrc:221` |
| `gr` | `LspShowReferences` | n | lsp: Show references | `vim/.vimrc:222` |
| `gD` | `LspGotoDeclaration` | n | lsp: Go to declaration | `vim/.vimrc:223` |
| `gi` | `LspGotoImpl` | n | lsp: Go to implementation | `vim/.vimrc:224` |
| `gy` | `LspGotoTypeDef` | n | lsp: Go to type definition | `vim/.vimrc:225` |
| `K` | `LspHover` | n | lsp: Hover | `vim/.vimrc:226` |
| `<leader>rn` | `LspRename` | n | lsp: Rename | `vim/.vimrc:227` |
| `[` / `]` | `LspSelectionExpand/Shrink` | v | lsp: Selection expand/shrink | `vim/.vimrc:228-229` |
| `<C-s>` | `LspShowSignature` | n | lsp: Show signature | `vim/.vimrc:230` |
| `ghl` / `ghc` | `LspHighlight/Clear` | n | lsp: Highlight/clear refs | `vim/.vimrc:231-232` |
| `<Tab>` | next completion item | i | Completion: Next | `vim/.vimrc:239` |
| `<S-Tab>` | prev completion item | i | Completion: Prev | `vim/.vimrc:240` |
| `<CR>` | close popup and confirm | i | Completion: Confirm | `vim/.vimrc:241` |
| `<C-j>` | expand snippet | i, s | vsnip: Expand | `vim/.vimrc:243` |
| `<C-l>` | expand or jump next | i, s | vsnip: Expand/jump next | `vim/.vimrc:245` |
| `<C-h>` | jump prev | i, s | vsnip: Jump prev | `vim/.vimrc:249` |
| `s` / `S` | select/cut text | n, x | vsnip: Select/cut text | `vim/.vimrc:252-255` |
| `<leader>fm` | `:PrettierAsync<cr>` | n | Format with Prettier | `vim/.vimrc:264` |
| `<leader>u` | `:UndotreeToggle<cr>` | n | Toggle Undotree | `vim/.vimrc:274` |
| `<leader>tt` | `:TransparentToggle<cr>` | n | Toggle transparent | `vim/.vimrc:275` |
| `<leader>bd` | (fn) build nearest package | n | Build nearest package.json | `vim/.vimrc:307` |
| `<leader>bp` | (fn) open nearest package.json | n | Open nearest package.json | `vim/.vimrc:316` |
| `<leader>gd` | (fn) go to built dist file | n | Go to built dist file | `vim/.vimrc:350` |
| `<leader>GD` | (fn) go to source file | n | Go to source file from dist | `vim/.vimrc:351` |
| `<leader>nh` | (fn/opfunc) npm home | n, v | Open npm home for package | `vim/.vimrc:369-370` |
| `<leader>gh` | (fn/opfunc) github home | n, v | Open GitHub page for package | `vim/.vimrc:388-389` |
| `<leader>cp` | (fn) copy relative path | n | Copy relative path | `vim/.vimrc:453` |
| `<leader>cP` | (fn) copy absolute path | n | Copy absolute path | `vim/.vimrc:454` |
| `<leader>CP` | (fn) copy detailed path | n, v | Copy path with function/range | `vim/.vimrc:455-456` |
| `<leader>ll` | (fn) insert console.log | n | Insert console.log | `vim/.vimrc:471` |
| `<leader>LL` | `:g/xxxDEBUG/ d<CR>` | n | Remove all debug lines | `vim/.vimrc:472` |
| `<leader>yid` | (fn) yarn info dist-tags | n | Yarn/npm info dist-tags | `vim/.vimrc:598` |
| `<leader>yiv` | (fn) yarn info versions | n | Yarn/npm info versions | `vim/.vimrc:599` |
| `<leader>yy` | (fn) yarn why | n | Yarn/npm why | `vim/.vimrc:600` |
| `<leader>yl` | (fn) yarn list | n | Yarn/npm list | `vim/.vimrc:601` |
| `<leader>gg` | (fn) yarn test file | n | Run yarn test for file | `vim/.vimrc:649` |
| `<leader>GG` | (fn) yarn test nearest it() | n | Run yarn test nearest it() | `vim/.vimrc:650` |
| `<leader>zz` | (fn) zen mode | n | Toggle zen mode | `vim/.vimrc:659` |
| `<leader>md` | (fn) open markdown in browser | n | Open markdown in browser | `vim/.vimrc:675` |
| `<leader>fl` | `:set foldlevel=` | n | Set fold level | `vim/.vimrc:680` |
| `""` | jump back 50 chars (in cmdline) | c | Jump to inside quotes in rg | `vim/.vimrc:682` |
| `<leader>rg` | Ggrep (search in repo) | n | Grep in git repo | `vim/.vimrc:683` |
| `<leader>RG` | Ggrep word under cursor | n | Grep word under cursor | `vim/.vimrc:684` |
| `<leader>cc` | (fn) open agent terminal | n | Open/switch to agent terminal | `vim/.vimrc:715` |
| `<leader>bf` | (fn) close finished terminals | n | Close finished terminal buffers | `vim/.vimrc:743` |
| `*` | search visual selection | v | Search selected text | `vim/.vimrc:746` |
| `<leader>fv` | `:vsp %:h/` | n | New file (vsplit) | `vim/.vimrc:749` |
| `<leader>fs` | `:sp %:h/` | n | New file (split) | `vim/.vimrc:752` |
| `<leader>fe` | `:e %:h/` | n | Edit in current dir | `vim/.vimrc:755` |
| `<leader>vm` | `:vert res 120<cr>` | n | Set window width 120 | `vim/.vimrc:758` |
| **netrw ftplugin** | | | | |
| `D` | `NetrwSaladDelete` | n | netrw: Delete | `vim/.vim/ftplugin/netrw.vim:1` |
| `R` | `NetrwSaladRename` | n | netrw: Rename | `vim/.vim/ftplugin/netrw.vim:2` |
| `h` | `^-` (go up) | n | netrw: Go up directory | `vim/.vim/ftplugin/netrw.vim:4` |
| `l` | `<CR>` (open) | n | netrw: Open file/dir | `vim/.vim/ftplugin/netrw.vim:5` |
| **quickfix ftplugin** | | | | |
| `<C-,>` | `<cmd>colder<cr>` | n | qf: Older quickfix list | `vim/.vim/ftplugin/qf.vim:1` |
| `<C-.>` | `<cmd>cnewer<cr>` | n | qf: Newer quickfix list | `vim/.vim/ftplugin/qf.vim:2` |

---

## Tmux

Prefix is `C-a` (Ctrl+a). Bindings shown as `prefix + key` unless noted otherwise.

| lhs | rhs | key | desc | location |
|-----|-----|-----|------|----------|
| `C-a` | send-prefix | prefix | Custom prefix (replaces C-b) | `tmux/.tmux.conf:29` |
| `v` | `send -X begin-selection` | copy-mode-vi | Begin visual selection | `tmux/.tmux.conf:30` |
| `y` | `send -X copy-pipe "pbcopy"` | copy-mode-vi | Yank to clipboard | `tmux/.tmux.conf:33` |
| `R` | `movew -r` | prefix | Renumber windows sequentially | `tmux/.tmux.conf:36` |
| `o` | `killp -a` | prefix | Kill all panes except current | `tmux/.tmux.conf:39` |
| `O` | `killw -a; movew -r` | prefix | Kill all windows except current | `tmux/.tmux.conf:44` |
| `v` | `selectl main-vertical` | prefix | Main-vertical layout | `tmux/.tmux.conf:47` |
| `h` | `selectl main-horizontal` | prefix | Main-horizontal layout | `tmux/.tmux.conf:50` |
| `e` | `selectl tiled` | prefix | Tiled layout | `tmux/.tmux.conf:53` |
| `C-p` | `respawnw` | prefix | Respawn current window | `tmux/.tmux.conf:57` |
| `C-v` | `split-window -h` | prefix | Split vertical (side by side) | `tmux/.tmux.conf:60` |
| `C-s` | `split-window -v` | prefix | Split horizontal (top/bottom) | `tmux/.tmux.conf:61` |
| `c` | `new-window` | prefix | New window in current path | `tmux/.tmux.conf:62` |
| `V` | `splitp -hbl 25%` | prefix | Split vertical 25% left pane | `tmux/.tmux.conf:63` |
| `C-h` | `select-window -t :-` | prefix (repeat) | Previous window | `tmux/.tmux.conf:66` |
| `C-l` | `select-window -t :+` | prefix (repeat) | Next window | `tmux/.tmux.conf:67` |
| `H` | `resize-pane -L 5` | prefix (repeat) | Resize pane left | `tmux/.tmux.conf:70` |
| `J` | `resize-pane -D 5` | prefix (repeat) | Resize pane down | `tmux/.tmux.conf:71` |
| `K` | `resize-pane -U 5` | prefix (repeat) | Resize pane up | `tmux/.tmux.conf:72` |
| `L` | `resize-pane -R 5` | prefix (repeat) | Resize pane right | `tmux/.tmux.conf:73` |
| `C-a` | `copy-mode` | prefix | Enter copy mode | `tmux/.tmux.conf:75` |
| `C-e` | `last-window` | prefix | Switch to last window | `tmux/.tmux.conf:76` |
| `r` | `source-file ~/.tmux.conf` | prefix | Reload tmux config | `tmux/.tmux.conf:77` |
| `Z` | `run-shell zen.sh` | prefix (repeat) | Activate zen mode | `tmux/.tmux.conf:80` |
| `u` | `run-shell uzen.sh` | prefix (repeat) | Undo zen mode | `tmux/.tmux.conf:81` |
| `w` | `neww sh fzf_t_w.sh` | prefix | FZF window switcher | `tmux/.tmux.conf:82` |
| `C-h` | select-pane -L (or send to vim) | root | Smart pane left (vim-tmux-navigator) | `tmux/.tmux.conf:134` |
| `C-j` | select-pane -D (or send to vim) | root | Smart pane down (vim-tmux-navigator) | `tmux/.tmux.conf:135` |
| `C-k` | select-pane -U (or send to vim) | root | Smart pane up (vim-tmux-navigator) | `tmux/.tmux.conf:136` |
| `C-l` | select-pane -R (or send to vim) | root | Smart pane right (vim-tmux-navigator) | `tmux/.tmux.conf:137` |
| `C-\` | select-pane -l (or send to vim) | root | Smart pane last (vim-tmux-navigator) | `tmux/.tmux.conf:140` |
| `C-h` | `select-pane -L` | copy-mode-vi | Pane left in copy mode | `tmux/.tmux.conf:144` |
| `C-j` | `select-pane -D` | copy-mode-vi | Pane down in copy mode | `tmux/.tmux.conf:145` |
| `C-k` | `select-pane -U` | copy-mode-vi | Pane up in copy mode | `tmux/.tmux.conf:146` |
| `C-l` | `select-pane -R` | copy-mode-vi | Pane right in copy mode | `tmux/.tmux.conf:147` |
| `C-\` | `select-pane -l` | copy-mode-vi | Last pane in copy mode | `tmux/.tmux.conf:148` |
| `Ctrl-D` | delete window (in FZF picker) | FZF internal | Delete window from FZF switcher | `tmux/.config/tmux/fzf_t_w.sh:30` |

---

<a href="#keybindings-reference" style="position:fixed;bottom:24px;right:24px;background:#333;color:#fff;padding:8px 14px;border-radius:8px;text-decoration:none;font-size:14px;z-index:10;opacity:0.8;">↑ Top</a>
