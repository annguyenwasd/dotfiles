local M = {}

M.light = function()
  vim.o.background = "light"
  set_theme("vscode")
end

M.dark = function()
  vim.o.background = "dark"
  set_theme("vscode")
end

return M
