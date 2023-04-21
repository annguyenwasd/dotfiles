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
				resolve_timeout = 0.2,
			},
		},
		auto_start = "shut-up",
		keymap = {
			eval_snips = "<leader>se",
			jump_to_mark = "<c-]>",
		},
		clients = {
			lsp = {
				resolve_timeout = 0.2,
			},
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
			local setup = require("plugin-configs.lsp.setup").tsserver()
			require("lspconfig").tsserver.setup(coq.lsp_ensure_capabilities(setup))
		end,
		["jsonls"] = function()
			local setup = require("plugin-configs.lsp.setup").jsonls()
			require("lspconfig").jsonls.setup(coq.lsp_ensure_capabilities(setup))
		end,
		["lua_ls"] = function()
			local setup = require("plugin-configs.lsp.setup").lua_ls()
			require("lspconfig").lua_ls.setup(coq.lsp_ensure_capabilities(setup))
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
