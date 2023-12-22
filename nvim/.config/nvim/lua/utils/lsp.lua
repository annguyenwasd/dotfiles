local M = {}

local map_default_lsp_fns = function(bufnr)
	local get_opts = make_on_attach_opts(bufnr)
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, get_opts("lsp: rename"))
	vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, get_opts("lsp: show code action"))
	vim.keymap.set("n", "]d", vim.diagnostic.goto_next, get_opts("lsp: next diagnostic"))
	vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, get_opts("lsp: prev diagnostic"))
	vim.keymap.set("n", "K", vim.lsp.buf.hover, get_opts("lsp: hover"))
end

local map_lsp_ui_fns = function(bufnr)
	local get_opts = make_on_attach_opts(bufnr)
	vim.keymap.set("n", "<leader>rn", "<cmd>LspUI rename<cr>", get_opts("lsp: rename"))
	vim.keymap.set("n", "<leader>ca", "<cmd>LspUI code_action<cr>", get_opts("lsp: show code action"))
	vim.keymap.set("n", "]d", "<cmd>LspUI diagnostic next<cr>", get_opts("lsp: next diagnostic"))
	vim.keymap.set("n", "[d", "<cmd>LspUI diagnostic prev<cr>", get_opts("lsp: prev diagnostic"))
	vim.keymap.set("n", "K", "<cmd>LspUI hover<cr>", get_opts("lsp: hover"))
end

local signs = {
	Error = " ",
	Warn = " ",
	Info = " ",
	Hint = " ",
}

M.signs = signs

local get_on_attach_fn = function()
	for type, icon in pairs(signs) do
		local hl = "DiagnosticSign" .. type
		vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
	end

	local setup_ts_utils = function(client, bufnr)
		local ts_utils = require("nvim-lsp-ts-utils")
		local get_opts = make_on_attach_opts(bufnr)

		ts_utils.setup({})

		-- required to fix code action ranges and filter diagnostics
		ts_utils.setup_client(client)

		-- no default maps, so you may want to define some here
		vim.keymap.set("n", "<leader><leader>oi", "<cmd>TSLspOrganize<CR>", get_opts("lsp: Organize imports"))
		vim.keymap.set("n", "<leader>rf", "<cmd>TSLspRenameFile<CR>", get_opts("lsp: Rename file"))
		vim.keymap.set("n", "<leader><leader>i", "<cmd>TSLspImportAll<CR>", get_opts("lsp: Import missing packages"))
	end

	return function(client, bufnr)
		if client.name == "tsserver" then
			setup_ts_utils(client, bufnr)
		end

		if is_work_profile() then
			require("work").lsp_on_attach_fns(bufnr)
		end

		vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

		local get_opts = make_on_attach_opts(bufnr)

		vim.keymap.set(
			"n",
			"gD",
			vim.lsp.buf.declaration,
			get_opts("lsp: Jumps to the declaration of the symbol under the cursor.")
		)
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, get_opts("lsp: Go to definition"))
		vim.keymap.set(
			"n",
			"gi",
			vim.lsp.buf.implementation,
			get_opts("lsp: Lists all the implementations for the symbol under the cursor in the quickfix window.")
		)
		vim.keymap.set(
			"n",
			"<leader>D",
			vim.lsp.buf.type_definition,
			get_opts("lsp: Jumps to the definition of the type of the symbol under the cursor.")
		)

		vim.keymap.set("n", "gvd", function()
			vim.cmd("vsp")
			vim.lsp.buf.definition()
		end, get_opts("lsp: Split vertical pane then go to definition"))

		vim.keymap.set("n", "gsd", function()
			vim.cmd("sp")
			vim.lsp.buf.definition()
		end, get_opts("lsp: Split horizontal pane then go to definition"))

		vim.keymap.set("n", "<c-s>", vim.lsp.buf.signature_help, get_opts("lsp: Show signature help"))
		vim.keymap.set("i", "<c-s>", vim.lsp.buf.signature_help, get_opts("lsp: Show signature help"))

		vim.keymap.set("n", "gR", vim.lsp.buf.references, get_opts("lsp: Show references on Telescope"))
		vim.keymap.set("n", "<leader>ld", vim.diagnostic.open_float, get_opts("lsp: Show diagnostics"))
		vim.keymap.set("n", "<leader>fm", function()
			vim.lsp.buf.format({
				filter = function(_client)
					-- only use null-ls as formatter
					return _client.name == "null-ls"
				end,
				bufnr = bufnr,
			})
		end, get_opts("lsp: null-ls format"))

		vim.keymap.set("n", "<leader>fa", "<cmd>EslintFixAll<CR>", get_opts("lsp: eslint fix all"))

		if package.loaded["LspUI"] then
			map_lsp_ui_fns(bufnr)
		else
			map_default_lsp_fns(bufnr)
		end
	end
end

M.get_on_attach_fn = get_on_attach_fn
local on_attach = get_on_attach_fn()

M.tsserver = function()
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

	local handlers = {
		["textDocument/publishDiagnostics"] = function(_, result, ctx, config)
			if result.diagnostics == nil then
				return
			end

			-- ignore some tsserver diagnostics
			local idx = 1
			while idx <= #result.diagnostics do
				local entry = result.diagnostics[idx]

				local formatter = require("format-ts-errors")[entry.code]
				entry.message = formatter and formatter(entry.message) or entry.message

				-- codes: https://github.com/microsoft/TypeScript/blob/main/src/compiler/diagnosticMessages.json
				if entry.code == 80001 then
					-- { message = "File is a CommonJS module; it may be converted to an ES module.", }
					table.remove(result.diagnostics, idx)
				else
					idx = idx + 1
				end
			end

			vim.lsp.diagnostic.on_publish_diagnostics(_, result, ctx, config)
		end,
	}

	return {
		init_options = require("nvim-lsp-ts-utils").init_options,
		on_attach = on_attach,
		capabilities = capabilities,
		settings = settings,
		handlers = handlers,
	}
end

M.jsonls = function()
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities.textDocument.completion.completionItem.snippetSupport = true

	local settings = {
		json = {
			schemas = require("schemastore").json.schemas(),
			validate = { enable = true },
		},
	}
	return {
		on_attach = on_attach,
		settings = settings,
		capabilities = capabilities,
	}
end

M.lua_ls = function()
	return {
		on_attach = on_attach,
		settings = {
			Lua = {
				diagnostics = {
					globals = { "vim" },
				},
			},
		},
	}
end

return M
