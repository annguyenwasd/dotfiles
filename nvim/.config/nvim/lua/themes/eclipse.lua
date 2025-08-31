local M = {}

M.light = function()
  vim.o.background = "light"
  set_theme("light-chromeclipse", "auto")
end

return M
