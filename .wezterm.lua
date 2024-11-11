local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.automatically_reload_config = true

-- config.color_scheme = "tokyonight_moon"
config.color_scheme = "Night Owl (Gogh)"

config.default_cursor_style = "BlinkingBar"

config.enable_kitty_keyboard = true

config.enable_tab_bar = false

config.font = wezterm.font("FiraCode Nerd Font Mono", { weight = "Regular", stretch = "Normal", style = "Normal" })
config.font_size = 13

config.send_composed_key_when_left_alt_is_pressed = true

config.use_ime = false

config.window_decorations = "RESIZE"
config.window_padding = {
	left = 10,
	right = 10,
	top = 10,
	bottom = 10,
}

return config
