---@type Wezterm
local wezterm = require("wezterm")
local M = {}

---@alias tymek.wezterm.Mode "light"|"dark"

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

---@param config Config
---@param theme tymek.wezterm.Theme|nil
---@param mode tymek.wezterm.Mode
local theme_set = function(config, theme, mode)
  if theme == "rosepine" then
    set_colors_rosepine(config, mode)
  elseif theme == "tokyonight" then
    set_colors_tokyonight(config, mode)
  else
    wezterm.log_error(string.format("Unknown theme: '%s'", theme))
  end
end

---@return tymek.wezterm.Theme|nil
local theme_read = function()
  local ok, theme, stderr = wezterm.run_child_process({
    "sh",
    "-c",
    "cat ~/.local/state/tymek-theme/theme",
  })
  if not ok then
    wezterm.log_error(stderr)
    return nil
  end

  theme = string.gsub(theme, "\n$", "")

  return theme
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

M.setup = function(config)
  wezterm.add_to_config_reload_watch_list(wezterm.home_dir .. "/.local/state/tymek-theme/theme")

  local mode = mode_detect()
  mode_write(mode)

  local theme = theme_read()
  theme_set(config, theme, mode)
end

return M
