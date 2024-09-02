return {
	"Exafunction/codeium.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"hrsh7th/nvim-cmp",
	},
	config = function()
		require("codeium").setup({
			enable_chat = true,
		})

		local cmp = require("cmp")

		cmp.setup({
			sources = cmp.config.sources({
				{ name = "codeium" },
			}),
		})
	end,
}
