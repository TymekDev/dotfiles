---@type Wezterm
local wezterm = require("wezterm")
local M = {}

---@enum (key) tymek.wezterm.Mode
local themes = {
  light = "tokyonight_day",
  dark = "tokyonight_storm",
}

M.update = function(config)
  local mode = wezterm.gui.get_appearance():lower()
  local theme = themes[mode]
  local colors = wezterm.color.get_builtin_schemes()[theme]

  if theme == "tokyonight_day" then
    colors.background = "#f1f2f7"
    colors.tab_bar.background = "#cfd4e2" -- taken from lualine
  elseif theme == "tokyonight_storm" then
    colors.tab_bar.background = "#1f2335" -- taken from lualine
  end

  config.colors = colors
end

return M
