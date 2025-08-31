local M = {}
local setup = function()
  if package.loaded["lualine"] ~= nil then
    require("lualine").setup({
      options = {
        theme = require("ofirkai.statuslines.lualine").theme,
      },
    })
  end

  require("cmp").setup({
    window = require("ofirkai.plugins.nvim-cmp").window,
  })
end

M.dark = function()
  require("ofirkai").setup({})
  setup()
end

M.darkblue = function()
  require("ofirkai").setup({
    theme = "dark_blue",
  })
  setup()
end

return M
