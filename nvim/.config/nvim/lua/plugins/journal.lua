local root = os.getenv("ANNGUYENWASD_JOURNAL_ROOT") or "~/.config/journal"

return {
	"jakobkhansen/journal.nvim",
	cmd = "Journal",
	config = function()
		require("journal").setup({
			root = root,
		})
	end,
	keys = {
		{
			"<leader>tj",
			function()
				require("telescope.builtin").find_files({ cwd = root })
			end,
			desc = desc("Telescope: find in journal"),
		},
		{
			"<leader>Nj",
			function()
				require("nvim-tree.api").tree.open({ path = vim.fn.expand(root) })
			end,
			desc = desc("NvimTree: tree in journal"),
		},
	},
}
