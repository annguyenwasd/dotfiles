vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.keymap.set('c', '%%', function()
    if vim.fn.getcmdtype() == ':' then
        return vim.fn.expand('%:h') .. '/'
    else
        return '%%'
    end
end, { expr = true, desc=desc"Current file's directory path" })

vim.keymap.set(
	"n",
	"n",
	"nzt",
	{ desc = desc("mappings: Override. next occurrence and make cursor top"), noremap = false }
)
vim.keymap.set(
	"n",
	"N",
	"Nzt",
	{ desc = desc("mappings: Override. prev occurrence and make cursor top"), noremap = false }
)
vim.keymap.set(
	"n",
	"*",
	"*zt",
	{ desc = desc("mappings: Override. next whole world occurrence and make cursor top"), noremap = false }
)

vim.keymap.set(
	"n",
	"#",
	"#zt",
	{ desc = desc("mappings: Override. prev whole world occurrence and make cursor top"), noremap = false }
)

vim.keymap.set("n", "Y", "y$", { desc = desc("mappings: yank from current position to end of line") })
vim.keymap.set(
	"v",
	"<leader>p",
	'"_dP',
	{ desc = desc("mappings: Paste without replace current value by replaced value") }
)

vim.keymap.set("v", "D", "y'>p", { desc = desc("mappings: Duplicate everything selected") })

vim.keymap.set(
	"v",
	"*",
	'y<cmd>let @/ = @"<cr><cmd>set hlsearch<cr>',
	{ desc = desc("mappings: Do search with selected text in VISUAL mode "), noremap = false }
)

vim.keymap.set(
	"n",
	"<leader>cl",
	"<cmd>ccl<cr><cmd>lcl<cr><cmd>echo ''<cr><cmd>noh<cr><cmd>pclose<cr>",
	{ desc = desc("mappings: Closing quickfix windows/location list windows") }
)

vim.keymap.set("n", "<c-w><c-e>", "<c-w>=", { desc = desc("mappings: Make windows equally") })

-- Moving around in command mode
vim.keymap.set(
	{ "c", "i" },
	"<c-h>",
	"<left>",
	{ desc = desc("mappings: go to left window. mode: c/i"), silent = false }
)
vim.keymap.set(
	{ "c", "i" },
	"<c-j>",
	"<down>",
	{ desc = desc("mappings: go to bottom window. mode: c/i"), silent = false }
)
vim.keymap.set({ "c", "i" }, "<c-k>", "<up>", { desc = desc("mappings: go to top window. mode: c/i"), silent = false })
vim.keymap.set(
	{ "c", "i" },
	"<c-l>",
	"<right>",
	{ desc = desc("mappings: go to right window. mode: c/i"), silent = false }
)

vim.keymap.set(
	"n",
	"<leader>e",
	"<cmd>b #<cr>",
	{ desc = desc("mappings: Swap current buffer with alternative buffer") }
)

-- Create file at same folder with vsplit/split
vim.keymap.set(
	"n",
	"<leader>fv",
	":vsp %:h/",
	{ desc = desc("mappings: Create a new file in same folder in vertical split"), silent = false }
)

vim.keymap.set(
	"n",
	"<leader>fs",
	":sp %:h/",
	{ desc = desc("mappings: Create a new file in same folder in horizontal split"), silent = false }
)

vim.keymap.set(
	"n",
	"<leader>fe",
	":e %:h/",
	{ desc = desc("mappings: Edit a file in current folder in same window"), silent = false }
)

-- Windows
vim.keymap.set(
	"n",
	"<c-w>v",
	"<c-w>v <c-w>l",
	{ desc = desc("mappings: Create a vertical split and move to new one"), noremap = true }
)

vim.keymap.set(
	"n",
	"<c-w><c-v>",
	"<c-w>v <c-w>l",
	{ desc = desc("mappings: Create a vertical split and move to new one"), noremap = true }
)

vim.keymap.set(
	"n",
	"<c-w>s",
	"<c-w>s <c-w>j",
	{ desc = desc("mappings: Create a horizontal split and move to new one"), noremap = true }
)

vim.keymap.set(
	"n",
	"<c-w><c-s>",
	"<c-w>s <c-w>j",
	{ desc = desc("mappings: Create a horizontal split and move to new one"), noremap = true }
)

vim.keymap.set("n", "<c-w><c-w>", "<c-w>q", { desc = desc("mappings: Close current window/split"), noremap = true })
vim.keymap.set("n", "<leader>fl", ":set foldlevel=", { desc = desc("mappings: set custom fold level"), silent = false })

vim.keymap.set(
	"n",
	"<leader>vm",
	":vert res 120<cr>",
	{ desc = desc("mappings: Set current window width 120 length"), noremap = true }
)

vim.keymap.set(
	"n",
	"<leader>tm",
	":!tmux neww ",
	{ desc = desc("mappings: Run a command in a new tmux window"), silent = false }
)

vim.keymap.set(
	"n",
	"<leader>tM",
	":!tmux splitw ",
	{ desc = desc("mappings: Run a command in a new tmux pane"), silent = false }
)

vim.keymap.set(
	"n",
	"<leader>as",
	":AsyncRun ",
	{ desc = desc("mappings: Run a command asynchronously inside neovim"), silent = false }
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
end, { desc = desc("mappings: Find nearest upper package.json file and build that package") })

vim.keymap.set("n", "<leader>bp", function()
	local package = vim.fn.findfile("package.json", ".;")
	if package ~= "package.json" then
		vim.cmd.edit(package)
	end
end, { desc = desc("mappings: Open nearest package.json file") })

vim.keymap.set("n", "<leader>K", function()
	local w = vim.fn.expand("<cword>")
	vim.api.nvim_command("help " .. w)
end, { desc = desc("mappings: Show vim's documentation on current word"), noremap = true })

vim.keymap.set(
	"n",
	"<leader>vt",
	":vsplit term://",
	{ desc = desc("mappings: Open terminal with vertial split"), noremap = true }
)
vim.keymap.set(
	"n",
	"<leader>st",
	":split term://",
	{ desc = desc("mappings: Open terminal with horizontal split"), noremap = true }
)

vim.keymap.set(
	"n",
	"<leader>vT",
	":vsplit term://$SHELL<cr>",
	{ desc = desc("mappings: Open terminal with vertial split with default shell"), noremap = true }
)
vim.keymap.set(
	"n",
	"<leader>sT",
	":split term://$SHELL<cr>",
	{ desc = desc("mappings: Open terminal with horizontal split with default shell"), noremap = true }
)
vim.keymap.set("n", "<leader>tt", function()
	require("themes.toggle").gruvbox()
end, { desc = desc("theme: Toggle gruvbox theme"), noremap = true })
-- vim.keymap.set({"n", "v", "i"}, "<UP>", function()
-- 	vim.notify("disabled")
-- end, { desc = desc("mappings: disabled key"), noremap = true })
-- vim.keymap.set({"n", "v", "i"}, "<DOWN>", function()
-- 	vim.notify("disabled")
-- end, { desc = desc("mappings: disabled key"), noremap = true })
-- vim.keymap.set({"n", "v", "i"}, "<LEFT>", function()
-- 	vim.notify("disabled")
-- end, { desc = desc("mappings: disabled key"), noremap = true })
-- vim.keymap.set({"n", "v", "i"}, "<RIGHT>", function()
-- 	vim.notify("disabled")
-- end, { desc = desc("mappings: disabled key"), noremap = true })
