local M = {}

M.dark = function()
	vim.o.background = "dark"
	set_theme("github-colors", "auto")
end

M.light = function()
	vim.o.background = "light"
	set_theme("github-colors", "auto")
end

return M
