return function()
	require("plugin-configs.lsp.common").setup_mason()
	local on_attach = require("plugin-configs.lsp.common").setup_on_attach()
	require("mason-lspconfig").setup_handlers({
		function(server_name) -- default handler (optional)
			require("lspconfig")[server_name].setup({
				on_attach = on_attach,
			})
		end,
		["tsserver"] = function()
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities.textDocument.completion.completionItem.snippetSupport = true

			require("lspconfig").tsserver.setup({
				on_attach = on_attach,
				capabilities = capabilities,
			})
		end,
		["jsonls"] = function()
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities.textDocument.completion.completionItem.snippetSupport = true

			local settings = {
				json = {
					schemas = require("schemastore").json.schemas(),
					validate = { enable = true },
				},
			}
			require("lspconfig").jsonls.setup({
				init_options = require("nvim-lsp-ts-utils").init_options,
				on_attach = on_attach,
				settings = settings,
				capabilities = capabilities,
			})
		end,
		["lua_ls"] = function()
			require("lspconfig").lua_ls.setup({
				on_attach = on_attach,
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim", "packer_bootstrap" },
						},
					},
				},
			})
		end,
	})

	require("lsp_signature").setup({ toggle_key = "<c-s>" })

	-- ╭──────────────────────────────────────────────────────────╮
	-- │                   onsails/lspkind-nvim                   │
	-- ╰──────────────────────────────────────────────────────────╯

	local cmp = require("cmp")
	local lspkind = require("lspkind")
	cmp.setup({ formatting = { format = lspkind.cmp_format() } })

	-- ╭──────────────────────────────────────────────────────────╮
	-- │                     SirVer/ultisnips                     │
	-- ╰──────────────────────────────────────────────────────────╯

	vim.g.UltiSnipsExpandTrigger = "<Plug>(ultisnips_expand)"
	vim.g.UltiSnipsJumpForwardTrigger = "<Plug>(ultisnips_jump_forward)"
	vim.g.UltiSnipsJumpBackwardTrigger = "<Plug>(ultisnips_jump_backward)"
	vim.g.UltiSnipsListSnippets = "<c-x><c-s>"
	vim.g.UltiSnipsRemoveSelectModeMappings = 0

	-- ╭──────────────────────────────────────────────────────────╮
	-- │           quangnguyen30192/cmp-nvim-ultisnips            │
	-- ╰──────────────────────────────────────────────────────────╯
	require("cmp_nvim_ultisnips").setup({})

	-- ╭──────────────────────────────────────────────────────────╮
	-- │                     hrsh7th/nvim-cmp                     │
	-- ╰──────────────────────────────────────────────────────────╯

	-- local cmp = require "cmp"
	local cmp_ultisnips_mappings = require("cmp_nvim_ultisnips.mappings")

	cmp.setup({
		snippet = {
			-- REQUIRED - you must specify a snippet engine
			expand = function(args)
				vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
			end,
		},
		mapping = {
			["<Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_next_item()
				else
					cmp_ultisnips_mappings.expand_or_jump_forwards(fallback)
				end
			end, { "i", "s" }),
			["<S-Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_prev_item()
				else
					cmp_ultisnips_mappings.jump_backwards(fallback)
				end
			end, { "i", "s" }),
			["<c-n>"] = function(fallback)
				if cmp.visible() then
					cmp.select_next_item()
				else
					fallback()
				end
			end,
			["<c-p>"] = function(fallback)
				if cmp.visible() then
					cmp.select_prev_item()
				else
					fallback()
				end
			end,
			["<C-d>"] = cmp.mapping.scroll_docs(-4),
			["<C-f>"] = cmp.mapping.scroll_docs(4),
			["<C-Space>"] = cmp.mapping.complete(),
			["<cr>"] = cmp.mapping.confirm({ select = false }),
			["<C-e>"] = cmp.mapping.abort(),
		},
		sources = cmp.config.sources({
			{ name = "nvim_lsp" },
			{ name = "ultisnips" },
			{ name = "nvim_lua" },
		}, {
			{
				name = "buffer",
				option = {
					-- complete words from mall buffers
					get_bufnrs = function()
						return vim.api.nvim_list_bufs()
					end,
				},
			},
		}),
	})

	cmp.setup.cmdline("/", {
		mapping = cmp.mapping.preset.cmdline(),
		sources = { { name = "buffer" } },
	})

	cmp.setup.cmdline(":", {
		mapping = cmp.mapping.preset.cmdline(),
		sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } }),
	})
end
