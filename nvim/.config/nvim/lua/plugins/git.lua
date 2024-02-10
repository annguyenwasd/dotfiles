return {
	{
		"kdheepak/lazygit.nvim",
		init = function()
			vim.g.lazygit_floating_window_winblend = 0
			vim.g.lazygit_floating_window_scaling_factor = 1
		end,
		keys = {
			{ "<leader>lg", "<cmd>LazyGit<cr>", desc = make_desc("git: open lazy git") },
		},
	},

	{
		"tpope/vim-fugitive",
		lazy = false,
		init = function()
			vim.api.nvim_create_autocmd("BufReadPost", {
				group = vim.api.nvim_create_augroup("FugitiveAutoCleanBuffer", { clear = true }),
				pattern = "fugitive://*",
				command = "set bufhidden=delete",
			})

			-- Not gonna show shit messages when run git hook via husky
			vim.g.fugitive_pty = 0
		end,
		cmd = "G",
		keys = {
			{
				"<leader>gf",
				"<cmd>diffget //2 <cr> <cmd>w <cr> <cmd>diffupdate <cr>",
				desc = make_desc("git: select left"),
			},
			{
				"<leader>gj",
				"<cmd>diffget //3 <cr> <cmd>w <cr> <cmd>diffupdate <cr>",
				desc = make_desc("git: select right"),
			},
			{ "<leader>gL", "<cmd>GcLog<cr>", desc = make_desc("git: fugitive: show log") },
			{
				"<leader>gs",
				"<cmd>G difftool --name-status<cr>",
				desc = make_desc("git: show list of changed files in quickfix list"),
			},
			{
				"<leader><leader>gs",
				"<cmd>G difftool<cr>",
				desc = make_desc("git: show all changes by line in quickfix list"),
			},
			{ "<leader><leader>bl", "<cmd>G blame<cr>", desc = make_desc("git: show all lines blame") },
			{
				"<leader>gc",
				function()
					vim.cmd("split term://git commit|:startinsert")
				end,
				desc = make_desc("git: commit by built-in terminal"),
			},
			{
				"<leader><leader>gc",
				':G commit -m ""<left>',
				silent = false,
				desc = make_desc("git: commit with custom message"),
			},
			{ "<leader>ga", "<cmd>G add -A<cr>", desc = make_desc("git: quick add all files to stageing area") },
			{
				"<leader>gw",
				'<cmd>G add -A <bar>G commit -n -m "WIP"<cr>',
				desc = make_desc("git: add new WIP commit"),
			},
			{
				"gpp",
				":AsyncRun git push -u origin $(git rev-parse --abbrev-ref HEAD) --force-with-lease<cr>",
				silent = false,
				desc = make_desc("git: push to origin"),
			},
			{
				"gpt",
				":AsyncRun git push -u origin $(git rev-parse --abbrev-ref HEAD) --force-with-lease --follow-tags<cr>",
				silent = false,
				desc = make_desc("git: push to origin with tags"),
			},
		},
	},

	{
		"lewis6991/gitsigns.nvim",
		lazy = false,
		config = function()
			require("gitsigns").setup({
				auto_attach = true,
				attach_to_untracked = true,
				on_attach = function(bufnr)
					local gs = package.loaded.gitsigns

					local get_opts = make_on_attach_opts(bufnr)

					-- Navigation
					vim.keymap.set("n", "]c", function()
						if vim.wo.diff then
							return "]c"
						end
						vim.schedule(function()
							gs.next_hunk()
						end)
						return "<Ignore>"
					end, get_opts({ expr = true, desc = make_desc("git: next change") }))

					vim.keymap.set("n", "[c", function()
						if vim.wo.diff then
							return "[c"
						end
						vim.schedule(function()
							gs.prev_hunk()
						end)
						return "<Ignore>"
					end, get_opts({ expr = true, desc = make_desc("git: prev change") }))

					-- Actions
					vim.keymap.set(
						{ "n", "v" },
						"<leader>ha",
						":Gitsigns stage_hunk<CR>",
						get_opts("git: add hunk to staging area")
					)

					vim.keymap.set(
						{ "n", "v" },
						"<leader>hd",
						":Gitsigns reset_hunk<CR>",
						get_opts("git: remove hunk from strging area")
					)

					vim.keymap.set("n", "<leader>hA", gs.stage_buffer, get_opts("git: add whole file to staging area"))

					vim.keymap.set(
						"n",
						"<leader>hu",
						gs.undo_stage_hunk,
						get_opts("git: remove whole file from staging area")
					)

					vim.keymap.set("n", "<leader>hD", gs.reset_buffer, get_opts("git: reset file to index"))
					vim.keymap.set("n", "<leader>hc", gs.preview_hunk, get_opts("git: preview hunk"))

					vim.keymap.set("n", "<leader>bl", function()
						gs.blame_line({ full = true })
					end, get_opts("git: show gitsign blame"))

					vim.keymap.set("n", "<leader>tb", gs.toggle_current_line_blame, get_opts("git: toggle line blame"))
					vim.keymap.set("n", "<leader>td", gs.toggle_deleted, get_opts("git: toggle deleted"))

					vim.keymap.set(
						{ "o", "x" },
						"ih",
						":<C-U>Gitsigns select_hunk<CR>",
						get_opts("git: textobject select hunk")
					)
				end,
			})
		end,
	},

	{
		"tpope/vim-rhubarb",
		init = function()
			if is_work_profile() then
				vim.g.github_enterprise_urls = require("work").github_enterprise_urls
			end
		end,
	},
}
