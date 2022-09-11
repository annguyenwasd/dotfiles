return function()
	local tree_cb = require("nvim-tree.config").nvim_tree_callback

	vim.keymap.set("n", "<leader>n", "<cmd>NvimTreeToggle<cr>")

	require("nvim-tree").setup({
		actions = { open_file = { quit_on_open = true } },
		renderer = { indent_markers = { enable = true } },
		update_focused_file = { enable = true },
		view = {
			width = 40,
			mappings = {
				list = {
					{ key = { "l" }, cb = tree_cb("edit") },
					{ key = { "h" }, cb = tree_cb("close_node") },
				},
			},
		},
		git = {
			ignore = false,
		},
	})
end
