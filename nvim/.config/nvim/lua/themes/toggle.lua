local M = {}

local theme = require("utils.theme-chooser")

M.gruvbox = function()
	if vim.opt.background._value == "light" then
		theme.set("gruvbox-material", "dark_mix_medium")
	else
		theme.set("gruvbox-material", "light_mix_medium")
	end
end

return M
