return {
	{ "neovim/nvim-lspconfig", event = "BufReadPost" },
	{
		"williamboman/mason.nvim",
		event = "BufReadPost",
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
			"b0o/schemastore.nvim",
			"davidosomething/format-ts-errors.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			"folke/neodev.nvim",
		},
		config = function()
			require("mason").setup()
			local mason_tool_installer = require("mason-tool-installer")
			require("mason-lspconfig").setup({
				ensure_installed = {
					"html",
					"bashls",
					"lua_ls",
				},
				automatic_installation = false,
			})

			mason_tool_installer.setup({
				ensure_installed = {
					"prettierd",
					"stylua",
					"eslint_d",
				},
			})

			require("neodev").setup({})

			local lsp = require("utils.lsp")
			local on_attach = lsp.get_on_attach_fn()

			require("mason-lspconfig").setup_handlers({
				function(server_name) -- default handler (optional)
					require("lspconfig")[server_name].setup({
						on_attach = on_attach,
					})
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
		event = "BufReadPost",
		enabled = false,
		config = true,
		branch = "legacy",
		opts = {
			prompt = false,
			event = "VeryLazy",
		},
	},
	{
		"j-hui/fidget.nvim",
		event = "BufReadPost",
		tag = "legacy",
		config = true,
	},
	{
		"pmizio/typescript-tools.nvim",
		ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
		dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
		config = function()
			require("typescript-tools").setup(require("utils.lsp").tsserver())
		end,
	},
}
