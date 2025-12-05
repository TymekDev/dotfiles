local sessionizer = require("sessionizer")
local theme = require("theme")
---@type Wezterm
local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.term = "wezterm"
config.font_size = 14
config.window_padding = {
  top = 0,
  right = 0,
  bottom = 0,
  left = 0,
}

config.keys = {
  { key = "w", mods = "SUPER", action = wezterm.action.Nop },
  { key = "t", mods = "SUPER|SHIFT", action = wezterm.action_callback(theme.cycle_theme) },

  {
    key = "s",
    mods = "CTRL",
    action = wezterm.action_callback(function(win, pane)
      sessionizer.select(win, pane, { "~/personal" })
    end),
  },
}

theme.setup(config)

return config
