local wezterm = require("wezterm")
local M = {}

---@alias tymek.wezterm.Mode "light"|"dark"

local force = {
  ---@type tymek.wezterm.Mode|nil
  mode = nil,
  ---@type tymek.wezterm.Theme
  theme = "tokyonight",
}

---@enum (key) tymek.wezterm.Theme
local themes = {
  ---@type table<tymek.wezterm.Mode, string>
  rosepine = {
    light = "dawn",
    dark = "moon",
  },
  ---@type table<tymek.wezterm.Mode, string>
  tokyonight = {
    light = "tokyonight_day",
    dark = "tokyonight_storm",
  },
}

---@return tymek.wezterm.Mode
local detect = function()
  if force.mode ~= nil then
    return force.mode
  elseif wezterm.gui and wezterm.gui.get_appearance():find("Light") then
    return "light"
  end
  return "dark"
end

local set_colors_rosepine = function(config, mode)
  local theme = require("./rose-pine/plugin")[themes.rosepine[mode]]
  config.colors = theme.colors()
  config.window_frame = theme.window_frame()
end

local set_colors_tokyonight = function(config, mode)
  local colors = wezterm.color.get_builtin_schemes()[themes.tokyonight[mode]]
  local active_titlebar_bg
  if mode == "light" then
    colors.background = "#f1f2f7"
    active_titlebar_bg = "#e1e2e7"
  else
    active_titlebar_bg = "#1f2335" -- taken from lualine
  end
  config.colors = colors
  config.window_frame = {
    active_titlebar_bg = active_titlebar_bg,
  }
end

M.set = function(config, is_windows)
  local mode = detect()
  local theme = force.theme

  if theme == "rosepine" then
    set_colors_rosepine(config, mode)
  elseif theme == "tokyonight" then
    set_colors_tokyonight(config, mode)
  else
    wezterm.log_error(string.format("Unknown theme: '%s'", theme))
  end

  local cmd = {
    "sh",
    "-c",
    string.format([[echo '{"mode": "%s", "theme": "%s"}' > ~/.local/state/tymek-theme]], mode, theme),
  }
  if is_windows == true then
    table.insert(cmd, 1, "wsl")
  end
  local ok, _, stderr = wezterm.run_child_process(cmd)
  if not ok then
    wezterm.log_error(stderr)
  end
end

return M
