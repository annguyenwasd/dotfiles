local M = {}

M.dark = function()
	vim.o.background = "dark"
	set_theme("OceanicNext")
end

M.light = function()
	vim.o.background = "light"
	set_theme("OceanicNext")
end

return M
