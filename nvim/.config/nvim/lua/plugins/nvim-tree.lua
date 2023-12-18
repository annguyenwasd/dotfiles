return {
	{
		"kyazdani42/nvim-tree.lua",
		init = function()
			vim.gnvim_tree_respect_buf_cwd = 1 -- 0 by default, will change cwd of nvim-tree to that of new buffer's when opening nvim-tree.
			-- disable netrw at the very start of your init.lua
			vim.g.loaded_netrw = 1
			vim.g.loaded_netrwPlugin = 1

			-- set termguicolors to enable highlight groups
			vim.opt.termguicolors = true
		end,
		keys = {
			{ "<leader>n", "<cmd>NvimTreeToggle<cr>", desc = make_desc("nvim-tree: toggle") },
		},
		config = function()
			local function on_attach(bufnr)
				local api = require("nvim-tree.api")

				local function opts(desc)
					return make_mapping_opts(
						"nvim-tree: " .. desc,
						{ buffer = bufnr, noremap = true, silent = true, nowait = true }
					)
				end

				api.config.mappings.default_on_attach(bufnr)

				-- You will need to insert "your code goes here" for any mappings with a custom action_cb
				vim.keymap.set("n", "l", api.node.open.edit, opts("Open"))
				vim.keymap.set("n", "h", api.node.navigate.parent_close, opts("Close Directory"))
				vim.keymap.set("n", "h", api.node.navigate.parent_close, opts("Close Directory"))
				vim.keymap.set("n", "H", api.tree.collapse_all, opts("Collapse"))
			end

			require("nvim-tree").setup({
				on_attach = on_attach,
				live_filter = {
					prefix = "[FILTER]: ",
					always_show_folders = false,
				},
				actions = { open_file = { quit_on_open = true } },
				renderer = { indent_markers = { enable = true } },
				update_focused_file = { enable = true },
				view = {
					width = 40,
				},
				git = {
					ignore = false,
				},
				filesystem_watchers = {
					ignore_dirs = { "node_modules", ".git" },
				},
			})
		end,
	},
}
