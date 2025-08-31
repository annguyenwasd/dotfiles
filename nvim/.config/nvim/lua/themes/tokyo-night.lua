local M = {}

M.default = function()
  set_theme("tokyonight", "tokyonight")
end

M.storm = function()
  set_theme("tokyonight-storm", "tokyonight")
end

M.day = function()
  set_theme("tokyonight-day", "tokyonight")
end

M.noon = function()
  set_theme("tokyonight-noon", "tokyonight")
end

M.night = function()
  vim.o.background = "dark"
  set_theme("tokyonight-night", "tokyonight")
end

return M
