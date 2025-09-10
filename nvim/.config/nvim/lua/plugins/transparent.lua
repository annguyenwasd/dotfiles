return {
  "xiyaowong/transparent.nvim",
  lazy = false,
  config = function()
    require("transparent").setup({
      enable = true,
      extra_groups = {
        "Normal",
        "NormalNC",
        "TelescopeNormal",
        "NvimTreeNormal",
        "EndOfBuffer",
      },
    })

    vim.cmd("TransparentEnable")
  end,
  keys = {
    {
      "<leader>tt",
      "<cmd>TransparentToggle<cr>",
      desc = desc("theme: Toggle transparent"),
    },
  },
}
