return {
	"LudoPinelli/comment-box.nvim",

	{
		"JoosepAlviste/nvim-ts-context-commentstring",
		event = "VeryLazy",
		init = function()
			vim.g.skip_ts_context_commentstring_module = true
		end,
		config = function()
			require("ts_context_commentstring").setup({
				enable_autocmd = false,
			})
		end,
	},

	{
		"numToStr/Comment.nvim",
		event = "VeryLazy",
		dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
		config = function()
			require("Comment").setup({
				pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
			})
		end,
	},
}
