local M = {}

M.dark = function()
	require("nord").setup({
		styles = {
			keywords = { bold = false },
			functions = { bold = true },
			variables = { bold = true },
		},
	})
	vim.o.background = "dark"
	set_theme("nord")
end

return M
