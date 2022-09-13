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
		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
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

	-- ╭──────────────────────────────────────────────────────────╮
	-- │                  ms-jpq/coq.thirdparty                   │
	-- ╰──────────────────────────────────────────────────────────╯
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

  require('plugin-configs.lsp.common')
end
