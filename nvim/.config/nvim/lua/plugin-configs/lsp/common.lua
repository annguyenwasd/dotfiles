local M = {}

M.setup_mason = function()
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
end

M.setup_on_attach = function()
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
		-- vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
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

		vim.keymap.set("n", "<leader>rn", "<cmd>LspUI rename<cr>")
		vim.keymap.set("n", "<leader>ca", "<cmd>LspUI code_action<cr>")
		vim.keymap.set("n", "]d", "<cmd>LspUI diagnostic next<cr>")
		vim.keymap.set("n", "[d", "<cmd>LspUI diagnostic prev<cr>")
		vim.keymap.set("n", "K", "<cmd>LspUI hover<cr>")
	end

	return on_attach
end

return M
