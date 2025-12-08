---@type Wezterm
local wezterm = require("wezterm")
local M = {}

wezterm.on("update-status", function(window, pane)
  local workspace, _ = string.gsub(wezterm.mux.get_active_workspace(), "^" .. wezterm.home_dir, "~")
  local colors = window:effective_config().resolved_palette.tab_bar

  local bg = { Color = colors.active_tab.bg_color }
  if window:leader_is_active() then
    bg = { AnsiColor = "Yellow" }
  end

  window:set_left_status(wezterm.format({
    { Background = bg },
    { Foreground = { Color = colors.active_tab.fg_color } },
    { Text = " " .. workspace .. " " },

    { Background = { Color = colors.background } },
    { Foreground = bg },
    { Text = "" },
  }))
end)

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
  local colors = config.resolved_palette.tab_bar
  local bar_bg = colors.background
  local tab_bg = colors.active_tab.bg_color
  if not tab.is_active then
    tab_bg = colors.inactive_tab.bg_color
  end

  -- Account for characters that we add for styling
  local title = " " .. tab.active_pane.title:sub(1, max_width - 4) .. " "
  title, _ = string.gsub(title, "  $", " ")

  return wezterm.format({
    { Background = { Color = tab_bg } },
    { Foreground = { Color = bar_bg } },
    { Text = "" },
    "ResetAttributes",

    { Text = title },

    { Background = { Color = bar_bg } },
    { Foreground = { Color = tab_bg } },
    { Text = "" },
  })
end)

---@param config Config
M.setup = function(config)
  config.show_new_tab_button_in_tab_bar = false
  config.use_fancy_tab_bar = false
  config.tab_max_width = 30
end

return M
