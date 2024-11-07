local wezterm = require("wezterm")
local M = {}

---@type tymek.wezterm.Mode|nil
local force = nil

---@enum (key) tymek.wezterm.Mode
local theme = {
  light = "tokyonight_day",
  dark = "tokyonight_storm",
}

---@return tymek.wezterm.Mode
local detect = function()
  if force ~= nil then
    return force
  elseif wezterm.gui and wezterm.gui.get_appearance():find("Light") then
    return "light"
  end
  return "dark"
end

---@param mode tymek.wezterm.Mode
local set_colors = function(config, mode)
  local colors = wezterm.color.get_builtin_schemes()[theme[mode]]
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

M.set = function(config)
  local mode = detect()
  set_colors(config, mode)

  local ok, _, stderr = wezterm.run_child_process({
    "sh",
    "-c",
    'echo "' .. mode .. '" > /tmp/tymek-theme',
  })
  if not ok then
    error(stderr, 0)
  end
end

return M
