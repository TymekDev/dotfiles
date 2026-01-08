-- NOTE: make sure to update the config path with:
--   defaults write org.hammerspoon.Hammerspoon MJConfigFile "~/.config/hammerspoon/init.lua"
hs.loadSpoon("EmmyLua")

-- FIXME: this clashes with inputs that have an alternative submit method on Cmd+Enter
-- hs.hotkey.bind({ "cmd" }, "return", function()
--   hs.application.launchOrFocus("wezterm")
-- end)
