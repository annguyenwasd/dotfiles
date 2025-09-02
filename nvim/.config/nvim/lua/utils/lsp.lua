local M = {}

local setup_diagnostics = function(bufnr)
  local signs = nil

  signs = require("utils.signs")

  vim.diagnostic.config({
    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = signs.Error,
        [vim.diagnostic.severity.WARN] = signs.Warn,
        [vim.diagnostic.severity.HINT] = signs.Hint,
        [vim.diagnostic.severity.INFO] = signs.Info,
      },
    },
  })

  vim.keymap.set("n", "<leader>ld", vim.diagnostic.open_float, { buffer = bufnr, desc = desc("lsp: Show diagnostics") })

  vim.keymap.set("n", "<leader>dw", function()
    vim.diagnostic.get(nil, {})
    vim.diagnostic.setqflist()
  end, { buffer = bufnr, desc = desc("lsp: show workspace diagnostics") })

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
end

local function setup_lsp(bufnr)
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = bufnr, desc = desc("lsp: rename") })
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr, desc = desc("lsp: Go to definition") })
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = bufnr, desc = desc("lsp: Jumps to the declaration of the symbol under the cursor.") })
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = bufnr, desc = desc("lsp: Jumps to the declaration of the symbol under the cursor.") })
  vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { buffer = bufnr, desc = desc("lsp: show code action") })
  vim.keymap.set({ "n", "v" }, "<leader>CA", "<cmd>LspTypescriptSourceAction<cr>", { buffer = bufnr, desc = desc("lsp: show code action") })
end

local get_ts_ls_config = function()
  local capabilities = require("cmp_nvim_lsp").default_capabilities()
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
    capabilities = capabilities,
    settings = settings,
    handlers = handlers,
    root_dir = function(bufnr, on_dir)
      -- The project root is where the LSP can be started from
      -- As stated in the documentation above, this LSP supports monorepos and simple projects.
      -- We select then from the project root, which is identified by the presence of a package
      -- manager lock file.
      local root_markers = { 'package-lock.json', 'yarn.lock', 'pnpm-lock.yaml', 'bun.lockb', 'bun.lock' }
      -- Give the root markers equal priority by wrapping them in a table
      root_markers = vim.fn.has('nvim-0.11.3') == 1 and { root_markers } or root_markers
      local project_root = vim.fs.root(bufnr, root_markers) or vim.fn.fnamemodify(vim.api.nvim_buf_get_name(bufnr), ":h")


      on_dir(project_root)
    end,
  }
end

M.setup = function()
  vim.lsp.config("lua_ls", {
    settings = {
      Lua = {
        hint = { enable = true },
      },
    },
  })

  vim.lsp.config("ts_ls", get_ts_ls_config())

  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
      setup_lsp(args.buf)
      setup_diagnostics(args.buf)
    end,
  })
end

return M
