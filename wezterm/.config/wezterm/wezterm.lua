local wezterm = require("wezterm")

local config = wezterm.config_builder and wezterm.config_builder() or {}

config.color_scheme = "nord"
config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true
config.window_decorations = "RESIZE"

config.keys = {
	{ key = "h", mods = "CMD", action = wezterm.action.ActivatePaneDirection("Left") },
	{ key = "j", mods = "CMD", action = wezterm.action.ActivatePaneDirection("Down") },
	{ key = "k", mods = "CMD", action = wezterm.action.ActivatePaneDirection("Up") },
	{ key = "l", mods = "CMD", action = wezterm.action.ActivatePaneDirection("Right") },

	{ key = "[", mods = "CMD|SHIFT", action = wezterm.action.ActivateTabRelative(-1) },
	{ key = "]", mods = "CMD|SHIFT", action = wezterm.action.ActivateTabRelative(1) },
	{ key = "LeftArrow", mods = "CMD|ALT", action = wezterm.action.ActivateWindowRelative(-1) },
	{ key = "RightArrow", mods = "CMD|ALT", action = wezterm.action.ActivateWindowRelative(1) },
}

return config
