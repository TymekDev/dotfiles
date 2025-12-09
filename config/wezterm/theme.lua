---@type Wezterm
local wezterm = require("wezterm")
local M = {}

---@enum (key) tymek.wezterm.Mode
local themes = {
  light = "tokyonight_day",
  dark = "tokyonight_storm",
}

local set_colors = function(config, mode)
  local colors = wezterm.color.get_builtin_schemes()[themes[mode]]
  if mode == "light" then
    colors.background = "#f1f2f7"
    colors.tab_bar.background = "#e1e2e7"
  else
    colors.tab_bar.background = "#1f2335" -- taken from lualine
  end
  config.colors = colors
end

---@return tymek.wezterm.Mode
local mode_detect = function()
  if wezterm.gui and wezterm.gui.get_appearance():find("Light") then
    return "light"
  end
  return "dark"
end

---@param mode tymek.wezterm.Mode
local mode_write = function(mode)
  local cmd = {
    "sh",
    "-c",
    string.format([[echo '%s' > ~/.local/state/tymek-theme/mode]], mode),
  }
  local ok, _, stderr = wezterm.run_child_process(cmd)
  if not ok then
    wezterm.log_error(stderr)
  end
end

---@param win Window
---@param pane Pane
local send_focus_in = function(win, pane)
  win:perform_action(wezterm.action.SendString("\x1B[I"), pane)
end

M.setup = function(config)
  local mode = mode_detect()
  mode_write(mode)

  set_colors(config, mode)

  wezterm.on("window-config-reloaded", function(win, pane)
    send_focus_in(win, pane)
  end)
end

return M
