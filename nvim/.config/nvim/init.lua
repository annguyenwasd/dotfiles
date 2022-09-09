-- {{{1 Plugins
-- {{{ Boostrap
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

function _G.set_theme(theme_name, lualine_theme)
	vim.cmd("colorscheme " .. theme_name)
	require("lualine").setup({ options = { theme = lualine_theme or theme_name } })
end

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
-- }}}

-- {{{ Packer Start
require("packer").startup(function(use)
	-- }}}

	-- {{{ Packer
	use("wbthomason/packer.nvim")
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

	use({
		"nvim-treesitter/nvim-treesitter-refactor",
		config = function()
			require("nvim-treesitter.configs").setup({
				refactor = {
					highlight_definitions = {
						enable = false,
						clear_on_cursor_move = false,
					},
					navigation = {
						enable = true,
						keymaps = {
							goto_next_usage = "]s",
							goto_previous_usage = "[s",
						},
					},
				},
			})
		end,
	})

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
							["ic"] = "@class.inner",
							["ai"] = "@contitional.outer",
							["ii"] = "@conditional.inner",
							["al"] = "@loop.outer",
							["il"] = "@loop.inner",
							["ap"] = "@parameter.outer",
							["ip"] = "@parameter.inner",
						},
					},
					swap = {
						enable = true,
						swap_next = { ["<leader>sn"] = "@parameter.inner" },
						swap_previous = { ["<leader>sp"] = "@parameter.inner" },
					},
					move = {
						enable = true,
						set_jumps = true, -- whether to set jumps in the jumplist
						goto_next_start = {
							["]m"] = "@function.outer",
							["]]"] = "@class.outer",
						},
						goto_next_end = {
							["]M"] = "@function.outer",
							["]["] = "@class.outer",
						},
						goto_previous_start = {
							["[m"] = "@function.outer",
							["[["] = "@class.outer",
						},
						goto_previous_end = {
							["[M"] = "@function.outer",
							["[]"] = "@class.outer",
						},
					},
					lsp_interop = {
						enable = true,
						border = "none",
						peek_definition_code = {
							["<leader>df"] = "@function.outer",
							["<leader>dF"] = "@class.outer",
						},
					},
				},
			})
		end,
	})
	-- }}}

	-- {{{ Telescope
	use({
		"nvim-telescope/telescope.nvim",
		requires = "nvim-lua/plenary.nvim",
		config = function()
			local actions = require("telescope.actions")

			-- Falling back to find_files if git_files can't find a .git directory
			local function project_files()
				local ok = pcall(require("telescope.builtin").git_files, { show_untracked = true })
				if not ok then
					require("telescope.builtin").find_files({ hidden = true })
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
						".git",
						".vscode",
						".idea",
					},
					mappings = {
						i = {
							["<c-s>"] = actions.send_selected_to_qflist + actions.open_qflist,
							["<c-h>"] = actions.which_key,
						},
						n = {
							["<c-s>"] = actions.send_selected_to_qflist + actions.open_qflist,
							["<c-h>"] = actions.which_key,
							["<c-d>"] = actions.delete_buffer,
						},
					},
				},
			})

			local builtin = require("telescope.builtin")

			vim.keymap.set("n", "<leader>o", project_files)
			vim.keymap.set("n", "<leader>i", function()
				builtin.buffers({ sort_rmu = true })
			end)
			vim.keymap.set("n", "<leader>/", builtin.current_buffer_fuzzy_find)
			vim.keymap.set("n", "<leader>rg", builtin.live_grep)
			vim.keymap.set("n", "<leader>fh", builtin.help_tags)
			vim.keymap.set("n", "<leader><leader>fh", builtin.man_pages)
			vim.keymap.set("n", "<leader>ch", builtin.command_history)
			vim.keymap.set("n", "<leader>sh", builtin.search_history)
			vim.keymap.set("n", "<leader>fc", builtin.commands)
			vim.keymap.set("n", "<leader><leader>fc", builtin.colorscheme)
			vim.keymap.set("n", "<leader>km", builtin.keymaps)
			vim.keymap.set("n", "<leader>tr", builtin.resume)
			vim.keymap.set("n", "<leader>hi", builtin.highlights)
			vim.keymap.set("n", "<leader>gS", builtin.git_status)
			vim.keymap.set("n", "gcoo", builtin.git_branches)
			vim.keymap.set("n", "<leader>gl", builtin.git_commits)
			vim.keymap.set("n", "<leader>bgl", builtin.git_bcommits)
			vim.keymap.set("n", "<leader>bgl", builtin.git_bcommits)
			vim.keymap.set("n", "<leader>gh", builtin.git_stash)

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

			vim.keymap.set(
				"n",
				"<leader>ws",
				":Telescope lsp_workspace_symbols initial_mode=normal query=",
				{ silent = false }
			)

			vim.keymap.set("n", "<leader>ff", function()
				builtin.find_files({ hidden = true, cwd = "%:p:h" })
			end)
		end,
	})

	use({
		"nvim-telescope/telescope-fzf-native.nvim",
		run = "make",
		config = function()
			require("telescope").setup({
				extensions = {
					fzf = {},
					--
				},
			})

			-- To get fzf loaded and working with telescope, you need to call
			-- load_extension, somewhere after setup function:
			require("telescope").load_extension("fzf")
		end,
	})

	use({
		"nvim-telescope/telescope-symbols.nvim",
		config = function()
			vim.keymap.set("n", "<leader>ts", "<cmd>Telescope symbols<cr>")
		end,
	})

	-- }}}

	-- {{{ Status line
	use({
		"nvim-lualine/lualine.nvim",
		requires = "arkav/lualine-lsp-progress",
		config = function()
			-- require'lualine.eval'
			require("lualine.default")
		end,
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
			{ "ms-jpq/coq_nvim", branch = "coq" },
			{ "SirVer/ultisnips" },
			{ "ms-jpq/coq.artifacts", branch = "artifacts" },
			{
				"ms-jpq/coq.thirdparty",
				branch = "3p",
				config = function()
					require("coq_3p")({
						{ src = "nvimlua" },
						{
							src = "repl",
							sh = "zsh",
							shell = { p = "perl", n = "node" },
							max_lines = 99,
							deadline = 500,
							unsafe = { "rm", "poweroff", "mv" },
						},
						{ src = "cow", trigger = "!cow" },
						{ src = "figlet", trigger = "!fig" },
						{ src = "ultisnip" },
					})
				end,
			},
		},
		config = function()
			require("mason").setup()

			require("mason-lspconfig").setup({
				ensure_installed = {
					"yamlls",
					"jsonls",
					"html",
					"vimls",
					"bashls",
					"dockerls",
					"sumneko_lua",
					"tsserver",
					"cssls",
					"eslint",
				},
			})

			local setup_ts_utils = function(bufnr, client)
				local ts_utils = require("nvim-lsp-ts-utils")

				ts_utils.setup({})

				-- required to fix code action ranges and filter diagnostics
				ts_utils.setup_client(client)

				local opts = { buffer = bufnr }
				-- no default maps, so you may want to define some here
				vim.keymap.set("n", "<leader><leader>oi", ":TSLspOrganize<CR>", opts)
				vim.keymap.set("n", "<leader>rf", ":TSLspRenameFile<CR>", opts)
				vim.keymap.set("n", "<leader><leader>i", ":TSLspImportAll<CR>", opts)
			end

			local on_attach = function(client, bufnr)
				if client.name == "tsserver" then
					setup_ts_utils(bufnr, client)
				end

				vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

				local opts = { buffer = bufnr }

				vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
				vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
				vim.keymap.set("n", "<leader>kk", vim.lsp.buf.hover, opts)
				-- vim.keymap.set("n", "K", show_documentation, opts)
				-- vim.keymap.set("n", "gi",vim.lsp.buf.implementation, opts)
				-- vim.keymap.set("n", "<C-k>",vim.lsp.buf.signature_help, opts)
				-- vim.keymap.set("n", "<leader>wa",vim.lsp.buf.add_workspace_folder, opts)
				-- vim.keymap.set("n", "<leader>wr",vim.lsp.buf.remove_workspace_folder, opts)
				-- vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
				-- vim.keymap.set("n", "<leader>>rn", vim.lsp.buf.rename, opts)
				-- vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action,
				--                opts)
				vim.keymap.set("n", "gR", vim.lsp.buf.references, opts)
				vim.keymap.set("n", "<leader>ld", vim.diagnostic.open_float, opts)
				vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
				vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
				vim.keymap.set("n", "<leader>fm", function()
					vim.lsp.buf.formatting({ async = true })
				end, opts)
				vim.keymap.set("x", "<leader>fm", function()
					vim.lsp.buf.range_formatting({ async = true })
				end, opts)
				vim.keymap.set("n", "<leader><leader>ee", "<cmd>EslintFixAll<CR>", opts)
				-- vim.keymap.set("n", "<space>q",vim.diagnostic.set_loclist, opts)
				-- vim.keymap.set("n", "<space>=",vim.lsp.buf.formatting, opts)
			end

			vim.g.coq_settings = {
				auto_start = true,
				keymap = {
					eval_snips = "<leader>se",
					jump_to_mark = "<c-]>",
				},
			}
			local coq = require("coq")
			require("mason-lspconfig").setup_handlers({
				function(server_name) -- default handler (optional)
					require("lspconfig")[server_name].setup(coq.lsp_ensure_capabilities({
						on_attach = on_attach,
					}))
				end,
				["tsserver"] = function()
					local capabilities = vim.lsp.protocol.make_client_capabilities()
					capabilities.textDocument.completion.completionItem.snippetSupport = true

					local settings = {
						json = {
							schemas = require("schemastore").json.schemas(),
							validate = { enable = true },
						},
					}
					require("lspconfig").tsserver.setup(coq.lsp_ensure_capabilities({
						on_attach = on_attach,
						settings = settings,
						capabilities = capabilities,
					}))
				end,
				["jsonls"] = function()
					require("lspconfig").jsonls.setup(coq.lsp_ensure_capabilities({
						init_options = require("nvim-lsp-ts-utils").init_options,
						on_attach = on_attach,
					}))
				end,
				["sumneko_lua"] = function()
					require("lspconfig").sumneko_lua.setup(coq.lsp_ensure_capabilities({
						on_attach = on_attach,
						settings = {
							Lua = {
								diagnostics = {
									globals = { "vim", "packer_bootstrap" },
								},
							},
						},
					}))
				end,
			})
		end,
	})

	use({
		"kkharji/lspsaga.nvim",
		config = function()
			vim.keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<cr>")
			vim.keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<cr>")
			vim.keymap.set("x", "<leader>ca", "<cmd>Lspsaga range_code_action<cr>")
		end,
	})

	use({
		"ray-x/lsp_signature.nvim",
		config = function()
			require("lsp_signature").setup({ toggle_key = "<c-s>" })
		end,
	})

	use({ "folke/lsp-colors.nvim" })

	-- }}}

	-- {{{ Debugger
	use({
		"mfussenegger/nvim-dap",
		setup = function()
			-- REPL COMPLETION
			vim.cmd([[
      au FileType dap-repl lua require('dap.ext.autocompl').attach()
      ]])
		end,
		config = function()
			local dap = require("dap")
			local widgets = require("dap.ui.widgets")

			vim.keymap.set("n", "<localleader>bb", dap.toggle_breakpoint)
			vim.keymap.set("n", "<localleader>bc", function()
				dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
			end)
			vim.keymap.set("n", "<localleader>bl", function()
				dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
			end)
			vim.keymap.set("n", "<localleader>BB", function()
				dap.list_breakpoints()
			end)
			vim.keymap.set("n", "<localleader>c", dap.continue)
			vim.keymap.set("n", "`o", dap.step_over)
			vim.keymap.set("n", "`i", dap.step_into)
			vim.keymap.set("n", "`u", dap.step_out)
			vim.keymap.set("n", "`j", dap.down)
			vim.keymap.set("n", "`k", dap.up)
			vim.keymap.set("n", "<localleader>dt", dap.terminate)
			vim.keymap.set("n", "<localleader>dr", dap.repl.toggle)
			vim.keymap.set("n", "<localleader>dc", dap.run_to_cursor)
			vim.keymap.set("n", "`h", widgets.hover)
			vim.keymap.set("n", "<localleader>da", ":Telescope dap commands<cr>")
			vim.keymap.set("n", "<localleader>ds", function()
				widgets.centered_float(widgets.scopes)
			end)
			vim.keymap.set("n", "<localleader>df", function()
				widgets.centered_float(widgets.frames)
			end)
		end,
	})

	use({
		"mxsdev/nvim-dap-vscode-js",
		requires = {
			"mfussenegger/nvim-dap",
			{

				"microsoft/vscode-js-debug",
				run = "npm install --legacy-peer-deps && npm run compile",
			},
		},
		config = function()
			require("dap-vscode-js").setup({
				-- node_path = "node", -- Path of node executable. Defaults to $NODE_PATH, and then "node"
				debugger_path = os.getenv("HOME") .. "/.local/share/nvim/site/pack/packer/start/vscode-js-debug", -- Path to vscode-js-debug installation.
				adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" }, -- which adapters to register in nvim-dap
			})

			for _, language in ipairs({ "typescript", "javascript" }) do
				require("dap").configurations[language] = {
					{
						type = "pwa-node",
						request = "launch",
						name = "Launch file",
						program = "${file}",
						cwd = "${workspaceFolder}",
						console = "integratedTerminal",
					},
					{
						type = "pwa-node",
						request = "attach",
						name = "Attach",
						processId = require("dap.utils").pick_process,
						cwd = "${workspaceFolder}",
						console = "integratedTerminal",
					},
					{
						type = "pwa-node",
						request = "launch",
						name = "Debug Jest Tests",
						trace = true, -- include debugger info
						runtimeExecutable = "node",
						runtimeArgs = {
							"./node_modules/jest/bin/jest.js",
							"--runInBand",
						},
						rootPath = "${workspaceFolder}",
						cwd = "${workspaceFolder}",
						console = "integratedTerminal",
						internalConsoleOptions = "neverOpen",
					},
				}
			end
		end,
	})

	use({
		"nvim-telescope/telescope-dap.nvim",
		config = function()
			require("telescope").load_extension("dap")
		end,
	})

	use({
		"theHamsta/nvim-dap-virtual-text",
		config = function()
			require("nvim-dap-virtual-text").setup()
		end,
	})

	-- }}}

	-- {{{ Explorer
	use({
		"kyazdani42/nvim-tree.lua",
		setup = function()
			vim.gnvim_tree_respect_buf_cwd = 1 -- 0 by default, will change cwd of nvim-tree to that of new buffer's when opening nvim-tree.
		end,
		config = function()
			local tree_cb = require("nvim-tree.config").nvim_tree_callback

			vim.keymap.set("n", "<leader>n", "<cmd>NvimTreeToggle<cr>")

			require("nvim-tree").setup({
				actions = { open_file = { quit_on_open = true } },
				renderer = { indent_markers = { enable = true } },
				update_focused_file = { enable = true },
				view = {
					width = 40,
					mappings = {
						list = {
							{ key = { "l" }, cb = tree_cb("edit") },
							{ key = { "h" }, cb = tree_cb("close_node") },
						},
					},
				},
				git = {
					ignore = false,
				},
			})
		end,
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
	use({
		"kdheepak/lazygit.nvim",
		config = function()
			vim.g.lazygit_floating_window_winblend = 0
			vim.g.lazygit_floating_window_scaling_factor = 1
			vim.keymap.set("n", "<leader>lg", "<cmd>LazyGit<cr>")
		end,
	})
	use({
		"tpope/vim-fugitive",
		config = function()
			-- Not gonna show shit messages when run git hook via husky
			vim.g.fugitive_pty = 0

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
				"<leader>gp",
				":AsyncRun git push -u origin $(git rev-parse --abbrev-ref HEAD) --force-with-lease<cr>",
				{ silent = false }
			)
		end,
	})
	use({
		"lewis6991/gitsigns.nvim",
		requires = { "nvim-lua/plenary.nvim" },
		config = function()
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
		end,
	})
	-- }}}

	-- {{{ Theme
	use({
		"sainnhe/gruvbox-material",
		config = function()
			vim.g.gruvbox_material_enable_bold = 1
			vim.g.gruvbox_material_better_performance = 1
			vim.g.gruvbox_material_foreground = "original"
			-- set_theme('gruvbox-material')
		end,
	})

	use({
		"marko-cerovac/material.nvim",
		setup = function()
			-- darker, lighter, oceanic, palenight, deep ocean
			vim.g.material_style = "deep ocean"
		end,
		config = function()
			vim.keymap.set("n", "<leader>tt", require("material.functions").toggle_style)
			-- set_theme("material")
		end,
	})

	use({
		"mcchrish/zenbones.nvim",
		requires = "rktjmp/lush.nvim",
		config = function()
			-- set_theme("zenwritten")
		end,
	})

	use({
		"Mofiqul/vscode.nvim",
		setup = function()
			vim.g.vscode_style = "light"
		end,
		config = function()
			set_theme("vscode")
		end,
	})

	-- }}}

	-- {{{ Formatter/Linter
	use({
		"jose-elias-alvarez/null-ls.nvim",
		config = function()
			require("null-ls").setup({
				sources = {
					require("null-ls").builtins.formatting.stylua,
					require("null-ls").builtins.formatting.prettierd,
					require("null-ls").builtins.formatting.jq,
					require("null-ls").builtins.formatting.shfmt,
					require("null-ls").builtins.formatting.yamlfmt,
					require("null-ls").builtins.formatting.ktlint,
					require("null-ls").builtins.formatting.markdownlint,
				},
			})
		end,
	})
	-- }}}

	-- {{{ Comment
	use({
		"JoosepAlviste/nvim-ts-context-commentstring",
		config = function()
			require("nvim-treesitter.configs").setup({
				context_commentstring = { enable = true, enable_autocmd = false },
			})
		end,
	})
	use({
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup({
				pre_hook = function(ctx)
					local U = require("Comment.utils")

					local location = nil
					if ctx.ctype == U.ctype.block then
						location = require("ts_context_commentstring.utils").get_cursor_location()
					elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
						location = require("ts_context_commentstring.utils").get_visual_start_location()
					end

					return
						require("ts_context_commentstring.internal").calculate_commentstring({
						key = ctx.ctype == U.ctype.line and "__default" or "__multiline",
						location = location,
					})
				end,
			})
		end,
	})
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

	-- {{{ Required
	use({ "nvim-lua/popup.nvim" })
	use({ "nvim-lua/plenary.nvim" })
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
		"romainl/vim-cool",
		config = function()
			vim.g.CoolTotalMatches = 1
		end,
	}) -- show highlight when search
	use("godlygeek/tabular")

	use({
		"j-hui/fidget.nvim",
		config = function()
			require("fidget").setup({})
		end,
	})

	-- This break the lsp_installer :LSPInstallInfo. Disabled for now
	use({
		"sunjon/shade.nvim",
		disable = true,
		config = function()
			require("shade").setup({
				overlay_opacity = 50,
				opacity_step = 1,
				keys = {
					brightness_up = "<C-Up>",
					brightness_down = "<C-Down>",
					toggle = "<leader>ss",
				},
			})
		end,
	})

	use({
		"iamcco/markdown-preview.nvim",
		run = function()
			vim.fn["mkdp#util#install"]()
		end,
		setup = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
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
		config = function()
			require("harpoon").setup({ menu = { width = 120, height = 30 } })
			local ui = require("harpoon.ui")

			vim.keymap.set("n", "ma", require("harpoon.mark").add_file)
			vim.keymap.set("n", "'1", function()
				ui.nav_file(1)
			end)
			vim.keymap.set("n", "'2", function()
				ui.nav_file(2)
			end)
			vim.keymap.set("n", "'3", function()
				ui.nav_file(3)
			end)
			vim.keymap.set("n", "'4", function()
				ui.nav_file(4)
			end)
			vim.keymap.set("n", "'5", function()
				ui.nav_file(5)
			end)
			vim.keymap.set("n", "'6", function()
				ui.nav_file(6)
			end)
			vim.keymap.set("n", "'7", function()
				ui.nav_file(7)
			end)
			vim.keymap.set("n", "'8", function()
				ui.nav_file(8)
			end)
			vim.keymap.set("n", "'9", function()
				ui.nav_file(9)
			end)
			vim.keymap.set("n", "mq", ui.toggle_quick_menu)
		end,
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
	})

	use({
		"rhysd/vim-grammarous",
		config = function()
			vim.keymap.set("n", "gM", ":GrammarousCheck<cr>")
			vim.keymap.set("n", "gmn", "<Plug>(grammarous-move-to-next-error)")
			vim.keymap.set("n", "gmp", "<Plug>(grammarous-move-to-previous-error)")
			vim.keymap.set("n", "gmf", "<Plug>(grammarous-fixit)")
			vim.keymap.set("n", "gmF", "<Plug>(grammarous-fixall)")
			vim.keymap.set("n", "gmr", "<Plug>(grammarous-remove-error)")
			vim.keymap.set("n", "gmR", "<Plug>(grammarous-reset)")
		end,
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

	-- {{{ Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all useins
	if packer_bootstrap then
		require("packer").sync()
	end
	-- }}}
end)

-- }}}
-- }}}1

-- {{{1 Settings
-- {{{2
vim.g.vimsyn_embed = "lPr"

vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.wildmenu = true
vim.opt.termguicolors = true
vim.opt.hidden = true
vim.opt.ignorecase = true
vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.expandtab = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.exrc = true
vim.opt.secure = true
vim.opt.clipboard = "unnamed"
vim.opt.updatetime = 50
vim.opt.inccommand = "nosplit"
vim.opt.mouse = "a"
vim.opt.scrolloff = 8
vim.opt.completeopt = { "menuone", "noinsert", "noselect" }
vim.opt.shortmess:append({ c = true })
vim.opt.smartindent = true
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.tabstop = 2
vim.opt.undofile = true
vim.opt.undodir = vim.fn.expand("~/.vim/undo")
vim.opt.cmdheight = 1
vim.opt.listchars = "tab:▹ ,trail:·,eol:↲,lead:·"
vim.opt.list = false
vim.opt.wrapscan = false

vim.wo.signcolumn = "yes"

vim.bo.syntax = "enable"
vim.bo.swapfile = false

-- vim.api.nvim_create_autocmd("BufEnter", {
--     group = vim.api.nvim_create_augroup("OpenHelpOnRightMostWindow",
--                                         {clear = true}),
--     pattern = "*.txt",
--     command = "if &buftype == 'help' | wincmd L | endif",
--     desc = "Open help page on the right (default bottom)"
-- })

vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
	group = vim.api.nvim_create_augroup("SetFoldMethod", { clear = true }),
	pattern = { "*.vim", "*.lua", "*.zsh", "*.conf" },
	command = "setlocal foldmethod=marker",
})

vim.api.nvim_create_autocmd({ "BufRead" }, {
	group = vim.api.nvim_create_augroup("AutoSetFoldLevelInitLua", { clear = true }),
	pattern = { "*.lua" },
	command = "setlocal foldlevel=1",
})

local cursor_line_only_in_active_window = vim.api.nvim_create_augroup("CursorLineOnlyInActiveWindow", { clear = true })

vim.api.nvim_create_autocmd({ "VimEnter", "WinEnter", "BufWinEnter" }, {
	group = cursor_line_only_in_active_window,
	pattern = "*",
	command = "setlocal cursorline",
})

vim.api.nvim_create_autocmd("WinLeave", {
	group = cursor_line_only_in_active_window,
	pattern = "*",
	command = "setlocal nocursorline",
})

-- }}}2
-- }}}1

-- {{{1 Mappings
-- {{{
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.keymap.set("n", "n", "nzt", { noremap = false })
vim.keymap.set("n", "N", "Nzt", { noremap = false })
vim.keymap.set("n", "*", "*zt", { noremap = false })
vim.keymap.set("n", "#", "#zt", { noremap = false })

vim.keymap.set("n", "Y", "y$")

-- Duplicate everything selected
vim.keymap.set("v", "D", "y'>p")

-- Do search with selected text in VISUAL mode
vim.keymap.set("v", "*", 'y<cmd>let @/ = @"<cr><cmd>set hlsearch<cr>', { noremap = false })

vim.keymap.set("n", "<leader>cl", "<cmd>ccl<cr><cmd>lcl<cr><cmd>echo ''<cr><cmd>noh<cr><cmd>pclose<cr>")
vim.keymap.set(
	"n",
	"<leader><leader>R",
	"<cmd>so ~/.config/nvim/init.lua<cr><cmd>PackerCompile<cr>:syntax enable<cr>:PackerInstall<cr>"
)
vim.keymap.set("n", "<leader><leader>r", "<cmd>so ~/.config/nvim/init.lua<cr><cmd>PackerCompile<cr>:syntax enable<cr>")

vim.keymap.set("n", "<c-w><c-e>", "<c-w>=")

-- Moving around in command mode
vim.keymap.set("c", "<c-h>", "<left>", { silent = false })
vim.keymap.set("c", "<c-j>", "<down>", { silent = false })
vim.keymap.set("c", "<c-k>", "<up>", { silent = false })
vim.keymap.set("c", "<c-l>", "<right>", { silent = false })

vim.keymap.set("i", "<c-h>", "<left>", { silent = false })
vim.keymap.set("i", "<c-j>", "<down>", { silent = false })
vim.keymap.set("i", "<c-k>", "<up>", { silent = false })
vim.keymap.set("i", "<c-l>", "<right>", { silent = false })

vim.keymap.set("n", "<leader>e", "<cmd>b #<cr>")
vim.keymap.set("n", "<leader><leader>e", "<cmd>e<cr>")
vim.keymap.set("n", "<leader>td", ":vsp .todo<cr>")

-- Create file at same folder with vsplit/split
vim.keymap.set("n", "<leader>vf", ":vsp %:h/", { silent = false })
vim.keymap.set("n", "<leader>sf", ":sp %:h/", { silent = false })
vim.keymap.set("n", "<leader><leader>ef", ":e %:h/", { silent = false })

vim.keymap.set("n", "<leader><leader>h", 'yi" :!npm home <c-r>"<cr>')
vim.keymap.set("n", "<leader><leader>H", "yi' :!npm home <c-r>\"<cr>")
vim.keymap.set("n", "<leader><leader>oe", "<cmd>!open -a textedit %<cr>")
vim.keymap.set("n", "<leader><leader>oc", "<cmd>!code %<cr>")
vim.keymap.set("n", "<leader><leader>og", "<cmd>!open -a google chrome %<cr>")

-- Windows
vim.keymap.set("n", "<c-w>v", "<c-w>v <c-w>l", { noremap = true })
vim.keymap.set("n", "<c-w><c-v>", "<c-w>v <c-w>l", { noremap = true })
vim.keymap.set("n", "<c-w>s", "<c-w>s <c-w>j", { noremap = true })
vim.keymap.set("n", "<c-w><c-s>", "<c-w>s <c-w>j", { noremap = true })
vim.keymap.set("n", "<c-w><c-w>", "<c-w>q", { noremap = true })
vim.keymap.set("n", "<leader><leader>m", ":vert res 120<cr>", { noremap = true })
vim.keymap.set("n", "<leader><leader>M", ":GoldenRatioToggle<cr>", { noremap = true })

vim.keymap.set("n", "<leader>rr", '"rciw')
vim.keymap.set("n", "<leader>cf", ":CopyFileName<cr>")
vim.keymap.set("n", "<leader>fl", ":set foldlevel=", { silent = false })

function _G.copyFileName()
	vim.fn.setreg("*", vim.fn.expand("%:t:r"))
	vim.fn.setreg("r", vim.fn.expand("%:t:r"))
end

function _G.copyAbsouPathPath()
	vim.fn.setreg("*", vim.fn.expand("%:p"))
	vim.fn.setreg("r", vim.fn.expand("%:p"))
end

function _G.copyFileRelativePath()
	vim.fn.setreg("*", vim.fn.expand("%"))
	vim.fn.setreg("r", vim.fn.expand("%"))
end

function _G.copyFileRelativeFolderPath()
	vim.fn.setreg("*", vim.fn.expand("%:h"))
	vim.fn.setreg("r", vim.fn.expand("%:h"))
end

function _G.copyFolderName()
	vim.fn.setreg("*", vim.fn.expand("%:h:t"))
	vim.fn.setreg("r", vim.fn.expand("%:h:t"))
end

function _G.openCurrentFolder()
	vim.api.nvim_command("!open %:p:h")
end

function _G.googleJavaFormat()
	vim.api.nvim_command("!google-java-format --replace % ")
end

vim.api.nvim_command("command! CopyFileName :call v:lua.copyFileName()")
vim.api.nvim_command("command! Cfn :call v:lua.copyFileName()")

vim.api.nvim_command("command! CopyFolderName :call v:lua.copyFolderName()")
vim.api.nvim_command("command! Cdn :call v:lua.copyFolderName()")

vim.api.nvim_command("command! CopyAbsouPathPath :call v:lua.copyAbsouPathPath()")
vim.api.nvim_command("command! CopyRelativePath :call v:lua.copyFileRelativePath()")
vim.api.nvim_command("command! CopyFolderPath :call v:lua.copyFileRelativeFolderPath()")

vim.api.nvim_command("command! GoogleJavaFormat :call v:lua.googleJavaFormat()")

vim.api.nvim_command("command! OpenFolder :call v:lua.openCurrentFolder()")
vim.api.nvim_command("command! Od :call v:lua.openCurrentFolder()")

-- Open github page
vim.keymap.set("n", "<leader><leader>gh", function()
	vim.cmd('normal! yi"')
	local package = vim.fn.getreg('"')
	local ghPage = "https://github.com/" .. package
	vim.cmd("!open " .. ghPage)
end, { silent = true })

-- local function tm ()
--   vim.ui.input({prompt = ':!tmux neww '}, function (command)
--     if string.len(command) > 0 then
--       vim.cmd(":!tmux neww " .. command)
--     end
--   end
-- )
-- end

vim.keymap.set("n", "<leader>tm", ":!tmux neww ", { silent = false })

local function build()
	local json = require("lib.json")

	local package = vim.fn.findfile("package.json", ".;")
	if package ~= "package.json" then
		local file = io.open(package, "rb")

		local jsonString = file:read("*a")
		file:close()
		print(jsonString)

		-- parse json with lunajson
		-- local json = require 'lunajson'
		local t = json.decode(jsonString)
		local packageName = t["name"]
		vim.notify("Building " .. packageName)

		vim.cmd("AsyncRun yarn workspace " .. packageName .. " build")
		-- vim.cmd ("!tmux splitw -l 15 yarn workspace " .. packageName .. " build")
	end
end

vim.keymap.set("n", "<leader>bd", build)

-- }}}
-- }}}1
