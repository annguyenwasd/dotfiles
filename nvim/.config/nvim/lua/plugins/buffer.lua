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
					winblend = 0,
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
			{ "<leader>bo", ":BufOnly<CR>", desc = make_desc("buf only") },
		},
	},

	{
		"yorickpeterse/nvim-window",
		config = function()
			vim.keymap.set("n", "<leader>ww", require("nvim-window").pick, make_mapping_opts("Picking neovim's window"))
		end,
		keys = "<leader>ww",
	},
}
