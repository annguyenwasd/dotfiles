return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-telescope/telescope-symbols.nvim",
		},
		lazy = false,
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
						"--hidden",
						"--with-filename",
						"--line-number",
						"--column",
						"--smart-case",
						"-u", -- thats the new thing
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
						hide_on_startup = false,
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
			vim.keymap.set("n", "gcoo", builtin.git_branches, make_mapping_opts("telescope: git branches"))
			vim.keymap.set("n", "<leader>gl", builtin.git_commits, make_mapping_opts("telescope: git commits"))
			vim.keymap.set("n", "<leader>bgl", builtin.git_bcommits, make_mapping_opts("telescope: git bcommits"))
			vim.keymap.set("n", "<leader>bgl", builtin.git_bcommits, make_mapping_opts("telescope: git bcommits"))
			vim.keymap.set("n", "<localleader>gh", builtin.git_stash, make_mapping_opts("telescope: git stash"))

			vim.keymap.set("n", "<leader>tr", function()
				builtin.resume({ initial_mode = "normal" })
			end, make_mapping_opts("telescope: resume"))

			vim.keymap.set("n", "gr", function()
				builtin.lsp_references({ initial_mode = "normal" })
			end, make_mapping_opts("telescope: lsp references"))

			vim.keymap.set("n", "gi", function()
				builtin.lsp_implementations({ initial_mode = "normal" })
			end, make_mapping_opts("telescope: lsp implementations"))

			vim.keymap.set("n", "gy", function()
				builtin.lsp_type_definitions({ initial_mode = "normal" })
			end, make_mapping_opts("telescope: lsp type definitions"))

			vim.keymap.set("n", "<leader>da", function()
				builtin.diagnostics({ initial_mode = "normal", bufnr = 0 })
			end, make_mapping_opts("telescope: diagnostics"))

			vim.keymap.set("n", "<leader><leader>da", function()
				builtin.diagnostics({ initial_mode = "normal" })
			end, make_mapping_opts("telescope: diagnostics"))

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
			--[[ "<leader>rg", ]]
			"<leader>fh",
			"<leader>ch",
			"<leader>sh",
			"<leader>fc",
			"<leader><leader>fc",
			"<leader>km",
			"<leader>hi",
			"<leader>gS",
			"gcoo",
			"<leader>gl",
			"<leader>bgl",
			"<leader>bgl",
			"<localleader>gh",
			"<leader>tr",
			"gr",
			"gi",
			"gy",
			"<leader>da",
			"<leader><leader>da",
			"<leader>ds",
			"<leader>ws",
			{ "<leader>ts", "<cmd>Telescope symbols<cr>" },
		},
	},

	{
		"nvim-telescope/telescope-fzf-native.nvim",
		lazy = true,
		build = "make",
		config = function()
			require("telescope").setup({
				extensions = {
					fzf = {
						fuzzy = true, -- false will only do exact matching
						override_generic_sorter = true, -- override the generic sorter
						override_file_sorter = true, -- override the file sorter
						case_mode = "smart_case", -- or "ignore_case" or "respect_case", the default case_mode is "smart_case"
					},
					--
				},
			})
		end,
	},
	{
		"nvim-telescope/telescope-file-browser.nvim",
		config = function()
			local fb = require("telescope").extensions.file_browser

			require("telescope").setup({
				extensions = {
					file_browser = {
						initial_mode = "normal",
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
		lazy = false,
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
