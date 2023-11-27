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

local function cmd_to_meta(key)
  return { key = key, mods = "CMD", action = wezterm.action.SendKey({ key = key, mods = "META" }) }
end

config.keys = {
  cmd_to_meta("e"), -- fish           edit current command with $EDITOR
  cmd_to_meta("d"), -- fish & vim-rsi delete one word forward
  cmd_to_meta("f"), -- fish & vim-rsi forward one word
  cmd_to_meta("h"), -- fish           open manpage for current command
  cmd_to_meta("j"), -- copilot.lua    accept suggestion
  cmd_to_meta("b"), -- fish & vim-rsi backward one word
  cmd_to_meta("."), -- fish           insert previous command's last argument

  -- These two send SIGQUIT to R console
  { key = "4",  mods = "CTRL", action = wezterm.action.Nop },
  { key = "\\", mods = "CTRL", action = wezterm.action.Nop },
}

return config
