local root = os.getenv("ANNGUYENWASD_JOURNAL_ROOT") or "~/.config/journal"

return {
	"jakobkhansen/journal.nvim",
	cmd = "Journal",
	config = function()
		require("journal").setup({
			root = root,
			journal = {
				entries = {
					d = {
						format = "%Y/%m-%B/daily/%d-%A", -- Format of the journal entry in the filesystem.
						template = "# %A %B %d %Y\n", -- Optional. Template used when creating a new journal entry
						frequency = { day = 1 }, -- Optional. The frequency of the journal entry. Used for `:Journal next`, `:Journal -2` etc
					},
					w = {
						format = "%Y/%m-%B/weekly/week-%W",
						template = "# Week %W %B %Y\n",
						frequency = { day = 7 },
						date_modifier = "monday", -- Optional. Date modifier applied before other modifier given to `:Journal`
					},
					m = {
						format = "%Y/%m-%B/%B",
						template = "# %B %Y\n",
						frequency = { month = 1 },
					},
					y = {
						format = "%Y/%Y",
						template = "# %Y\n",
						frequency = { year = 1 },
					},
				},
			},
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
