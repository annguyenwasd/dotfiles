local M = {}

local function common()
  vim.keymap.set("n", "<leader>ts", require("material.functions").toggle_style)
end

M.deep_ocean = function()
  common()
  vim.g.material_style = "deep ocean"
  set_theme("material")
end

M.lighter = function()
  common()
  vim.g.material_style = "lighter"
  set_theme("material")
end

M.oceanic = function()
  common()
  vim.g.material_style = "oceanic"
  set_theme("material")
end

M.palenight = function()
  common()
  vim.g.material_style = "palenight"
  set_theme("material")
end

M.darker = function()
  common()
  vim.g.material_style = "darker"
  set_theme("material")
end

return M
