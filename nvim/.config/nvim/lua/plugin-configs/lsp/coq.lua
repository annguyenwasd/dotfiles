return function()
	require("plugin-configs.lsp.common").setup_mason()
	local on_attach = require("plugin-configs.lsp.common").setup_on_attach()

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
      preview = {
        resolve_timeout = 0.2
      }
		},
		auto_start = "shut-up",
		keymap = {
			eval_snips = "<leader>se",
			jump_to_mark = "<c-]>",
		},
    clients = {
      lsp = {
        resolve_timeout = 0.2
      }
    }
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
				typescript = {
					inlayHints = {
						includeInlayParameterNameHints = "all",
						includeInlayParameterNameHintsWhenArgumentMatchesName = false,
						includeInlayFunctionParameterTypeHints = true,
						includeInlayVariableTypeHints = true,
						includeInlayPropertyDeclarationTypeHints = true,
						includeInlayFunctionLikeReturnTypeHints = true,
						includeInlayEnumMemberValueHints = true,
					},
				},
				javascript = {
					inlayHints = {
						includeInlayParameterNameHints = "all",
						includeInlayParameterNameHintsWhenArgumentMatchesName = false,
						includeInlayFunctionParameterTypeHints = true,
						includeInlayVariableTypeHints = true,
						includeInlayPropertyDeclarationTypeHints = true,
						includeInlayFunctionLikeReturnTypeHints = true,
						includeInlayEnumMemberValueHints = true,
					},
				},
			}
			require("lspconfig").tsserver.setup(coq.lsp_ensure_capabilities({
				on_attach = on_attach,
				settings = settings,
				capabilities = capabilities,
			}))
		end,
		["jsonls"] = function()
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			local settings = {
				json = {
					schemas = require("schemastore").json.schemas(),
					validate = { enable = true },
				},
			}
			require("lspconfig").jsonls.setup(coq.lsp_ensure_capabilities({
				init_options = require("nvim-lsp-ts-utils").init_options,
				on_attach = on_attach,
				settings = settings,
				capabilities = capabilities,
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
end
