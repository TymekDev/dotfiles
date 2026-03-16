hs.loadSpoon("EmmyLua")

hs.hotkey.bind({ "cmd", "ctrl" }, "return", function()
  hs.application.launchOrFocus("wezterm")
end)

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

local cmd_h
cmd_h = hs.hotkey.bind({ "cmd" }, "h", function()
  local win = hs.window.focusedWindow()
  if
    win and win
      :application()--[[@as hs.application]]
      :name() ~= "WezTerm"
  then
    return
  end

  cmd_h:disable()
  hs.eventtap.keyStroke({ "cmd" }, "h")
  cmd_h:enable()
end)

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
