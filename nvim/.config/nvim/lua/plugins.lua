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
				auto_install = true,
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
		config = require("plugin-configs.telescope-config"),
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
			"folke/lsp-colors.nvim",
		},
	})

	use({
		"ray-x/lsp_signature.nvim",
		config = function()
			require("lsp_signature").setup({ toggle_key = "<c-s>", hint_enable = false })
		end,
	})

	use({
		"jinzhongjia/LspUI.nvim",
		-- event = 'VimEnter',
		config = function()
			require("LspUI").setup()
		end,
	})

	use({
		"ms-jpq/coq_nvim",
		branch = "coq",
		disable = true,
		requires = {
			{ "ms-jpq/coq.artifacts", branch = "artifacts" },
			{ "ms-jpq/coq.thirdparty", branch = "3p" },
		},
		config = require("plugin-configs.lsp.coq"),
	})

	use({
		"hrsh7th/nvim-cmp",
		disable = false,
		requires = {
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/nvim-cmp",
			"quangnguyen30192/cmp-nvim-ultisnips",
			"onsails/lspkind-nvim",
		},
		config = require("plugin-configs.lsp.cmp"),
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

	use({
		"rcarriga/nvim-dap-ui",
		config = require("plugin-configs.debugger.ui"),
	})
	-- }}}

	-- {{{ Explorer
	use({
		"kyazdani42/nvim-tree.lua",
		setup = function()
			vim.gnvim_tree_respect_buf_cwd = 1 -- 0 by default, will change cwd of nvim-tree to that of new buffer's when opening nvim-tree.
		end,
		config = require("plugin-configs.explorer.nvim-tree"),
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
	use({
		"ThePrimeagen/git-worktree.nvim",
	})
	use({
		"pwntester/octo.nvim",
		config = function()
			require("octo").setup()
		end,
	})
	-- }}}

	-- {{{ Theme
	use("rktjmp/lush.nvim")
	use("tjdevries/colorbuddy.nvim")

	use("Mofiqul/vscode.nvim")
	use("sainnhe/gruvbox-material")
	use("marko-cerovac/material.nvim")
	use("shaunsingh/nord.nvim")
	use("mhartington/oceanic-next")
	use("ofirgall/ofirkai.nvim")
	use("rmehri01/onenord.nvim")
	use("Yazeed1s/minimal.nvim")
	use("kdheepak/monochrome.nvim")
	use("lourenci/github-colors")
	use("Mofiqul/dracula.nvim")
	use("ellisonleao/gruvbox.nvim")
	use("lalitmee/cobalt2.nvim")
	use("metalelf0/jellybeans-nvim")
	-- }}}

	-- {{{ Formatter/Linter
	use({
		"jose-elias-alvarez/null-ls.nvim",
		config = require("plugin-configs.null-ls"),
	})

	use({
		"cappyzawa/trim.nvim",
		config = function()
			require("trim").setup({})
		end,
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
		"shortcuts/no-neck-pain.nvim",
		tag = "*",
		config = function()
			require("no-neck-pain").setup({
				width = 120,
				mappings = {
					toggle = "<leader>cc",
				},
			})
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
		"will133/vim-dirdiff",
		config = function()
			vim.g.DirDiffExcludes = ".git,personal.*,.DS_Store,packer_compiled.lua,*.add,*.spl"
		end,
	})

	use({
		"andrewferrier/debugprint.nvim",
		config = function()
			require("debugprint").setup()
			vim.keymap.set("n", "g?d", ":lua require('debugprint').deleteprints()<cr>")
		end,
	})

	use({ "jbyuki/venn.nvim", config = require("plugin-configs.diagram") })

	-- }}}

	-- {{{ Markdown Previeww

	use({
		"iamcco/markdown-preview.nvim",
		run = function()
			vim.fn["mkdp#util#install"]()
		end,
	})

	--}}}

	-- {{{ Leetcode
	use({
		"ianding1/leetcode.vim",
		config = require("plugin-configs.leetcode"),
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
