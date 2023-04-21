local M = {}
local on_attach = require("plugin-configs.lsp.common").setup_on_attach()

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
					globals = { "vim", "packer_bootstrap" },
				},
			},
		},
	}
end

return M
