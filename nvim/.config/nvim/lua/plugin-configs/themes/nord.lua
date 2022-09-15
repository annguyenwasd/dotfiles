local M = {}

M.dark = function()
	vim.o.background = "dark"
	set_theme("nord")
end

M.light = function()
	vim.o.background = "light"
	set_theme("nord")
end

return M
