vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.keymap.set("n", "n", "nzt", make_mapping_opts("Override. next occurrence and make cursor top", { noremap = false }))
vim.keymap.set("n", "N", "Nzt", make_mapping_opts("Override. prev occurrence and make cursor top", { noremap = false }))
vim.keymap.set(
	"n",
	"*",
	"*zt",
	make_mapping_opts("Override. next whole world occurrence and make cursor top", { noremap = false })
)
vim.keymap.set(
	"n",
	"#",
	"#zt",
	make_mapping_opts("Override. prev whole world occurrence and make cursor top", { noremap = false })
)

vim.keymap.set("n", "Y", "y$", make_mapping_opts("yarnk from current position to end of line"))
vim.keymap.set("v", "<leader>p", '"_dP', make_mapping_opts("Paste without replace current value by replaced value"))

vim.keymap.set("v", "D", "y'>p", make_mapping_opts("Duplicate everything selected"))

vim.keymap.set(
	"v",
	"*",
	'y<cmd>let @/ = @"<cr><cmd>set hlsearch<cr>',
	make_mapping_opts("Do search with selected text in VISUAL mode ", { noremap = false })
)

vim.keymap.set(
	"n",
	"<leader>cl",
	"<cmd>ccl<cr><cmd>lcl<cr><cmd>echo ''<cr><cmd>noh<cr><cmd>pclose<cr>",
	make_mapping_opts("Closing quickfix windows/location list windows")
)

vim.keymap.set("n", "<leader><leader>r", function()
	local paths = vim.split(vim.fn.glob("~/.config/nvim/lua/**/*.lua"), "\n")
	for _, file in pairs(paths) do
		vim.cmd("source " .. file)
	end
	vim.cmd("syntax enable")
	print("Sourced all config files")
end, make_mapping_opts("Source all lua files"))

vim.keymap.set("n", "<c-w><c-e>", "<c-w>=", make_mapping_opts("Make windows equally"))

-- Moving around in command mode
vim.keymap.set({ "c", "i" }, "<c-h>", "<left>", make_mapping_opts("go to left window. mode: c/i", { silent = false }))
vim.keymap.set({ "c", "i" }, "<c-j>", "<down>", make_mapping_opts("go to bottom window. mode: c/i", { silent = false }))
vim.keymap.set({ "c", "i" }, "<c-k>", "<up>", make_mapping_opts("go to top window. mode: c/i", { silent = false }))
vim.keymap.set({ "c", "i" }, "<c-l>", "<right>", make_mapping_opts("go to right window. mode: c/i", { silent = false }))

vim.keymap.set("n", "<leader>e", "<cmd>b #<cr>", make_mapping_opts("Swap current buffer with alternative buffer"))

-- Create file at same folder with vsplit/split
vim.keymap.set(
	"n",
	"<leader>fv",
	":vsp %:h/",
	make_mapping_opts("Create a new file in same folder in vertical split", { silent = false })
)
vim.keymap.set(
	"n",
	"<leader>fs",
	":sp %:h/",
	make_mapping_opts("Create a new file in same folder in horizontal split", { silent = false })
)
vim.keymap.set(
	"n",
	"<leader>fe",
	":e %:h/",
	make_mapping_opts("Edit a file in current folder in same window", { silent = false })
)

-- TODO: optimise
vim.keymap.set("n", "<leader><leader>h", 'yi" :!npm home <c-r>"<cr>', make_mapping_opts("Open npm homepage")) -- merge with bellow
vim.keymap.set("n", "<leader><leader>H", "yi' :!npm home <c-r>\"<cr>", make_mapping_opts("Open npm homepage"))
vim.keymap.set(
	"n",
	"<leader><leader>oe",
	"<cmd>!open -a textedit %<cr>",
	make_mapping_opts("Open current file in text edit")
) -- check os
vim.keymap.set("n", "<leader><leader>oc", "<cmd>!code %<cr>", make_mapping_opts("Open current file in VSCode"))
vim.keymap.set(
	"n",
	"<leader><leader>og",
	"<cmd>!open -a google chrome %<cr>",
	make_mapping_opts("Open current file in google chrome")
) -- check os

-- Windows
vim.keymap.set(
	"n",
	"<c-w>v",
	"<c-w>v <c-w>l",
	make_mapping_opts("Create a vertical split and move to new one", { noremap = true })
)

vim.keymap.set(
	"n",
	"<c-w><c-v>",
	"<c-w>v <c-w>l",
	make_mapping_opts("Create a vertical split and move to new one", { noremap = true })
)

vim.keymap.set(
	"n",
	"<c-w>s",
	"<c-w>s <c-w>j",
	make_mapping_opts("Create a horizontal split and move to new one", { noremap = true })
)

vim.keymap.set(
	"n",
	"<c-w><c-s>",
	"<c-w>s <c-w>j",
	make_mapping_opts("Create a horizontal split and move to new one", { noremap = true })
)

vim.keymap.set("n", "<c-w><c-w>", "<c-w>q", make_mapping_opts("Close current window/split", { noremap = true }))
vim.keymap.set("n", "<leader>fl", ":set foldlevel=", make_mapping_opts("set custom fold level", { silent = false }))

vim.keymap.set(
	"n",
	"<leader>mv",
	":vert res 120<cr>",
	make_mapping_opts("Set current window width 120 length", { noremap = true })
)

vim.keymap.set(
	"n",
	"<leader>tm",
	":!tmux neww ",
	make_mapping_opts("Run a command in a new tmux window", { silent = false })
)
vim.keymap.set(
	"n",
	"<leader>tM",
	":!tmux splitw ",
	make_mapping_opts("Run a command in a new tmux pane", { silent = false })
)
vim.keymap.set(
	"n",
	"<leader>as",
	":AsyncRun ",
	make_mapping_opts("Run a command asynchronously inside neovim", { silent = false })
)

vim.keymap.set("n", "<leader>bd", function()
	local package = vim.fn.findfile("package.json", ".;")
	if package ~= "package.json" then
		local file = io.open(package, "rb")

		if file == nil then
			print("no package.json found")
			return
		end

		local jsonString = file:read("*a")
		file:close()
		print(jsonString)

		local t = vim.json.decode(jsonString)
		local packageName = t["name"]
		vim.notify("Building " .. packageName)

		vim.cmd("AsyncRun yarn workspace " .. packageName .. " build")
	end
end, make_mapping_opts("Find nearest upper package.json file and build that package"))

vim.keymap.set("n", "<leader>bp", function()
	local package = vim.fn.findfile("package.json", ".;")
	if package ~= "package.json" then
		vim.cmd.edit(package)
	end
end, make_mapping_opts("Open nearest package.json file"))

vim.keymap.set("n", "<leader>K", function()
	local w = vim.fn.expand("<cword>")
	vim.api.nvim_command("help " .. w)
end, make_mapping_opts("Show vim's documentation on current word", { noremap = true }))
