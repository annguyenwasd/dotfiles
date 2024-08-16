local leet_arg = "lc"
return {
	"kawre/leetcode.nvim",
	build = ":TSUpdate html",
	lazy = leet_arg ~= vim.fn.argv()[1],
	opts = { arg = leet_arg, lang = "javascript" },
	dependencies = {
		"MunifTanjim/nui.nvim",
	},
}
