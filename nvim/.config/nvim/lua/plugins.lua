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

	use("nvim-treesitter/nvim-treesitter-context")

	use({
		"nvim-treesitter/nvim-treesitter-textobjects",
		config = function()
			require("nvim-treesitter.configs").setup({
				textobjects = {
					select = {
						enable = true,

						-- Automatically jump forward to textobj, similar to targets.vim
						lookahead = true,

						keymaps = {
							-- You can use the capture groups defined in textobjects.scm
							["af"] = "@function.outer",
							["if"] = "@function.inner",
							["ac"] = "@class.outer",
							-- You can optionally set descriptions to the mappings (used in the desc parameter of
							-- nvim_buf_set_keymap) which plugins like which-key display
							["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
							-- You can also use captures from other query groups like `locals.scm`
							["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
						},
						-- You can choose the select mode (default is charwise 'v')
						--
						-- Can also be a function which gets passed a table with the keys
						-- * query_string: eg '@function.inner'
						-- * method: eg 'v' or 'o'
						-- and should return the mode ('v', 'V', or '<c-v>') or a table
						-- mapping query_strings to modes.
						selection_modes = {
							["@parameter.outer"] = "v", -- charwise
							["@function.outer"] = "V", -- linewise
							["@class.outer"] = "<c-v>", -- blockwise
						},
						-- If you set this to `true` (default is `false`) then any textobject is
						-- extended to include preceding or succeeding whitespace. Succeeding
						-- whitespace has priority in order to act similarly to eg the built-in
						-- `ap`.
						--
						-- Can also be a function which gets passed a table with the keys
						-- * query_string: eg '@function.inner'
						-- * selection_mode: eg 'v'
						-- and should return true of false
						include_surrounding_whitespace = true,
					},
				},
			})
		end,
	})

	use({
		"nvim-treesitter/nvim-treesitter-refactor",
		config = function()
			require("nvim-treesitter.configs").setup({
				refactor = {
					highlight_definitions = {
						enable = true,
						-- Set to false if you have an `updatetime` of ~100.
						clear_on_cursor_move = true,
					},
					highlight_current_scope = { enable = false },
					navigation = {
						enable = true,
						-- Assign keymaps to false to disable them, e.g. `goto_definition = false`.
						keymaps = {
							goto_definition = false,
							list_definitions = false,
							list_definitions_toc = false,
							goto_next_usage = "]s",
							goto_previous_usage = "[s",
						},
					},
				},
			})
		end,
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
		},
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
			"lukas-reineke/cmp-under-comparator",
		},
		config = require("plugin-configs.lsp.cmp"),
	})

	use({
		"SirVer/ultisnips",
		requires = { { "honza/vim-snippets", rtp = "." } },
	})

	use("davidosomething/format-ts-errors.nvim")

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
	use("gbprod/nord.nvim")
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
					enabled = true,
					toggle = "<leader>cc",
					widthUp = false,
					widthDown = false,
					scratchPad = false,
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
			vim.g.DirDiffExcludes =
				".git,personal.*,.DS_Store,**/packer_compiled.lua,**/*.add,**/*.spl,*.png,*.jpg,*.jpeg,Session.vim,*/state.yml,plugin/*,spell/*"
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
