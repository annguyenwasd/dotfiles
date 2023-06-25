return function()
	local actions = require("telescope.actions")
	local actions_layout = require("telescope.actions.layout")

	-- Falling back to find_files if git_files can't find a .git directory
	local function project_files(opts)
		opts = opts or {}
		local ok =
			pcall(require("telescope.builtin").git_files, vim.tbl_extend("force", { show_untracked = true }, opts))
		if not ok then
			require("telescope.builtin").find_files(vim.tbl_extend("force", { hidden = true }, opts))
		end
	end

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

	vim.keymap.set("n", "<leader>o", project_files)
	vim.keymap.set("n", "<leader>O", function()
		builtin.find_files({ no_ignore = true, no_ignore_parent = true, hidden = true })
	end)
	vim.keymap.set("n", "<leader>i", function()
		builtin.buffers({ sort_rmu = true, sort_lastused = true, show_all_buffers = true })
	end)
	vim.keymap.set("n", "<leader>/", builtin.current_buffer_fuzzy_find)
	vim.keymap.set("n", "<leader>rg", builtin.live_grep)
	vim.keymap.set("n", "<leader>fh", builtin.help_tags)
	vim.keymap.set("n", "<leader>ch", builtin.command_history)
	vim.keymap.set("n", "<leader>sh", builtin.search_history)
	vim.keymap.set("n", "<leader>fc", builtin.commands)
	vim.keymap.set("n", "<leader><leader>fc", require("plugin-configs.telescope-config.theme"))
	vim.keymap.set("n", "<leader>km", builtin.keymaps)
	vim.keymap.set("n", "<leader>hi", builtin.highlights)
	vim.keymap.set("n", "<leader>gS", builtin.git_status)
	vim.keymap.set("n", "gcoo", builtin.git_branches)
	vim.keymap.set("n", "<leader>gl", builtin.git_commits)
	vim.keymap.set("n", "<leader>bgl", builtin.git_bcommits)
	vim.keymap.set("n", "<leader>bgl", builtin.git_bcommits)
	vim.keymap.set("n", "<leader>gh", builtin.git_stash)

	vim.keymap.set("n", "<leader>tr", function()
		builtin.resume({ initial_mode = "normal" })
	end)

	vim.keymap.set("n", "gr", function()
		builtin.lsp_references({ initial_mode = "normal" })
	end)

	-- vim.keymap.set("n", "gd", function()
	--     builtin.lsp_definitions({initial_mode = 'normal'})
	-- end)
	vim.keymap.set("n", "gi", function()
		builtin.lsp_implementations({ initial_mode = "normal" })
	end)

	vim.keymap.set("n", "gy", function()
		builtin.lsp_type_definitions({ initial_mode = "normal" })
	end)

	vim.keymap.set("n", "<leader>da", function()
		builtin.diagnostics({ initial_mode = "normal", bufnr = 0 })
	end)

	vim.keymap.set("n", "<leader><leader>da", function()
		builtin.diagnostics({ initial_mode = "normal" })
	end)

	vim.keymap.set("n", "<leader>ds", function()
		builtin.lsp_document_symbols()
	end)

	vim.keymap.set("n", "<leader>ws", ":Telescope lsp_dynamic_workspace_symbols<cr>", { silent = false })

	-- ╭──────────────────────────────────────────────────────────╮
	-- │         nvim-telescope/telescope-fzf-native.nvim         │
	-- ╰──────────────────────────────────────────────────────────╯

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

	-- To get fzf loaded and working with telescope, you need to call
	-- load_extension, somewhere after setup function:
	--[[ require("telescope").load_extension("fzf") ]]

	-- ╭──────────────────────────────────────────────────────────╮
	-- │          nvim-telescope/telescope-symbols.nvim           │
	-- ╰──────────────────────────────────────────────────────────╯

	vim.keymap.set("n", "<leader>ts", "<cmd>Telescope symbols<cr>")

	-- ╭──────────────────────────────────────────────────────────╮
	-- │        nvim-telescope/telescope-file-browser.nvim        │
	-- ╰──────────────────────────────────────────────────────────╯

	-- To get telescope-file-browser loaded and working with telescope,
	-- you need to call load_extension, somewhere after setup function:

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

	vim.keymap.set("n", "<leader>ff", function()
		fb.file_browser({ path = "%:h", hidden = true, hide_parent_dir = true })
	end)
end
