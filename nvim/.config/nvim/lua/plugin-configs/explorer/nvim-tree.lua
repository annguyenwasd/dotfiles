return function()
	local tree_cb = require("nvim-tree.config").nvim_tree_callback

	vim.keymap.set("n", "<leader>n", "<cmd>NvimTreeToggle<cr>")

	local function collapse_all()
		require("nvim-tree.actions.tree-modifiers.collapse-all").fn()
	end
	local lib = require("nvim-tree.lib")

	local git_add = function()
		local node = lib.get_node_at_cursor()
		local gs = node.git_status

		-- If the file is untracked, unstaged or partially staged, we stage it
		if gs == "??" or gs == "MM" or gs == "AM" or gs == " M" then
			vim.cmd("silent !git add " .. node.absolute_path)

		-- If the file is staged, we unstage
		elseif gs == "M " or gs == "A " then
			vim.cmd("silent !git restore --staged " .. node.absolute_path)
		end

		lib.refresh_tree()
	end

	require("nvim-tree").setup({
		live_filter = {
			prefix = "[FILTER]: ",
			always_show_folders = false,
		},
		actions = { open_file = { quit_on_open = true } },
		renderer = { indent_markers = { enable = true } },
		update_focused_file = { enable = true },
		view = {
			width = 40,
			mappings = {
				list = {
					{ key = { "l" }, cb = tree_cb("edit") },
					{ key = { "h" }, cb = tree_cb("close_node") },
					{ key = "h", action = "close_node" },
					{ key = "H", action = "collapse_all", action_cb = collapse_all },
					{ key = "ga", action = "git_add", action_cb = git_add },
				},
			},
		},
		git = {
			ignore = false,
		},
		filesystem_watchers = {
			ignore_dirs = { "node_modules", ".git" },
		},
	})
end
