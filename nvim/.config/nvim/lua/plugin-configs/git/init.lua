-- ╭──────────────────────────────────────────────────────────╮
-- │                  kdheepak/lazygit.nvim                   │
-- ╰──────────────────────────────────────────────────────────╯
vim.g.lazygit_floating_window_winblend = 0
vim.g.lazygit_floating_window_scaling_factor = 1
vim.keymap.set("n", "<leader>lg", "<cmd>LazyGit<cr>")
-- Not gonna show shit messages when run git hook via husky
vim.g.fugitive_pty = 0

-- ╭──────────────────────────────────────────────────────────╮
-- │                    tpope/vim-fugitive                    │
-- ╰──────────────────────────────────────────────────────────╯
vim.api.nvim_create_autocmd("BufReadPost", {
	group = vim.api.nvim_create_augroup("FugitiveAutoCleanBuffer", { clear = true }),
	pattern = "fugitive://*",
	command = "set bufhidden=delete",
})

local function vsplitCommit()
	vim.cmd("split term://git commit|:startinsert")
end

vim.keymap.set("n", "<leader>gf", "<cmd>diffget //2 <cr> <cmd>w <cr> <cmd>diffupdate <cr>")
vim.keymap.set("n", "<leader>gj", "<cmd>diffget //3 <cr> <cmd>w <cr> <cmd>diffupdate <cr>")
vim.keymap.set("n", "<leader>gL", "<cmd>GcLog<cr>")
vim.keymap.set("n", "<leader>gs", "<cmd>G difftool --name-status<cr>")
vim.keymap.set("n", "<leader><leader>gs", "<cmd>G difftool<cr>")
vim.keymap.set("n", "<leader><leader>bl", "<cmd>G blame<cr>")
vim.keymap.set("n", "<leader>gc", vsplitCommit)
vim.keymap.set("n", "<leader><leader>gc", ':G commit -m ""<left>', { silent = false })
vim.keymap.set("n", "<leader>ga", "<cmd>G add -A<cr>")
vim.keymap.set("n", "<leader>gw", '<cmd>G add -A <bar>G commit -n -m "WIP"<cr>')
vim.keymap.set(
	"n",
	"gpp",
	":AsyncRun git push -u origin $(git rev-parse --abbrev-ref HEAD) --force-with-lease<cr>",
	{ silent = false }
)
vim.keymap.set(
	"n",
	"gpt",
	":AsyncRun git push -u origin $(git rev-parse --abbrev-ref HEAD) --force-with-lease --follow-tags<cr>",
	{ silent = false }
)

-- ╭──────────────────────────────────────────────────────────╮
-- │                 lewis6991/gitsigns.nvim                  │
-- ╰──────────────────────────────────────────────────────────╯
require("gitsigns").setup({
	on_attach = function(bufnr)
		local gs = package.loaded.gitsigns

		local function map(mode, l, r, opts)
			opts = opts or {}
			opts.buffer = bufnr
			vim.keymap.set(mode, l, r, opts)
		end

		-- Navigation
		map("n", "]c", function()
			if vim.wo.diff then
				return "]c"
			end
			vim.schedule(function()
				gs.next_hunk()
			end)
			return "<Ignore>"
		end, { expr = true })

		map("n", "[c", function()
			if vim.wo.diff then
				return "[c"
			end
			vim.schedule(function()
				gs.prev_hunk()
			end)
			return "<Ignore>"
		end, { expr = true })

		-- Actions
		map({ "n", "v" }, "<leader>ha", ":Gitsigns stage_hunk<CR>")
		map({ "n", "v" }, "<leader>hd", ":Gitsigns reset_hunk<CR>")
		map("n", "<leader>hA", gs.stage_buffer)
		map("n", "<leader>hu", gs.undo_stage_hunk)
		map("n", "<leader>hD", gs.reset_buffer)
		map("n", "<leader>hc", gs.preview_hunk)
		map("n", "<leader>bl", function()
			gs.blame_line({ full = true })
		end)
		map("n", "<leader>tb", gs.toggle_current_line_blame)
		map("n", "<leader>td", gs.toggle_deleted)

		-- Text object
		map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
	end,
})

--  ╭──────────────────────────────────────────────────────────╮
--  │              ThePrimeagen/git-worktree.nvim              │
--  ╰──────────────────────────────────────────────────────────╯
require("telescope").load_extension("git_worktree")
vim.keymap.set("n", "<leader>wt", require("telescope").extensions.git_worktree.git_worktrees)
vim.keymap.set("n", "<leader>wT", require("telescope").extensions.git_worktree.create_git_worktree)
vim.keymap.set("n", "<leader>WT", function()
	vim.ui.input({ prompt = "Branch name: " }, function(branch_name)
		if branch_name and string.len(branch_name) > 0 then
			require("git-worktree").create_worktree(branch_name, branch_name, "origin")
		end
	end)
end)
