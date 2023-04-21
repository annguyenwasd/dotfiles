local M = {}

M.dark = function()
	vim.o.background = "dark"
	require("gruvbox").setup({
		undercurl = true,
		underline = true,
		bold = true,
		italic = {
			strings = false,
			comments = false,
			operators = false,
			folds = false,
		},
		strikethrough = true,
		invert_selection = false,
		invert_signs = false,
		invert_tabline = false,
		invert_intend_guides = false,
		inverse = true, -- invert background for search, diffs, statuslines and errors
		contrast = "", -- can be "hard", "soft" or empty string
		palette_overrides = {},
		overrides = {},
		dim_inactive = false,
		transparent_mode = false,
	})
	set_theme("gruvbox", "auto")
end

M.light = function()
	vim.o.background = "light"
	require("gruvbox").setup({
		undercurl = true,
		underline = true,
		bold = true,
		italic = false,
		strikethrough = true,
		invert_selection = false,
		invert_signs = false,
		invert_tabline = false,
		invert_intend_guides = false,
		inverse = true, -- invert background for search, diffs, statuslines and errors
		contrast = "", -- can be "hard", "soft" or empty string
		palette_overrides = {},
		overrides = {},
		dim_inactive = false,
		transparent_mode = false,
	})
	set_theme("gruvbox", "auto")
end

return M
