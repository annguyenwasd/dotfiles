local M = {}

M.dark = function()
	vim.o.background = "dark"
	set_theme("gruvbox", "auto")
end

M.light = function()
	vim.o.background = "light"
	set_theme("gruvbox", "auto")
end


return M
