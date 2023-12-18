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
		window = require("ofirkai.plugins.nvim-cmp").window, -- I just removed the `FloatBorder:Normal` from the highlights to allow the FloatBorder to be colored, its not a must.

		-- Get lsp icons from ofirkai, requires https://github.com/onsails/lspkind.nvim
		formatting = {
			format = require("lspkind").cmp_format({
				symbol_map = require("ofirkai.plugins.nvim-cmp").kind_icons,
				maxwidth = 50,
				mode = "symbol",
			}),
		},
	})
end

M.dark = function()
	require("ofirkai").setup({})
  setup()
end

M.darkblue = function()
	require("ofirkai").setup({
    theme = 'dark_blue'
  })
  setup()
end

return M
