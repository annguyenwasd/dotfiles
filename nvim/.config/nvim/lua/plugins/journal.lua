return {
	"jakobkhansen/journal.nvim",
	config = function()
		require("journal").setup({
			root = "~/.config/journal",
		})
		vim.keymap.set("n", "<leader>tj", function()
			require("telescope.builtin").find_files({ cwd = "~/.config/journal" })
		end, { desc = desc("Telescope: find in journal") })

		vim.keymap.set("n", "<leader>Nj", function()
			require("nvim-tree.api").tree.open({ path = vim.fn.expand("~/.config/journal") })
		end, { desc = desc("NvimTree: tree in journal") })
	end,
}
