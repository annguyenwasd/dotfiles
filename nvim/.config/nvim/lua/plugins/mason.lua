return {
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensuie_installed = {
        "html",
        "bashls",
        "lua_ls",
        "ts_ls",
      },
    },
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "neovim/nvim-lspconfig",
    },
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    config = function()
      require("mason-tool-installer").setup({
        ensure_installed = {
          "prettierd",
          "stylua",
          "eslint_d",
        },
      })
    end,
  },
  { "davidosomething/format-ts-errors.nvim" },
}
