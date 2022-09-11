return function()
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
			local win_width = vim.fn.winwidth(0)
			if hide_width and win_width < hide_width then
				return ""
			elseif trunc_width and trunc_len and win_width < trunc_width and #str > trunc_len then
				return str:sub(1, trunc_len) .. (no_ellipsis and "" or "...")
			end
			return str
		end
	end

	local diagnostic = {
		"diagnostics",
		sources = { "nvim_diagnostic" },
		colored = false,
	}

	local branch = { "branch", icon = "", fmt = trunc(150, 20, 60) }
	local diff = { "diff", source = diff_source, colored = false }
	local jump_to_middle = "%="
	local name_with_flag = {
		"%f %m",
		fmt = trunc(100, 40, 39),
	}

	require("lualine").setup({
		options = {
			icons_enabled = true,
			theme = "auto",
			component_separators = { left = "", right = "" },
			section_separators = { left = "", right = "" },
			disabled_filetypes = { "gitcommit", "NvimTree" },
			always_divide_middle = true,
		},
		sections = {
			lualine_a = {},
			lualine_b = {},
			lualine_c = {
				"fileformat",
				"encoding",
				branch,
				jump_to_middle,
				diagnostic,
				name_with_flag,
			},
			lualine_x = {
				diff,
				"progress",
				"location",
			},
			lualine_y = {},
			lualine_z = {},
		},
		inactive_sections = {
			lualine_a = {},
			lualine_b = {},
			lualine_c = {
				jump_to_middle,
				name_with_flag,
			},
			lualine_x = {},
			lualine_y = {},
			lualine_z = {},
		},
		tabline = {},
		extensions = {},
	})
end
