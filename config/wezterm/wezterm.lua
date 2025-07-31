local theme = require("theme")
---@type Wezterm
local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.term = "wezterm"
config.font = wezterm.font("JetBrainsMono Nerd Font")
config.font_size = 19
config.window_padding = {
  top = 0,
  right = 0,
  bottom = 0,
  left = 0,
}
config.window_decorations = "RESIZE"

local function cmd_to_meta(key)
  return { key = key, mods = "CMD", action = wezterm.action.SendKey({ key = key, mods = "META" }) }
end

config.keys = {
  cmd_to_meta("a"), -- telescope.nvim
  cmd_to_meta("s"), -- telescope.nvim
  cmd_to_meta("e"), -- fish               edit current command with $EDITOR
  cmd_to_meta("["), -- copilot.lua        cycle between suggestions
  cmd_to_meta("]"), -- copilot.lua        cycle between suggestions
  cmd_to_meta("d"), -- fish & vim-rsi     delete one word forward
  cmd_to_meta("f"), -- fish & vim-rsi     forward one word
  cmd_to_meta("h"), -- fish               open manpage for current command
  cmd_to_meta("j"), -- copilot.lua        accept suggestion
  cmd_to_meta("k"), -- lsp_signature.nvim toggle signature help
  cmd_to_meta("b"), -- fish & vim-rsi     backward one word
  cmd_to_meta("."), -- fish               insert previous command's last argument

  cmd_to_meta("p"), -- R in nvim
  cmd_to_meta(","), -- R in nvim

  -- These two send SIGQUIT to R console
  { key = "4", mods = "CTRL", action = wezterm.action.Nop },
  { key = "\\", mods = "CTRL", action = wezterm.action.Nop },

  { key = "h", mods = "CMD", action = wezterm.action.ActivatePaneDirection("Left") },
  { key = "l", mods = "CMD", action = wezterm.action.ActivatePaneDirection("Right") },

  { key = "h", mods = "CMD|SHIFT", action = wezterm.action.SplitPane({ direction = "Left" }) },
  { key = "l", mods = "CMD|SHIFT", action = wezterm.action.SplitPane({ direction = "Right" }) },
}

local is_windows = package.config:sub(1, 1) == "\\"
if is_windows then
  config.default_domain = "WSL:Ubuntu-24.04"
  config.font_size = 14
  config.prefer_egl = true
end

theme.set(config, is_windows)

return config
