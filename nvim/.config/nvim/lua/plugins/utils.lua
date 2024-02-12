return {
	"cappyzawa/trim.nvim",
	"godlygeek/tabular",
	"jghauser/mkdir.nvim",
	"ThePrimeagen/vim-be-good",
	"nvim-lua/plenary.nvim",
	"nvim-lua/popup.nvim",

	{
		"szw/vim-maximizer",
		keys = {
			{ "<leader>mm", ":MaximizerToggle<cr>", desc = make_desc("toggle maximizer") },
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
			{ "<leader>cc", ":NoNeckPain<cr>", desc = make_desc("toggle NoNeckPain") },
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
			{ "<leader>u", ":UndotreeShow<cr>", desc = make_desc("toggle Undotree") },
		},
	},

	{
		"ThePrimeagen/harpoon",
    event="VeryLazy",
		config = function()
			require("harpoon").setup({ menu = { width = 120, height = 30 } })
			local ui = require("harpoon.ui")

			vim.keymap.set(
				"n",
				"ma",
				require("harpoon.mark").add_file,
				make_mapping_opts("harpoon: add file to harpoon list")
			)

			vim.keymap.set("n", "'1", function()
				ui.nav_file(1)
			end, make_mapping_opts("harpoon: navigate to file #1"))

			vim.keymap.set("n", "'2", function()
				ui.nav_file(2)
			end, make_mapping_opts("harpoon: navigate to file #2"))

			vim.keymap.set("n", "'3", function()
				ui.nav_file(3)
			end, make_mapping_opts("harpoon: navigate to file #3"))

			vim.keymap.set("n", "'4", function()
				ui.nav_file(4)
			end, make_mapping_opts("harpoon: navigate to file #4"))

			vim.keymap.set("n", "'5", function()
				ui.nav_file(5)
			end, make_mapping_opts("harpoon: navigate to file #5"))

			vim.keymap.set("n", "'6", function()
				ui.nav_file(6)
			end, make_mapping_opts("harpoon: navigate to file #6"))

			vim.keymap.set("n", "'7", function()
				ui.nav_file(7)
			end, make_mapping_opts("harpoon: navigate to file #7"))

			vim.keymap.set("n", "'8", function()
				ui.nav_file(8)
			end, make_mapping_opts("harpoon: navigate to file #8"))

			vim.keymap.set("n", "'9", function()
				ui.nav_file(9)
			end, make_mapping_opts("harpoon: navigate to file #9"))

			vim.keymap.set("n", "mq", ui.toggle_quick_menu, make_mapping_opts("harpoon: show list of bookmarks"))
		end,
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
		config = true,
		lazy = false,
		keys = {
			{ "g?d", ":lua require('debugprint').deleteprints()<cr>", desc = "log debug line" },
		},
	},

	{
		"Wansmer/treesj",
		config = function()
			require("treesj").setup({ use_default_keymaps = false, max_join_length = 99999999 })
			vim.keymap.set("n", "gst", require("treesj").toggle, make_mapping_opts("treejs: toggle join/split"))
			vim.keymap.set("n", "gss", require("treesj").split, make_mapping_opts("treejs: split lines"))
			vim.keymap.set("n", "gsj", require("treesj").join, make_mapping_opts("treejs: join lines"))
		end,
		keys = {
			"gst",
			"gss",
			"gsj",
		},
	},

	{
		"phaazon/mind.nvim",
		branch = "v2.2",
		config = function()
			require("mind").setup()

			vim.keymap.set(
				"n",
				"<leader>mi",
				require("mind").open_project,
				make_mapping_opts("mind: toggle local notes")
			)

			vim.keymap.set("n", "<leader><leader>mi", function()
				require("mind").open_project({ use_global = true })
			end, make_mapping_opts("mind: toggle global notes"))

			vim.keymap.set("n", "<leader>mI", require("mind").close, make_mapping_opts("mind: close mind"))
		end,
		keys = {
			"<leader>mI",
			"<leader><leader>mi",
			"<leader>mi",
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
		"rmagatti/auto-session",
		config = function()
			require("auto-session").setup({
				log_level = "error",
				auto_session_suppress_dirs = { "~/", "~/workspace", "~/Downloads", "/" },
			})
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
				"<leader>gu",
				"<cmd>URLOpenUnderCursor<cr>",
			},
		},
	},
}
