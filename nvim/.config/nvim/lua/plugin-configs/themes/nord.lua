local M = {}

M.config = function()
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
	set_theme("nord")
end

M.light = function()
	vim.o.background = "light"
	set_theme("nord")
end

return M
