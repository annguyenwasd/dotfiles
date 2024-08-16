local M = {}

local theme = require("utils.theme-chooser")

function M.toggle_present()
	if annguyenwasd.is_present_mode then
		vim.o.relativenumber = false
		vim.opt.cursorline = true
		theme.set("vscode", "dark")
	else
		theme.set("black_and_white", "nineties")
		vim.o.relativenumber = true
		vim.opt.cursorline = false
	end
	annguyenwasd.is_present_mode = not annguyenwasd.is_present_mode
end

vim.keymap.set("n", "gpm", M.toggle_present, { desc = desc("Toggle present mode") })
