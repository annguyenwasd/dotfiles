return {
  "mfussenegger/nvim-lint",
  config = function()
    local lint = require("lint")

    lint.linters_by_ft = {
      javascript = { "eslint_d" },
      typescript = { "eslint_d" },
      javascriptreact = { "eslint_d" },
      typescriptreact = { "eslint_d" },
    }

    -- local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

    --[[ vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			group = lint_augroup,
			callback = function()
        vim.diagnostic.reset();
				lint.try_lint()
			end,
		}) ]]
  end,
  keys = {
    { "<leader>li", "<cmd>lua require'lint'.try_lint()<cr>", desc = desc("lsp: Trigger linting for current file") },
  },
}
