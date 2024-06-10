return {
	"cappyzawa/trim.nvim",
	"godlygeek/tabular",
	"jghauser/mkdir.nvim",
	"nvim-lua/plenary.nvim",
	"nvim-lua/popup.nvim",

	{
		"szw/vim-maximizer",
		keys = {
			{ "<leader>mm", ":MaximizerToggle<cr>", desc = desc("utils: toggle maximizer") },
		},
	},
	{
		"shortcuts/no-neck-pain.nvim",
		config = function()
			require("no-neck-pain").setup({
				width = 120,
				mappings = {
					enabled = false,
				},
			})
		end,
		keys = {
			{ "<leader>cc", ":NoNeckPain<cr>", desc = desc("utils: toggle NoNeckPain") },
		},
	},
	{
		"romainl/vim-cool", -- show highlight when search
		init = function()
			vim.g.CoolTotalMatches = 1
		end,
	},
	{
		"airblade/vim-rooter",
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
		"ThePrimeagen/harpoon",
		keys = {
			{
				"ma",
				function()
					require("harpoon.mark").add_file()
				end,
				desc = desc("harpoon: add file to harpoon list"),
			},
			{
				"mq",
				function()
					require("harpoon.ui").toggle_quick_menu()
				end,
				desc = desc("harpoon: show list of bookmarks"),
			},
			{
				"'1",
				function()
					require("harpoon.ui").nav_file(1)
				end,
				desc = desc("harpoon: navigate to file #1"),
			},
			{
				"'2",
				function()
					require("harpoon.ui").nav_file(2)
				end,
				desc = desc("harpoon: navigate to file #2"),
			},
			{
				"'3",
				function()
					require("harpoon.ui").nav_file(3)
				end,
				desc = desc("harpoon: navigate to file #3"),
			},
			{
				"'4",
				function()
					require("harpoon.ui").nav_file(4)
				end,
				desc = desc("harpoon: navigate to file #4"),
			},
			{
				"'5",
				function()
					require("harpoon.ui").nav_file(5)
				end,
				desc = desc("harpoon: navigate to file #5"),
			},
			{
				"'6",
				function()
					require("harpoon.ui").nav_file(6)
				end,
				desc = desc("harpoon: navigate to file #6"),
			},
			{
				"'7",
				function()
					require("harpoon.ui").nav_file(7)
				end,
				desc = desc("harpoon: navigate to file #7"),
			},
			{
				"'8",
				function()
					require("harpoon.ui").nav_file(8)
				end,
				desc = desc("harpoon: navigate to file #8"),
			},
			{
				"'9",
				function()
					require("harpoon.ui").nav_file(9)
				end,
				desc = desc("harpoon: navigate to file #9"),
			},
		},
	},
	{
		"skywind3000/asyncrun.vim",
		init = function()
			vim.cmd([[
        augroup local-asyncrun
          au!
          au User AsyncRunStop copen | wincmd p
        augroup END
     ]])
		end,
	},
	{
		"will133/vim-dirdiff",
		init = function()
			vim.g.DirDiffExcludes =
				".git,personal.*,.DS_Store,**/packer_compiled.lua,**/*.add,**/*.spl,*.png,*.jpg,*.jpeg,Session.vim,*/state.yml,plugin/*,spell/*"
		end,
	},
	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
	},
	{
		"andrewferrier/debugprint.nvim",
		event = "VeryLazy",
		config = true,
		keys = {
			{ "g?d", ":lua require('debugprint').deleteprints()<cr>", desc = "log debug line" },
		},
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
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		ft = { "markdown" },
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
	},
	{
		"nvim-tree/nvim-web-devicons",
		enabled = is_use_icons,
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
		event = "VeryLazy",
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
			},
		},
	},
	{
		"andymass/vim-matchup",
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
		config = function()
			require("yop").op_map({ "n", "v" }, "<leader>Rg", function(lines, info)
				require("telescope.builtin").grep_string({ search = lines[1] })
			end)
		end,
	},
}
