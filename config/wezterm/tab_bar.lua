---@type Wezterm
local wezterm = require("wezterm")
local M = {}

-- TODO: parametrize this, add left/right, and outline
local SEP = ""

---@param window Window
---@return integer
local active_tab_index = function(window)
  for _, tab_info in ipairs(window:mux_window():tabs_with_info()) do
    if tab_info.is_active then
      return tab_info.index
    end
  end
  error("active tab not found")
end

wezterm.on("update-status", function(window, pane)
  local workspace, _ = string.gsub(wezterm.mux.get_active_workspace(), "^" .. wezterm.home_dir, "~")
  ---@type Palette
  local colors = window:effective_config().colors

  local bg_tab = colors.ansi[8] -- TODO: update me
  if window:leader_is_active() then
    bg_tab = colors.ansi[4]
  end

  local bg_next = colors.tab_bar.inactive_tab.bg_color
  if active_tab_index(window) == 0 then
    bg_next = colors.tab_bar.active_tab.bg_color
  end

  window:set_left_status(wezterm.format({
    { Foreground = { Color = colors.tab_bar.active_tab.fg_color } },
    { Background = { Color = bg_tab } },
    { Text = " " .. workspace .. " " },

    { Foreground = { Color = bg_tab } },
    { Background = { Color = colors.tab_bar.background } },
    { Text = SEP },

    { Foreground = { Color = colors.tab_bar.background } },
    { Background = { Color = bg_next } },
    { Text = SEP },
  }))
end)

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
  local tab_index = tab.tab_index + 1
  local title = tab.active_pane.title
  ---@type Palette
  local colors = config.colors
  local bg_inactive = colors.tab_bar.inactive_tab.bg_color
  local bg_active = colors.tab_bar.active_tab.bg_color

  local bg = bg_inactive
  if tab.is_active then
    bg = bg_active
  end

  local bg_next = bg_inactive
  if tab_index == #tabs then -- the last tab
    bg_next = colors.tab_bar.background
  elseif tabs[tab_index + 1].is_active then -- the tab on the right is active
    bg_next = bg_active
  end

  local title_prefix = string.format(" %d ", tab_index)
  title = wezterm.truncate_right(title, max_width - 2 - wezterm.column_width(title_prefix) - wezterm.column_width(SEP))

  -- TODO: tab.is_last_active indicator
  return wezterm.format({
    { Background = { Color = bg } },
    { Text = title_prefix },
    { Text = " " .. title .. " " },
    { Foreground = { Color = bg } },
    { Background = { Color = bg_next } },
    { Text = SEP },
  })
end)

---@param config Config
M.setup = function(config)
  config.show_new_tab_button_in_tab_bar = false
  config.use_fancy_tab_bar = false
  config.tab_max_width = 30
end

return M
