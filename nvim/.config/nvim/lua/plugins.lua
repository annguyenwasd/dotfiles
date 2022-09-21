-- {{{ Boostrap & Packer Start
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	packer_bootstrap = vim.fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
end

require("packer").startup(function(use)
	-- }}}

	-- {{{ Required Dependencies
	use({ "nvim-lua/popup.nvim" })
	use({ "nvim-lua/plenary.nvim" })
	use({ "wbthomason/packer.nvim" })
	-- }}}

	-- {{{ Treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
		config = function()
			require("nvim-treesitter.configs").setup({
				highlight = { enable = true },
			})
		end,
		run = ":TSUpdate",
	})
	--}}}

	-- {{{ Telescope
	use({
		"nvim-telescope/telescope.nvim",
		requires = {
			"nvim-telescope/telescope-file-browser.nvim",
			"nvim-telescope/telescope-symbols.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				run = "make",
			},
		},
		config = require("plugin-configs.telescope"),
	})
	-- }}}

	-- {{{ Lualine
	use({
		"nvim-lualine/lualine.nvim",
		config = require("plugin-configs.lualine.mine"),
	})

	-- }}}

	-- {{{ LSP
	use({
		"williamboman/mason.nvim",
		requires = {
			"williamboman/mason-lspconfig.nvim",
			"neovim/nvim-lspconfig",
			"b0o/schemastore.nvim",
			"jose-elias-alvarez/nvim-lsp-ts-utils",
			"kkharji/lspsaga.nvim",
			"ray-x/lsp_signature.nvim",
			"folke/lsp-colors.nvim",
			"hrsh7th/cmp-nvim-lua",
		},
		config = require("plugin-configs.lsp.cmp"),
	})

	use({
		"ms-jpq/coq_nvim",
		branch = "coq",
		disable = true,
		requires = {
			{ "ms-jpq/coq.artifacts", branch = "artifacts" },
			{ "ms-jpq/coq.thirdparty", branch = "3p" },
		},
	})

	use({
		"hrsh7th/nvim-cmp",
		requires = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/nvim-cmp",
			"quangnguyen30192/cmp-nvim-ultisnips",
			"onsails/lspkind-nvim",
		},
	})

	use({
		"SirVer/ultisnips",
		requires = { { "honza/vim-snippets", rtp = "." } },
	})
	-- }}}

	-- {{{ Debugger
	use({
		"mfussenegger/nvim-dap",
		requires = {
			"theHamsta/nvim-dap-virtual-text",
			"nvim-telescope/telescope-dap.nvim",
			"mxsdev/nvim-dap-vscode-js",
			{
				"microsoft/vscode-js-debug",
				run = "npm install --legacy-peer-deps && npm run compile",
			},
		},
		setup = require("plugin-configs.debugger.repl_completion"),
		config = require("plugin-configs.debugger"),
	})
	-- }}}

	-- {{{ Explorer
	use({
		"kyazdani42/nvim-tree.lua",
		setup = function()
			vim.gnvim_tree_respect_buf_cwd = 1 -- 0 by default, will change cwd of nvim-tree to that of new buffer's when opening nvim-tree.
		end,
		config = require("plugin-configs.explorer"),
	})
	-- }}}

	-- {{{ Tmux integration
	use({
		"christoomey/vim-tmux-navigator",
		config = function()
			vim.g.tmux_navigator_disable_when_zoomed = 1
		end,
	})
	-- }}}

	-- {{{ Git
	use({ "tpope/vim-fugitive" })
	use({ "kdheepak/lazygit.nvim" })
	use({ "lewis6991/gitsigns.nvim" })
	-- }}}

	-- {{{ Theme
	use({ "Mofiqul/vscode.nvim" })
	use({ "sainnhe/gruvbox-material" })
	use({ "marko-cerovac/material.nvim" })
	use({ "shaunsingh/nord.nvim" })
	use({ "mhartington/oceanic-next" })
	-- }}}

	-- {{{ Formatter/Linter
	use({
		"jose-elias-alvarez/null-ls.nvim",
		config = require("plugin-configs.null-ls"),
	})
	-- }}}

	-- {{{ Comment
	use({
		"numToStr/Comment.nvim",
		config = require("plugin-configs.comment"),
	})

	use({
		"JoosepAlviste/nvim-ts-context-commentstring",
	})

	use("LudoPinelli/comment-box.nvim")
	-- }}}

	-- {{{ Buffer
	use("kevinhwang91/nvim-bqf")

	use({
		"numtostr/BufOnly.nvim",
		config = function()
			vim.g.bufonly_delete_non_modifiable = true
			vim.keymap.set("n", "<leader>bo", ":BufOnly<CR>")
		end,
	})
	-- }}}

	-- {{{ GOD Tpope
	use({ "tpope/vim-surround" })
	use({ "tpope/vim-repeat" })
	use({ "tpope/vim-unimpaired" })
	use({ "tpope/vim-abolish" })
	-- }}}

	-- {{{ Color
	use("KabbAmine/vCoolor.vim")

	use({
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
	})
	-- }}}

	-- {{{ Sizing

	use({
		"szw/vim-maximizer",
		config = function()
			vim.keymap.set("n", "<leader>m", ":MaximizerToggle<cr>")
		end,
	})

	-- }}}

	-- {{{ Utilities
	use({
		"Pocco81/TrueZen.nvim",
		config = function()
			vim.keymap.set("n", "<leader>tz", "<cmd>:TZAtaraxis<cr>")
		end,
	})

	use({
		"romainl/vim-cool", -- show highlight when search
		config = function()
			vim.g.CoolTotalMatches = 1
		end,
	})

	use("godlygeek/tabular")

	use({
		"j-hui/fidget.nvim",
		config = function()
			require("fidget").setup({})
		end,
	})

	use({
		"airblade/vim-rooter",
		setup = function()
			vim.g.rooter_patterns = { ".git" }
		end,
	})

	use({
		"jghauser/mkdir.nvim",
		config = function()
			require("mkdir")
		end,
	})

	use({
		"mbbill/undotree",
		config = function()
			vim.keymap.set("n", "<leader>u", ":UndotreeShow<cr>")
		end,
	})

	use("ThePrimeagen/vim-be-good")

	use({
		"ThePrimeagen/harpoon",
		config = require("plugin-configs.utilities.harpoon"),
	})

	use({
		"skywind3000/asyncrun.vim",
		config = function()
			vim.cmd([[
        augroup local-asyncrun
          au!
          au User AsyncRunStop copen | wincmd p
        augroup END
     ]])
		end,
	})

	use({
		"ryanoasis/vim-devicons",
		{
			"kyazdani42/nvim-web-devicons",
			config = require("plugin-configs.utilities.nvim-web-devicons"),
		},
	})

	use({
		"xiyaowong/nvim-transparent",
		config = function()
			require("transparent").setup({
				enable = false, -- boolean: enable transparent
				extra_groups = {},
				exclude = {}, -- table: groups you don't want to clear
			})
		end,
	})

	use({ "will133/vim-dirdiff" })

	use({
		"andrewferrier/debugprint.nvim",
		config = function()
			require("debugprint").setup()
		end,
	})

	-- }}}

	-- {{{ Packer end

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all useins
	if packer_bootstrap then
		require("packer").sync()
	end
end)

-- }}}