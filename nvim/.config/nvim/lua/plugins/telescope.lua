return {
	{
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
							["l"] = actions.select_default,
						},
					},
				},
			})

			local builtin = require("telescope.builtin")

			vim.keymap.set(
				"n",
				"<leader>o",
				require("utils.nvim-tree").find_files,
				make_mapping_opts("telescope: find files")
			)

			vim.keymap.set("n", "<leader>O", function()
				builtin.find_files({ no_ignore = true, no_ignore_parent = true, hidden = true })
			end, make_mapping_opts("telescope: find files with ignored files"))

			vim.keymap.set("n", "<leader>i", function()
				builtin.buffers({ sort_rmu = true, sort_lastused = true, show_all_buffers = true })
			end, make_mapping_opts("telescope: show opened buffers"))

			vim.keymap.set(
				"n",
				"<leader>/",
				builtin.current_buffer_fuzzy_find,
				make_mapping_opts("telescope: current buffer fuzzy find")
			)

			vim.keymap.set(
				"n",
				"<leader><leader>fc",
				require("utils.theme-chooser"),
				make_mapping_opts("telescope: theme chooser")
			)

			--[[ vim.keymap.set("n", "<leader>rg", builtin.live_grep, make_mapping_opts("telescope: live grep")) ]]
			vim.keymap.set("n", "<leader>fh", builtin.help_tags, make_mapping_opts("telescope: help tags"))
			vim.keymap.set("n", "<leader>ch", builtin.command_history, make_mapping_opts("telescope: command history"))
			vim.keymap.set("n", "<leader>sh", builtin.search_history, make_mapping_opts("telescope: search history"))
			vim.keymap.set("n", "<leader>fc", builtin.commands, make_mapping_opts("telescope: commands"))
			vim.keymap.set("n", "<leader>km", builtin.keymaps, make_mapping_opts("telescope: keymaps"))
			vim.keymap.set("n", "<leader>hi", builtin.highlights, make_mapping_opts("telescope: highlights"))
			vim.keymap.set("n", "<leader>gS", builtin.git_status, make_mapping_opts("telescope: git status"))
			vim.keymap.set("n", "<leader>gl", builtin.git_commits, make_mapping_opts("telescope: git commits"))
			vim.keymap.set("n", "<leader>bgl", builtin.git_bcommits, make_mapping_opts("telescope: git bcommits"))
			vim.keymap.set("n", "<leader>bgl", builtin.git_bcommits, make_mapping_opts("telescope: git bcommits"))
			vim.keymap.set("n", "<localleader>gh", builtin.git_stash, make_mapping_opts("telescope: git stash"))

			vim.keymap.set("n", "<leader>tr", function()
				builtin.resume({ initial_mode = "normal" })
			end, make_mapping_opts("telescope: resume"))

			vim.keymap.set("n", "<leader>ds", function()
				builtin.lsp_document_symbols()
			end, make_mapping_opts("telescope: lsp document symbols"))

			vim.keymap.set(
				"n",
				"<leader>ws",
				":Telescope lsp_dynamic_workspace_symbols<cr>",
				make_mapping_opts("telescope: lsp dynamic workspace symbols", { silent = false })
			)
		end,
		keys = {
			"<leader>o",
			"<leader>O",
			"<leader>i",
			"<leader>/",
			"<leader>fh",
			"<leader>ch",
			"<leader>sh",
			"<leader>fc",
			"<leader><leader>fc",
			"<leader>km",
			"<leader>hi",
			"<leader>gS",
			"<leader>gl",
			"<leader>bgl",
			"<leader>bgl",
			"<localleader>gh",
			"<leader>tr",
			"<leader>ds",
			"<leader>ws",
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
