local M = {}

-- background: dark, light
-- forceground: original, mix, material
-- contrast: hard, medium, soft
local function make_theme(background, forceground, contrast)
	vim.g.gruvbox_material_enable_bold = 1
	vim.g.gruvbox_material_better_performance = 1

	vim.o.background = background
	vim.g.gruvbox_material_background = contrast
	vim.g.gruvbox_material_foreground = forceground

	set_theme("gruvbox-material")
end

M.dark_original_medium = function()
	make_theme("dark", "original", "medium")
end

M.light_original_medium = function()
	make_theme("light", "original", "medium")
end

M.dark_mix_medium = function()
	make_theme("dark", "mix", "medium")
end

M.light_mix_medium = function()
	make_theme("light", "mix", "medium")
end

M.dark_material_medium = function()
	make_theme("dark", "material", "medium")
end

M.light_material_medium = function()
	make_theme("light", "material", "medium")
end

M.dark_original_soft = function()
	make_theme("dark", "original", "soft")
end

M.light_original_soft = function()
	make_theme("light", "original", "soft")
end

M.dark_mix_soft = function()
	make_theme("dark", "mix", "soft")
end

M.light_mix_soft = function()
	make_theme("light", "mix", "soft")
end

M.dark_material_soft = function()
	make_theme("dark", "material", "soft")
end

M.light_material_soft = function()
	make_theme("light", "material", "soft")
end

M.dark_original_hard = function()
	make_theme("dark", "original", "hard")
end

M.light_original_hard = function()
	make_theme("light", "original", "hard")
end

M.dark_mix_hard = function()
	make_theme("dark", "mix", "hard")
end

M.light_mix_hard = function()
	make_theme("light", "mix", "hard")
end

M.dark_material_hard = function()
	make_theme("dark", "material", "hard")
end

M.light_material_hard = function()
	make_theme("light", "material", "hard")
end

return M
