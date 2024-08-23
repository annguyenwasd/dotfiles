return {
	"jghauser/mkdir.nvim",

	{ "godlygeek/tabular", cmd = "Tabularize" },
	{
		"szw/vim-maximizer",
		keys = {
			{ "<leader>mm", ":MaximizerToggle<cr>", desc = desc("utils: toggle maximizer") },
		},
	},
	{
		"romainl/vim-cool", -- show highlight when search
		enabled = false,
		init = function()
			vim.g.CoolTotalMatches = 1
		end,
	},
	{
		"airblade/vim-rooter",
		cmd = "Rooter",
		init = function()
			vim.g.rooter_patterns = { ".git" }
			vim.g.rooter_manual_only = 1
		end,
	},
	{
		"mbbill/undotree",
		keys = {
			{ "<leader>u", ":UndotreeShow<cr>", desc = desc("utils: toggle Undotree") },
		},
	},
	{
		"skywind3000/asyncrun.vim",
		cmd = "AsyncRun",
		init = function()
			vim.g.asyncrun_open = 10
		end,
	},
	{
		"will133/vim-dirdiff",
		cmd = "DirDiff",
		init = function()
			vim.g.DirDiffExcludes =
				".git,personal.*,.DS_Store,**/packer_compiled.lua,**/*.add,**/*.spl,*.png,*.jpg,*.jpeg,Session.vim,*/state.yml,plugin/*,spell/*,node_modules/*,*node_modules*"
		end,
	},
	{
		"norcalli/nvim-colorizer.lua",
		event = "BufReadPost",
		config = function()
			require("colorizer").setup()
		end,
	},
	{
		"Wansmer/treesj",
		config = function()
			require("treesj").setup({ use_default_keymaps = false, max_join_length = 99999999 })
		end,
		keys = {
			{
				"gst",
				function()
					require("treesj").toggle()
				end,
				desc = desc("treejs: toggle join/split"),
			},
			{
				"gss",
				function()
					require("treesj").split()
				end,
				desc = desc("treejs: split lines"),
			},
			{
				"gsj",
				function()
					require("treesj").join()
				end,
				desc = desc("treejs: join lines"),
			},
		},
	},
	{
		"nvim-tree/nvim-web-devicons",
		event = "VeryLazy",
		cond = is_use_icons,
		config = function()
			require("nvim-web-devicons").setup({
				override = {
					typescriptreact = {
						icon = "",
						color = "#519aba",
						name = "Tsx",
					},
					javascriptreact = {
						icon = "",
						color = "#519aba",
						name = "Jsx",
					},
					typescript = {
						icon = "",
						color = "#519aba",
						name = "Ts",
					},
					javascript = {
						icon = "",
						color = "#519ada",
						name = "Js",
					},
				},
				default = true,
			})
		end,
	},
	{
		"christoomey/vim-tmux-navigator",
		init = function()
			vim.g.tmux_navigator_disable_when_zoomed = 1
		end,
	},
	{
		"sontungexpt/url-open",
		cmd = "URLOpenUnderCursor",
		config = function()
			local status_ok, url_open = pcall(require, "url-open")
			if not status_ok then
				return
			end
			url_open.setup({})
		end,
		keys = {
			{
				"<leader>gh",
				"<cmd>URLOpenUnderCursor<cr>",
				desc = desc("Open url/githut repo under cursor"),
			},
		},
	},
	{
		"andymass/vim-matchup",
		event = "BufReadPost",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
		init = function()
			vim.g.matchup_surround_enabled = 1
		end,
		config = function()
			require("nvim-treesitter.configs").setup({
				matchup = {
					enable = true,
				},
			})
		end,
	},
	{
		"zdcthomas/yop.nvim",
		event = "BufReadPost",
		config = function()
			require("yop").op_map({ "n", "v" }, "<leader>Rg", function(lines, info)
				require("telescope.builtin").grep_string({ search = lines[1] })
			end, { desc = desc("Telescope: Grep string with motion") })
		end,
	},
	{
		"folke/zen-mode.nvim",
		cmd = "ZenMode",
		opts = {},
		keys = {
			{ "<leader>cc", "<cmd>ZenMode<cr>", desc = desc("Toggle zen mode") },
		},
	},
	{
		"michaelb/sniprun",
		build = "sh ./install.sh 1",
		opts = {
			display = {
				"VirtualText",
			},
		},
		keys = {
			{
				mode = { "n", "v" },
				"<leader>sr",
				"<cmd>SnipRun<cr>",
				desc = desc("Run current line/visual"),
			},
		},
	},
	{
		"cappyzawa/trim.nvim",
		cmd = { "Trim", "TrimToggle" },
		event = "BufWritePre",
		opts = {},
	},
}
