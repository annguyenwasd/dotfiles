return {
	{
		"kevinhwang91/nvim-bqf",
		ft = "qf",
		dependencies = {
			{
				"junegunn/fzf.vim",
				dir = "~/.fzf",
				build = "./install --bin",
			},
		},
		config = function()
			require("bqf").setup({
				preview = {
					auto_preview = true,
					winblend = 0,
					win_height = 999,
				},
			})
		end,
	},
	{
		"numtostr/BufOnly.nvim",
		init = function()
			vim.g.bufonly_delete_non_modifiable = true
		end,
		keys = {
			{ "<leader>bo", ":BufOnly<CR>", desc = desc("buf: buf only") },
		},
	},
	{
		"yorickpeterse/nvim-window",
		config = true,
		keys = {
			{ "<leader>ww", "<cmd>lua require('nvim-window').pick()<cr>", desc = desc("buf: Picking neovim's window") },
		},
	},
}
