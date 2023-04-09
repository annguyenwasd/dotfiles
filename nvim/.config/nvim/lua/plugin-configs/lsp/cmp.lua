return function()
	require("mason").setup()

	require("mason-lspconfig").setup({
		ensure_installed = {
			"yamlls",
			"jsonls",
			"html",
			"vimls",
			"bashls",
			"dockerls",
			"tsserver",
			"cssls",
      "lua_ls"
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

	local null_ls_format = function(bufnr)
		vim.lsp.buf.format({
			filter = function(client)
				-- apply whatever logic you want (in this example, we'll only use null-ls)
				return client.name == "null-ls"
			end,
			bufnr = bufnr,
		})
	end

	local null_ls_range_format = function(bufnr)
		vim.lsp.buf.range_format({
			filter = function(client)
				-- apply whatever logic you want (in this example, we'll only use null-ls)
				return client.name == "null-ls"
			end,
			bufnr = bufnr,
		})
	end

	--[[ local function do_format_on_save(client, bufnr) ]]
	--[[ 	-- if you want to set up formatting on save, you can use this as a callback ]]
	--[[ 	local format_on_save = vim.api.nvim_create_augroup("LspFormatting", {}) ]]
	--[[]]
	--[[ 	if client.supports_method("textDocument/formatting") then ]]
	--[[ 		vim.api.nvim_clear_autocmds({ group = format_on_save, buffer = bufnr }) ]]
	--[[ 		vim.api.nvim_create_autocmd("BufWritePre", { ]]
	--[[ 			group = format_on_save, ]]
	--[[ 			buffer = bufnr, ]]
	--[[ 			callback = function() ]]
	--[[ 				null_ls_format(bufnr) ]]
	--[[ 			end, ]]
	--[[ 		}) ]]
	--[[ 	end ]]
	--[[ end ]]

	local on_attach = function(client, bufnr)
		--[[ do_format_on_save(client, bufnr) ]]
		if client.name == "tsserver" then
			setup_ts_utils(bufnr, client)
		end

		vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

		local opts = { buffer = bufnr }

		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
		vim.keymap.set("n", "<leader>kk", function()
			local w = vim.fn.expand("<cword>")
			vim.api.nvim_command("help " .. w)
		end, { noremap = true, buffer = bufnr })
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
			null_ls_format(bufnr)
		end, opts)
		vim.keymap.set("x", "<leader>fm", function()
			null_ls_range_format(bufnr)
		end, opts)
		vim.keymap.set("n", "<leader><leader>ee", "<cmd>EslintFixAll<CR>", opts)
		-- vim.keymap.set("n", "<space>q",vim.diagnostic.set_loclist, opts)
		-- vim.keymap.set("n", "<space>=",vim.lsp.buf.formatting, opts)
	end

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

	require("plugin-configs.lsp.common")()
end
