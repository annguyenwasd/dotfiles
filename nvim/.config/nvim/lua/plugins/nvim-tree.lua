return {
	{
		"kyazdani42/nvim-tree.lua",
		lazy = false,
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

				local utils = require("utils.nvim-tree")

				-- You will need to insert "your code goes here" for any mappings with a custom action_cb
				vim.keymap.set("n", "l", api.node.open.edit, opts("Open"))
				vim.keymap.set("n", "h", api.node.navigate.parent_close, opts("Close Directory"))
				vim.keymap.set("n", "h", api.node.navigate.parent_close, opts("Close Directory"))
				vim.keymap.set("n", "H", api.tree.collapse_all, opts("Collapse"))
				vim.keymap.set("n", "<c-f>", utils.launch_find_files, opts("Launch Find Files"))
				vim.keymap.set("n", "<c-g>", utils.launch_live_grep, opts("Launch Live Grep"))
				vim.keymap.set("n", "<esc>", api.tree.close, opts("Close"))
			end

			local HEIGHT_RATIO = 0.8 -- You can change this
			local WIDTH_RATIO = 0.5 -- You can change this too

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
					width = function()
						return math.floor(vim.opt.columns:get() * WIDTH_RATIO)
					end,
					float = {
						enable = true,
						open_win_config = function()
							local screen_w = vim.opt.columns:get()
							local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
							local window_w = screen_w * WIDTH_RATIO
							local window_h = screen_h * HEIGHT_RATIO
							local window_w_int = math.floor(window_w)
							local window_h_int = math.floor(window_h)
							local center_x = (screen_w - window_w) / 2
							local center_y = ((vim.opt.lines:get() - window_h) / 2) - vim.opt.cmdheight:get()
							return {
								border = "rounded",
								relative = "editor",
								row = center_y,
								col = center_x,
								width = window_w_int,
								height = window_h_int,
							}
						end,
					},
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
