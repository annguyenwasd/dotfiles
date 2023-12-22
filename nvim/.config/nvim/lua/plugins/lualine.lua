return {
	{
		"nvim-lualine/lualine.nvim",
		config = function()
			local function diff_source()
				local gitsigns = vim.b.gitsigns_status_dict
				if gitsigns then
					return {
						added = gitsigns.added,
						modified = gitsigns.changed,
						removed = gitsigns.removed,
					}
				end
			end

			--- @param trunc_width number trunctates component when screen width is less then trunc_width
			--- @param trunc_len number truncates component to trunc_len number of chars
			--- @param hide_width number hides component when window width is smaller then hide_width
			--- @param no_ellipsis boolean whether to disable adding '...' at end after truncation
			--- return function that can format the component accordingly
			local function trunc(trunc_width, trunc_len, hide_width, no_ellipsis)
				return function(str)
					local branch_name = str
					local win_width = vim.fn.winwidth(0)
					if hide_width and win_width < hide_width then
						return ""
					elseif trunc_width and trunc_len and win_width < trunc_width and #str > trunc_len then
						branch_name = str:sub(1, trunc_len) .. (no_ellipsis and "" or "...")
					end

					if vim.b.is_bare then
						return "[bare] " .. branch_name
					else
						return branch_name
					end
				end
			end

			vim.api.nvim_create_autocmd({ "FileType", "BufEnter", "FocusGained" }, {
				callback = function()
					local git_output = vim.fn.system("git config --local core.bare", true)
					vim.b.is_bare = string.find(git_output, "true", 1, true) ~= nil
				end,
			})

      local signs = require"utils.lsp".signs

			local diagnostic = {
				"diagnostics",
				sources = { "nvim_diagnostic" },
				colored = false,
				symbols = { error = signs.Error, warn = signs.Warn, hint = signs.Hint, info = signs.Info},
			}

			local branch = { "branch", icon = "" }
			local diff = { "diff", source = diff_source, colored = false }
			local file_name = {
				"filename",
				path = 3,
				shorting_target = 40,
			}

			require("lualine").setup({
				options = {
					icons_enabled = true,
					theme = "auto",
					component_separators = { left = "", right = "" },
					section_separators = { left = "", right = "" },
					disabled_filetypes = { "gitcommit", "NvimTree", "mind" },
					always_divide_middle = true,
				},
				sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = {
						file_name,
						diagnostic,
						diff,
					},
					lualine_x = {
						branch,
						"progress",
						"location",
						"fileformat",
						"encoding",
					},
					lualine_y = {},
					lualine_z = {},
				},
				inactive_sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = {
						file_name,
					},
					lualine_x = {},
					lualine_y = {},
					lualine_z = {},
				},
				tabline = {},
				extensions = {},
			})
		end,
	},
}
