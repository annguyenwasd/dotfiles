vim.g.vimsyn_embed = "lPr"
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.wildmenu = true
vim.opt.termguicolors = true
vim.opt.hidden = true
vim.opt.ignorecase = true
vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.expandtab = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.exrc = true
vim.opt.secure = true
vim.opt.clipboard = "unnamedplus"
vim.opt.updatetime = 100
vim.opt.inccommand = "nosplit"
vim.opt.mouse = "a"
vim.opt.scrolloff = 8
vim.opt.completeopt = { "menu", "preview", "menuone", "noinsert", "noselect" }  -- remove "menu", "preview" if wants to hide cmp's auto completion (<c-space> everything wants to trigger)
vim.opt.shortmess:append({ c = true })
vim.opt.smartindent = true
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.tabstop = 2
vim.opt.undofile = true
vim.opt.undodir = vim.fn.expand("~/.vim/undo")
vim.opt.cmdheight = 1
vim.opt.listchars = "tab:▹ ,trail:·,eol:↲,lead:·"
vim.opt.list = false
vim.opt.wrapscan = false
vim.opt.signcolumn = "yes"
vim.opt.syntax = "enable"
vim.opt.swapfile = false
vim.opt.keywordprg = ":help" -- set program for K (default)
vim.opt.lazyredraw = false
vim.opt.wrap = false
