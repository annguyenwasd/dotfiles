vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.keymap.set("n", "n", "nzt", { noremap = false })
vim.keymap.set("n", "N", "Nzt", { noremap = false })
vim.keymap.set("n", "*", "*zt", { noremap = false })
vim.keymap.set("n", "#", "#zt", { noremap = false })

vim.keymap.set("n", "Y", "y$")
vim.keymap.set("v", "<leader>p", '"_dP')

-- Duplicate everything selected
vim.keymap.set("v", "D", "y'>p")

-- Do search with selected text in VISUAL mode
vim.keymap.set("v", "*", 'y<cmd>let @/ = @"<cr><cmd>set hlsearch<cr>', { noremap = false })

vim.keymap.set("n", "<leader>cl", "<cmd>ccl<cr><cmd>lcl<cr><cmd>echo ''<cr><cmd>noh<cr><cmd>pclose<cr>")

local function refresh()
	local paths = vim.split(vim.fn.glob("~/.config/nvim/lua/**/*.lua"), "\n")
	for i, file in pairs(paths) do
		vim.cmd("source " .. file)
	end
	vim.cmd("PackerCompile")
	vim.cmd("syntax enable")
	print("Sourced all config files")
end

vim.keymap.set("n", "<leader><leader>R", function()
	refresh()
	vim.cmd("PackerInstall")
end)

vim.keymap.set("n", "<leader><leader>r", refresh)

vim.keymap.set("n", "<c-w><c-e>", "<c-w>=")

-- Moving around in command mode
vim.keymap.set("c", "<c-h>", "<left>", { silent = false })
vim.keymap.set("c", "<c-j>", "<down>", { silent = false })
vim.keymap.set("c", "<c-k>", "<up>", { silent = false })
vim.keymap.set("c", "<c-l>", "<right>", { silent = false })

vim.keymap.set("i", "<c-h>", "<left>", { silent = false })
vim.keymap.set("i", "<c-j>", "<down>", { silent = false })
vim.keymap.set("i", "<c-k>", "<up>", { silent = false })
vim.keymap.set("i", "<c-l>", "<right>", { silent = false })

vim.keymap.set("n", "<leader>e", "<cmd>b #<cr>")
vim.keymap.set("n", "<leader><leader>e", "<cmd>e<cr>")
vim.keymap.set("n", "<leader>td", ":vsp .todo<cr>")

-- Create file at same folder with vsplit/split
vim.keymap.set("n", "<leader>vf", ":vsp %:h/", { silent = false })
vim.keymap.set("n", "<leader>sf", ":sp %:h/", { silent = false })
vim.keymap.set("n", "<leader><leader>ef", ":e %:h/", { silent = false })

vim.keymap.set("n", "<leader><leader>h", 'yi" :!npm home <c-r>"<cr>')
vim.keymap.set("n", "<leader><leader>H", "yi' :!npm home <c-r>\"<cr>")
vim.keymap.set("n", "<leader><leader>oe", "<cmd>!open -a textedit %<cr>")
vim.keymap.set("n", "<leader><leader>oc", "<cmd>!code %<cr>")
vim.keymap.set("n", "<leader><leader>og", "<cmd>!open -a google chrome %<cr>")

-- Windows
vim.keymap.set("n", "<c-w>v", "<c-w>v <c-w>l", { noremap = true })
vim.keymap.set("n", "<c-w><c-v>", "<c-w>v <c-w>l", { noremap = true })
vim.keymap.set("n", "<c-w>s", "<c-w>s <c-w>j", { noremap = true })
vim.keymap.set("n", "<c-w><c-s>", "<c-w>s <c-w>j", { noremap = true })
vim.keymap.set("n", "<c-w><c-w>", "<c-w>q", { noremap = true })
vim.keymap.set("n", "<leader><leader>m", ":vert res 120<cr>", { noremap = true })
vim.keymap.set("n", "<leader><leader>M", ":GoldenRatioToggle<cr>", { noremap = true })

vim.keymap.set("n", "<leader>rr", '"rciw')
vim.keymap.set("n", "<leader>cf", ":CopyFileName<cr>")
vim.keymap.set("n", "<leader>fl", ":set foldlevel=", { silent = false })
vim.keymap.set("n", "<leader>cc", ":set cmdheight=1<cr>")

function _G.copyFileName()
	vim.fn.setreg("*", vim.fn.expand("%:t:r"))
	vim.fn.setreg("r", vim.fn.expand("%:t:r"))
end

function _G.copyAbsouPathPath()
	vim.fn.setreg("*", vim.fn.expand("%:p"))
	vim.fn.setreg("r", vim.fn.expand("%:p"))
end

function _G.copyFileRelativePath()
	vim.fn.setreg("*", vim.fn.expand("%"))
	vim.fn.setreg("r", vim.fn.expand("%"))
end

function _G.copyFileRelativeFolderPath()
	vim.fn.setreg("*", vim.fn.expand("%:h"))
	vim.fn.setreg("r", vim.fn.expand("%:h"))
end

function _G.copyFolderName()
	vim.fn.setreg("*", vim.fn.expand("%:h:t"))
	vim.fn.setreg("r", vim.fn.expand("%:h:t"))
end

function _G.openCurrentFolder()
	vim.api.nvim_command("!open %:p:h")
end

function _G.googleJavaFormat()
	vim.api.nvim_command("!google-java-format --replace % ")
end

vim.api.nvim_command("command! CopyFileName :call v:lua.copyFileName()")
vim.api.nvim_command("command! Cfn :call v:lua.copyFileName()")

vim.api.nvim_command("command! CopyFolderName :call v:lua.copyFolderName()")
vim.api.nvim_command("command! Cdn :call v:lua.copyFolderName()")

vim.api.nvim_command("command! CopyAbsouPathPath :call v:lua.copyAbsouPathPath()")
vim.api.nvim_command("command! CopyRelativePath :call v:lua.copyFileRelativePath()")
vim.api.nvim_command("command! CopyFolderPath :call v:lua.copyFileRelativeFolderPath()")

vim.api.nvim_command("command! GoogleJavaFormat :call v:lua.googleJavaFormat()")

vim.api.nvim_command("command! OpenFolder :call v:lua.openCurrentFolder()")
vim.api.nvim_command("command! Od :call v:lua.openCurrentFolder()")

-- Open github page
vim.keymap.set("n", "<leader><leader>gh", function()
	vim.cmd('normal! yi"')
	local package = vim.fn.getreg('"')
	local ghPage = "https://github.com/" .. package
	vim.cmd("!open " .. ghPage)
end, { silent = true })

-- local function tm ()
--   vim.ui.input({prompt = ':!tmux neww '}, function (command)
--     if string.len(command) > 0 then
--       vim.cmd(":!tmux neww " .. command)
--     end
--   end
-- )
-- end

vim.keymap.set("n", "<leader>tm", ":!tmux neww ", { silent = false })

local function build()
	local json = require("lib.json")

	local package = vim.fn.findfile("package.json", ".;")
	if package ~= "package.json" then
		local file = io.open(package, "rb")

		local jsonString = file:read("*a")
		file:close()
		print(jsonString)

		-- parse json with lunajson
		-- local json = require 'lunajson'
		local t = json.decode(jsonString)
		local packageName = t["name"]
		vim.notify("Building " .. packageName)

		vim.cmd("AsyncRun yarn workspace " .. packageName .. " build")
		-- vim.cmd ("!tmux splitw -l 15 yarn workspace " .. packageName .. " build")
	end
end

vim.keymap.set("n", "<leader>bd", build)

function _G.set_theme(theme_name, lualine_theme)
	vim.cmd("colorscheme " .. theme_name)
	require("lualine").setup({ options = { theme = lualine_theme or theme_name } })
end
