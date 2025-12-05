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

config.leader = { key = " ", mods = "CTRL", timeout_milliseconds = 1000 }
config.keys = {
  { key = "w", mods = "SUPER", action = wezterm.action.Nop },
  { key = "t", mods = "SUPER|SHIFT", action = wezterm.action_callback(theme.cycle_theme) },

  {
    key = "s",
    mods = "LEADER",
    action = wezterm.action_callback(function(win, pane)
      sessionizer.select(win, pane, { "~/personal" })
    end),
  },
  {
    key = "l",
    mods = "LEADER",
    action = wezterm.action_callback(function(win, pane)
      sessionizer.switch_to_last(win, pane)
    end),
  },
}

theme.setup(config)

return config
