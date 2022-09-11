return function()
	-- darker, lighter, oceanic, palenight, deep ocean
	vim.g.material_style = "deep ocean"
	vim.keymap.set("n", "<leader>tt", require("material.functions").toggle_style)
	set_theme("material")
end
