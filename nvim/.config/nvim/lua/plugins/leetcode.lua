local leet_arg = "lc"
return {
	"kawre/leetcode.nvim",
	build = ":TSUpdate html",
	lazy = leet_arg ~= vim.fn.argv()[1],
	opts = { arg = leet_arg, lang = "javascript", image_support = not is_work_profile() },
	keys = {
		{ "<leader>ll", "<cmd>Leet list<cr>", desc = desc("leetcode: list") },
		{ "<leader>lt", "<cmd>Leet test<cr>", desc = desc("leetcode: test") },
		{
			"<leader>lT",
			function()
				vim.cmd("w")
				vim.cmd("vsplit term://node %")
			end,
			desc = desc("leetcode: test"),
		},
		{ "<leader>lc", "<cmd>Leet console<cr>", desc = desc("leetcode: console") },
		{ "<leader>lo", "<cmd>Leet open<cr>", desc = desc("leetcode: open") },
		{ "<leader>ly", "<cmd>Leet yank<cr>", desc = desc("leetcode: yank") },
		{ "<leader>le", "<cmd>Leet desc<cr>", desc = desc("leetcode: yank") },
		{ "<leader>ls", "<cmd>Leet submit<cr>", desc = desc("leetcode: submit") },
	},
	dependencies = {
		"MunifTanjim/nui.nvim",
		{
			"vhyrro/luarocks.nvim",
			priority = 1001, -- this plugin needs to run before anything else
			opts = {
				rocks = { "magick" },
			},
		},
		{
			"3rd/image.nvim",
			cond = function()
				return not is_work_profile()
			end,
			config = function()
				-- default config
				require("image").setup({
					backend = "ueberzug",
					integrations = {
						markdown = {
							enabled = true,
							clear_in_insert_mode = false,
							download_remote_images = true,
							only_render_image_at_cursor = false,
							filetypes = { "markdown", "vimwiki" }, -- markdown extensions (ie. quarto) can go here
						},
						neorg = {
							enabled = true,
							clear_in_insert_mode = false,
							download_remote_images = true,
							only_render_image_at_cursor = false,
							filetypes = { "norg" },
						},
						html = {
							enabled = false,
						},
						css = {
							enabled = false,
						},
					},
					max_width = nil,
					max_height = nil,
					max_width_window_percentage = nil,
					max_height_window_percentage = 50,
					window_overlap_clear_enabled = true, -- toggles images when windows are overlapped
					window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
					editor_only_render_when_focused = false, -- auto show/hide images when the editor gains/looses focus
					tmux_show_only_in_active_window = false, -- auto show/hide images in the correct Tmux window (needs visual-activity off)
					hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.avif" }, -- render image files as images when opened
				})
			end,
		},
	},
}
