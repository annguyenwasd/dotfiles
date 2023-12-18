local M = {}

local config = function()
	require("nord").setup({
		styles = {
			keywords = { bold = false },
			functions = { bold = true },
			variables = { bold = true },
		},
	})
end

M.dark = function()
	vim.o.background = "dark"
	config()
	set_theme("nord")
end

M.light = function()
	vim.o.background = "light"
	config()
	set_theme("nord")
end

return M
