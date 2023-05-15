local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.term = "wezterm"
config.color_scheme = "tokyonight_storm"
config.font_size = 18
config.window_padding = {
  top = 0,
  right = 0,
  bottom = 0,
  left = 0,
}

config.keys = {
  { key = "e", mods = "CMD", action = wezterm.action.SendKey({ key = "e", mods = "META" }) },
  { key = "f", mods = "CMD", action = wezterm.action.SendKey({ key = "f", mods = "META" }) },
  { key = "b", mods = "CMD", action = wezterm.action.SendKey({ key = "b", mods = "META" }) },
}

return config
