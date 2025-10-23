-- NOTE: make sure to update the config path with:
--   defaults write org.hammerspoon.Hammerspoon MJConfigFile "~/.config/hammerspoon/init.lua"
hs.loadSpoon("EmmyLua")

hs.hotkey.bind({ "cmd" }, "return", function()
  hs.application.launchOrFocus("wezterm")
end)
