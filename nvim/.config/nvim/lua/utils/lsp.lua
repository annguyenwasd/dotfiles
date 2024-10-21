local M = {}

local map_default_lsp_fns = function(bufnr)
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = bufnr, desc = desc("lsp: rename") })
	vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = bufnr, desc = desc("lsp: show code action") })
	vim.keymap.set("n", "]d", function()
		vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
	end, { buffer = bufnr, desc = desc("lsp: next diagnostic") })
	vim.keymap.set("n", "[d", function()
		vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })
	end, { buffer = bufnr, desc = desc("lsp: prev diagnostic") })
	vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr, desc = desc("lsp: hover") })
end

local map_lsp_ui_fns = function(bufnr)
	vim.keymap.set("n", "<leader>rn", "<cmd>LspUI rename<cr>", { buffer = bufnr, desc = desc("lsp: rename") })
	vim.keymap.set(
		"n",
		"<leader>ca",
		"<cmd>LspUI code_action<cr>",
		{ buffer = bufnr, desc = desc("lsp: show code action") }
	)
	-- vim.keymap.set("n", "]d", "<cmd>LspUI diagnostic next<cr>", { buffer = bufnr, desc = desc("lsp: next diagnostic") })
	-- vim.keymap.set("n", "[d", "<cmd>LspUI diagnostic prev<cr>", { buffer = bufnr, desc = desc("lsp: prev diagnostic") })
	vim.keymap.set("n", "K", "<cmd>LspUI hover<cr>", { buffer = bufnr, desc = desc("lsp: hover") })
end

local signs = {
	Error = " ",
	Warn = " ",
	Info = " ",
	Hint = " ",
}

if not is_use_icons() then
	signs = {
		Error = "E ",
		Warn = "W ",
		Info = "I ",
		Hint = "H ",
	}
end
M.signs = signs

local get_on_attach_fn = function()
	for type, icon in pairs(signs) do
		local hl = "DiagnosticSign" .. type
		vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
	end

	local setup_ts_tools = function(_, bufnr)
		vim.keymap.set(
			"n",
			"<leader><leader>oi",
			"<cmd>TSToolsOrganizeImports<CR>",
			{ buffer = bufnr, desc = desc("lsp(typescript): Organize imports") }
		)
		vim.keymap.set(
			"n",
			"<leader><leader>si",
			"<cmd>TSToolsSortImports<CR>",
			{ buffer = bufnr, desc = desc("lsp(typescript): Sort imports") }
		)
		vim.keymap.set(
			"n",
			"<leader><leader>gd",
			"<cmd>TSToolsGoToSourceDefinition<CR>",
			{ buffer = bufnr, desc = desc("lsp(typescript): go to source definition (since TS v. 4.7)") }
		)
		vim.keymap.set(
			"n",
			"<leader><leader>gr",
			"<cmd>TSToolsFileReferences<CR>",
			{ buffer = bufnr, desc = desc("lsp(typescript): go to file references (since TS v. 4.2)") }
		)
		vim.keymap.set(
			"n",
			"<leader><leader>ru",
			"<cmd>TSToolsRemoveUnused<CR>",
			{ buffer = bufnr, desc = desc("lsp(typescript): remove unused statements") }
		)
		vim.keymap.set(
			"n",
			"<leader>rf",
			"<cmd>TSToolsRenameFile<CR>",
			{ buffer = bufnr, desc = desc("lsp(typescript): Rename file") }
		)
		vim.keymap.set(
			"n",
			"<leader><leader>i",
			"<cmd>TSToolsAddMissingImports<CR>",
			{ buffer = bufnr, desc = desc("lsp(typescript): Import missing imports") }
		)
		vim.keymap.set(
			"n",
			"<leader><leader>fa",
			"<cmd>TSToolsFixAll<CR>",
			{ buffer = bufnr, desc = desc("lsp(typescript): fix all - not sure if it works :)") }
		)
	end

	return function(client, bufnr)
		if client.name == "typescript-tools" then
			setup_ts_tools(client, bufnr)
		end

		if vim.lsp.inlay_hint then
			vim.lsp.inlay_hint.enable(false)
		end

		if is_work_profile() then
			require("work").lsp_on_attach_fns(bufnr)
		end

		vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

		vim.keymap.set(
			"n",
			"gD",
			vim.lsp.buf.declaration,
			{ buffer = bufnr, desc = desc("lsp: Jumps to the declaration of the symbol under the cursor.") }
		)
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr, desc = desc("lsp: Go to definition") })
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {
			buffer = bufnr,
			desc = desc("lsp: Lists all the implementations for the symbol under the cursor in the quickfix window."),
		})
		vim.keymap.set(
			"n",
			"gy",
			vim.lsp.buf.type_definition,
			{ buffer = bufnr, desc = desc("lsp: show type definitions") }
		)

		vim.keymap.set("n", "<leader>ti", function()
			if vim.lsp.inlay_hint.is_enabled() then
				vim.lsp.inlay_hint.enable(false)
			else
				vim.lsp.inlay_hint.enable(true)
			end
		end, { buffer = bufnr, desc = desc("lsp: toggle inlayHints") })

		vim.keymap.set("n", "gvd", function()
			vim.cmd("vsp")
			vim.lsp.buf.definition()
		end, { buffer = bufnr, desc = desc("lsp: Split vertical pane then go to definition") })

		vim.keymap.set("n", "gsd", function()
			vim.cmd("sp")
			vim.lsp.buf.definition()
		end, { buffer = bufnr, desc = desc("lsp: Split horizontal pane then go to definition") })

		vim.keymap.set(
			"n",
			"<c-s>",
			vim.lsp.buf.signature_help,
			{ buffer = bufnr, desc = desc("lsp: Show signature help") }
		)
		vim.keymap.set(
			"i",
			"<c-s>",
			vim.lsp.buf.signature_help,
			{ buffer = bufnr, desc = desc("lsp: Show signature help") }
		)

		vim.keymap.set(
			"n",
			"gr",
			vim.lsp.buf.references,
			{ buffer = bufnr, desc = desc("lsp: Show lsp references on") }
		)
		vim.keymap.set(
			"n",
			"gi",
			vim.lsp.buf.implementation,
			{ buffer = bufnr, desc = desc("lsp: show implementations") }
		)

		vim.keymap.set("n", "<leader>da", function()
			local diagnostics = vim.diagnostic.get(0, {})
			local qflist = vim.diagnostic.toqflist(diagnostics)
			vim.fn.setqflist(qflist)
			vim.cmd("cw")
		end, { buffer = bufnr, desc = desc("lsp: show document diagnostics") })

		vim.keymap.set("n", "<leader>dt", function()
			if vim.diagnostic.is_disabled() then
				vim.diagnostic.enable()
			else
				vim.diagnostic.disable()
			end
		end, { buffer = bufnr, desc = desc("lsp: toggle diagnostic") })

		vim.keymap.set("n", "<leader>dw", function()
			vim.diagnostic.get(nil, {})
			vim.diagnostic.setqflist()
		end, { buffer = bufnr, desc = desc("lsp: show workspace diagnostics") })

		vim.keymap.set(
			"n",
			"<leader>ld",
			vim.diagnostic.open_float,
			{ buffer = bufnr, desc = desc("lsp: Show diagnostics") }
		)

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
		publish_diagnostic_on = "insert_leave",
		jsx_close_tag = {
			enable = false,
			filetypes = { "javascriptreact", "typescriptreact" },
		},
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
		["textDocument/publishDiagnostics"] = vim.lsp.with(function(_, result, ctx, config)
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
		end, {
			underline = true,
			virtual_text = {
				spacing = 5,
			},
			update_in_insert = true,
		}),
	}

	return {
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
				hint = { enable = true },
				diagnostics = {
					globals = { "vim" },
				},
			},
		},
	}
end

return M
