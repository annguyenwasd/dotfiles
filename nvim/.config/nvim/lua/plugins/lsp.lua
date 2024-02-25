return {
	"neovim/nvim-lspconfig",
	"williamboman/mason.nvim",
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = {
			"b0o/schemastore.nvim",
			"davidosomething/format-ts-errors.nvim",
			-- TODO: https://github.com/pmizio/typescript-tools.nvim to replace ts-server & this tool
			"jose-elias-alvarez/nvim-lsp-ts-utils",
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
					"tsserver",
					"cssls",
					"lua_ls",
				},
				automatic_installation = true,
			})

			local lsp = require("utils.lsp")
			local on_attach = lsp.get_on_attach_fn()

			require("mason-lspconfig").setup_handlers({
				function(server_name) -- default handler (optional)
					require("lspconfig")[server_name].setup({
						on_attach = on_attach,
					})
				end,
				["tsserver"] = function()
					require("lspconfig").tsserver.setup(lsp.tsserver())
				end,
				["jsonls"] = function()
					require("lspconfig").jsonls.setup(lsp.jsonls())
				end,
				["lua_ls"] = function()
					require("lspconfig").lua_ls.setup(lsp.lua_ls())
				end,
			})
		end,
	},
  -- TODO: remove branch
	{
		"jinzhongjia/LspUI.nvim",
		config = true,
		branch = "legacy",
		opts = {
			prompt = false,
			event = "VeryLazy",
		},
	},
	{
		"j-hui/fidget.nvim",
		tag = "legacy",
		config = true,
	},
}
