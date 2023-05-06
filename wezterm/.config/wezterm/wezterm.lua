-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

config.color_scheme = "nord"
config.enable_tab_bar = false
config.window_decorations = "NONE"
config.font = wezterm.font("Source Code Pro")
-- and finally, return the configuration to wezterm
return config
