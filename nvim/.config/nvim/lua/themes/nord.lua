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
	config()
	vim.o.background = "dark"
	set_theme("nord")
end

return M
