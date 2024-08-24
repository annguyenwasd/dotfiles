return {
	"uga-rosa/translate.nvim",
	enabled = function()
		return not is_work_profile()
	end,
	keys = { {
		"<leader>tl",
		"<cmd>Translate vi<cr>",
		desc = desc("Translate"),
	} },
}
