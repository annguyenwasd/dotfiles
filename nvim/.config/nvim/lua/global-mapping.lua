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

_G.desc = function(desc)
	local str
	if desc ~= nil then
		str = "[annguyenwasd ] " .. desc
  else
		str = "[annguyenwasd ] No desc provided"
	end
	return str
end
