local M = {}

M.dark = function()
  require("night-owl").setup()
  set_theme("night-owl", "night-owl")
end

return M
