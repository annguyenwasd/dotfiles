return {
	{
		-- TODO: remove tag
		"nvim-telescope/telescope.nvim",
		tag = "0.1.5",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local actions = require("telescope.actions")
			local actions_layout = require("telescope.actions.layout")

			-- You dont need to set any of these options. These are the default ones. Only
			-- the loading is important
			require("telescope").setup({
				defaults = {
					vimgrep_arguments = {
						"rg",
						"--color=never",
						"--no-heading",
						"--with-filename",
						"--line-number",
						"--column",
						"--hidden",
						"--smart-case",
						"--trim", -- add this value
					},
					file_ignore_patterns = {
						"node_modules",
						"%.git/",
						".vscode/",
						".idea",
						"coverage/",
						"build/",
						"reports/",
						"dist/",
					},
					preview = {
						hide_on_startup = true,
					},
					layout_config = {
						prompt_position = "top",
					},
					sorting_strategy = "ascending",
					mappings = {
						i = {
							["<c-e>"] = actions.send_selected_to_qflist + actions.open_qflist,
							["<c-s>"] = actions.select_horizontal,
							["<c-h>"] = actions.which_key,
							["<c-\\>"] = actions_layout.toggle_preview,
						},
						n = {
							["<c-e>"] = actions.send_selected_to_qflist + actions.open_qflist,
							["<c-s>"] = actions.select_horizontal,
							["<c-h>"] = actions.which_key,
							["<c-d>"] = actions.delete_buffer,
							["<c-\\>"] = actions_layout.toggle_preview,
						},
					},
				},
			})
		end,
		keys = {
			{
				"<leader>o",
				"<cmd>lua require('utils.explorer').find_files()<cr>",
				desc = desc("telescope: find files"),
			},
			{
				"<leader>O",
				function()
					require("telescope.builtin").find_files({ no_ignore = true, no_ignore_parent = true, hidden = true })
				end,
				desc = desc("telescope: find files with ignored files"),
			},
			{
				"<leader>i",
				function()
					require("telescope.builtin").buffers({
						sort_rmu = true,
						sort_lastused = true,
						show_all_buffers = true,
					})
				end,
				desc = desc("telescope: show opened buffers"),
			},
			{
				"<leader>/",
				"<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>",
				desc = desc("telescope: current buffer fuzzy find"),
			},
			{
				"<leader><leader>fc",
				"<cmd>lua require('utils.theme-chooser')()<cr>",
				desc = desc("telescope: theme chooser"),
			},
			-- { "<leader>rg", "<cmd>lua require('telescope.builtin').live_grep()<cr>", desc=desc("telescope: live grep")},
			{
				"<leader>fh",
				"<cmd>lua require('telescope.builtin').help_tags()<cr>",
				desc = desc("telescope: help tags"),
			},
			{
				"<leader>ch",
				"<cmd>lua require('telescope.builtin').command_history()<cr>",
				desc = desc("telescope: command history"),
			},
			{
				"<leader>sh",
				"<cmd>lua require('telescope.builtin').search_history()<cr>",
				desc = desc("telescope: search history"),
			},
			{
				"<leader>fc",
				"<cmd>lua require('telescope.builtin').commands()<cr>",
				desc = desc("telescope: commands"),
			},
			{ "<leader>km", "<cmd>lua require('telescope.builtin').keymaps()<cr>", desc = desc("telescope: keymaps") },
			{
				"<leader>tr",
				function()
					require("telescope.builtin").resume({ initial_mode = "normal" })
				end,
				desc = desc("telescope: resume"),
			},
			{
				"<leader>ds",
				function()
					require("telescope.builtin").lsp_document_symbols()
				end,
				desc = desc("telescope: lsp document symbols"),
			},
			{
				"<leader>ws",
				":Telescope lsp_dynamic_workspace_symbols<cr>",
				desc = "telescope: lsp dynamic workspace symbols",
				silent = false,
			},
		},
	},
	{
		"nvim-telescope/telescope-symbols.nvim",
		keys = {
			{ "<leader>ts", "<cmd>Telescope symbols<cr>" },
		},
	},
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
		config = function()
			require("telescope").load_extension("fzf")
		end,
	},
	{
		"nvim-telescope/telescope-file-browser.nvim",
		dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
		config = function()
			local fb = require("telescope").extensions.file_browser

			require("telescope").setup({
				extensions = {
					file_browser = {
						initial_mode = "normal",
						-- disables netrw and use telescope-file-browser in its place
						hijack_netrw = true,
						mappings = {
							["n"] = {
								["a"] = fb.actions.create,
								["r"] = fb.actions.rename,
								["x"] = fb.actions.move,
								["c"] = fb.actions.copy,
								["d"] = fb.actions.remove,
								["o"] = fb.actions.open,
								["h"] = fb.actions.goto_parent_dir,
								["t"] = fb.actions.toggle_browser,
							},
						},
					},
				},
			})

			require("telescope").load_extension("file_browser")
		end,
		keys = {
			{
				"<leader>ff",
				function()
					local fb = require("telescope").extensions.file_browser
					fb.file_browser({ path = "%:h", hidden = true, hide_parent_dir = true })
				end,
			},
		},
	},
	{
		"fdschmidt93/telescope-egrepify.nvim",
		dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
		config = function()
			require("telescope").load_extension("egrepify")
		end,
		keys = {
			{
				"<leader>rg",
				function()
					require("telescope").extensions.egrepify.egrepify({})
				end,
			},
		},
	},
}
