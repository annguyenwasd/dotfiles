if vim.loader then
	vim.loader.enable()
end

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)
require("settings")
require("autocmd")
require("global-mapping")
require("mappings")
require("lazy").setup("plugins", {
	root = vim.fn.stdpath("data") .. "/lazy",
	change_detection = {
		notify = false,
	},
	default = {
		version = "*",
	},
	concurrency = 5,
	git = {
		timeout = 600,
	},
})
vim.keymap.set("n", "<leader>lp", "<cmd>Lazy profile<cr>")
require("themes.__output__")
