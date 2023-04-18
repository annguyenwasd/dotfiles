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
			"lua_ls",
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
		--[[ vim.keymap.set("n", "K", vim.lsp.buf.hover, opts) ]]
		vim.keymap.set("n", "<leader>kk", function()
			local w = vim.fn.expand("<cword>")
			vim.api.nvim_command("help " .. w)
		end, { noremap = true, buffer = bufnr })
		-- vim.keymap.set("n", "gi",vim.lsp.buf.implementation, opts)
		-- vim.keymap.set("n", "<C-k>",vim.lsp.buf.signature_help, opts)
		-- vim.keymap.set("n", "<leader>wa",vim.lsp.buf.add_workspace_folder, opts)
		-- vim.keymap.set("n", "<leader>wr",vim.lsp.buf.remove_workspace_folder, opts)
		-- vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
		-- vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
		-- vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action,
		--                opts)
		vim.keymap.set("n", "gR", vim.lsp.buf.references, opts)
		vim.keymap.set("n", "<leader>ld", vim.diagnostic.open_float, opts)
		--[[ vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) ]]
		--[[ vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts) ]]
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

	vim.g.coq_settings = {
		display = {
			icons = {
				spacing = 2,
				mappings = {
					Text = "",
					Method = "",
					Function = "",
					Constructor = "",
					Field = "ﰠ",
					Variable = "",
					Class = "ﴯ",
					Interface = "",
					Module = "",
					Property = "ﰠ",
					Unit = "塞",
					Value = "",
					Enum = "",
					Keyword = "",
					Snippet = "",
					Color = "",
					File = "",
					Reference = "",
					Folder = "",
					EnumMember = "",
					Constant = "",
					Struct = "פּ",
					Event = "",
					Operator = "",
					TypeParameter = "",
				},
			},
			pum = {
				source_context = { "[", "]" },
			},
		},
		auto_start = "shut-up",
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
		["lua_ls"] = function()
			require("lspconfig").lua_ls.setup(coq.lsp_ensure_capabilities({
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

	require("plugin-configs.lsp.common")()
end
