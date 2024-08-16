local leet_arg = "lc"
return {
	"kawre/leetcode.nvim",
	build = ":TSUpdate html",
	lazy = leet_arg ~= vim.fn.argv()[1],
	opts = { arg = leet_arg, lang = "javascript" },
	dependencies = {
		"MunifTanjim/nui.nvim",
	},
	keys = {
		{ "<leader>ll", "<cmd>Leet list<cr>", desc = desc("leetcode: list") },
		{ "<leader>lt", "<cmd>Leet test<cr>", desc = desc("leetcode: test") },
		{ "<leader>lc", "<cmd>Leet console<cr>", desc = desc("leetcode: console") },
		{ "<leader>lo", "<cmd>Leet open<cr>", desc = desc("leetcode: open") },
		{ "<leader>ly", "<cmd>Leet yark<cr>", desc = desc("leetcode: yark") },
	},
}
