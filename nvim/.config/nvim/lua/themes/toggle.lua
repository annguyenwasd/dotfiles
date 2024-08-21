local M = {}

local theme = require("utils.theme-chooser")

M.gruvbox = function()
	local date = os.date("*t")
	if date.hour >= 18 then
		theme.set("gruvbox-material", "dark_mix_medium")
    vim.notify"Night time! Selected dark theme"
	else
		theme.set("gruvbox-material", "light_mix_medium")
    vim.notify"Day time! Selected light theme"
	end
end

return M
