-- NOTE: make sure to update the config path with:
--   defaults write org.hammerspoon.Hammerspoon MJConfigFile "~/.config/hammerspoon/init.lua"
hs.loadSpoon("EmmyLua")

-- FIXME: this clashes with inputs that have an alternative submit method on Cmd+Enter
-- hs.hotkey.bind({ "cmd" }, "return", function()
--   hs.application.launchOrFocus("wezterm")
-- end)

---@type hs.hotkey
local cmd_w
cmd_w = hs.hotkey.bind({ "cmd" }, "w", function()
  local win = hs.window.focusedWindow()
  if
    win and win
      :application()--[[@as hs.application]]
      :name() == "Windows App"
  then
    return
  end

  cmd_w:disable()
  hs.eventtap.keyStroke({ "cmd" }, "w")
  cmd_w:enable()
end)

hs.hotkey.bind({ "cmd" }, "h", function() end)

local modFocus = { "cmd", "ctrl" }
hs.hotkey.bind(modFocus, "h", function()
  local win = hs.window.focusedWindow()
  if win then
    win:focusWindowWest(nil, true)
  end
end)
hs.hotkey.bind(modFocus, "j", function()
  local win = hs.window.focusedWindow()
  if win then
    win:focusWindowSouth(nil, true)
  end
end)
hs.hotkey.bind(modFocus, "k", function()
  local win = hs.window.focusedWindow()
  if win then
    win:focusWindowNorth(nil, true)
  end
end)
hs.hotkey.bind(modFocus, "l", function()
  local win = hs.window.focusedWindow()
  if win then
    win:focusWindowEast(nil, true)
  end
end)

hs.hotkey.setLogLevel("warning")
