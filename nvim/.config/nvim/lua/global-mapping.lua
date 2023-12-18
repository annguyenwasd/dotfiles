_G.is_mac_os = function()
	return vim.loop.os_uname().sysname == "Darwin"
end

_G.is_work_profile = function()
	return os.getenv("ANNGUYENWASD_PROFILE") == "work"
end

_G.set_theme = function(theme_name, lualine_theme)
	vim.cmd("colorscheme " .. theme_name)
	if package.loaded["lualine"] ~= nil then
		require("lualine").setup({ options = { theme = lualine_theme or theme_name } })
	end
end

_G.merge_table = function(t1, t2)
	for key, value in pairs(t2) do
		t1[key] = value
	end

	return t1
end

_G.make_desc = function(desc)
	local str
	if desc ~= nil then
		str = "[🧩 ] " .. desc
  else
		str = "[🧩 ] No desc provided"
	end
	return str
end

--- Make mapping options
--- @param _desc string description
--- @param opts table vim.keymap.set's opts
_G.make_mapping_opts = function(_desc, opts)
	local desc_table = { desc = make_desc(_desc) }
	if opts ~= nil and type(opts) == "table" then
		return merge_table(opts, desc_table)
	end

	return desc_table
end

_G.make_on_attach_opts = function(bufnr)
	return function(_desc)
		local opts = { buffer = bufnr }
		if type(_desc) == "table" then
			return merge_table(opts, _desc)
		end

		return merge_table(opts, { desc = make_desc(_desc) })
	end
end
