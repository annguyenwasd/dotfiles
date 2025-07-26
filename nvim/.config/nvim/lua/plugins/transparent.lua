return {
  "xiyaowong/transparent.nvim",
  config = function()
    require("transparent").setup({
      enable = true,
      extra_groups = {
        "Normal", "NormalNC", "TelescopeNormal", "NvimTreeNormal", "EndOfBuffer",
      },
    })

    vim.cmd("TransparentEnable");

  end,
}
