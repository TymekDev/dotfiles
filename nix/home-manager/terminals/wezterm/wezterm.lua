local sessionizer = require("sessionizer")
local tab_bar = require("tab_bar")
local theme = require("theme")
---@type Wezterm
local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.term = "wezterm"
config.font_size = 14
config.window_padding = {
  top = 0,
  right = 0,
  bottom = 0,
  left = 0,
}
config.exit_behavior = "Hold"

config.adjust_window_size_when_changing_font_size = false
config.leader = { key = " ", mods = "CTRL", timeout_milliseconds = 1000 }
config.keys = {
  { key = "w", mods = "SUPER", action = wezterm.action.Nop },

  {
    key = "s",
    mods = "LEADER",
    action = wezterm.action_callback(function(win, pane)
      sessionizer.select(
        win,
        pane,
        { "~/personal", "~/personal/playground" },
        { "~", "~/Documents", "~/Documents/dokumenty", "~/Downloads" }
      )
    end),
  },
  {
    key = "L",
    mods = "LEADER",
    action = wezterm.action_callback(function(win, pane)
      sessionizer.switch_to_last(win, pane)
    end),
  },
  {
    key = "l",
    mods = "LEADER",
    action = wezterm.action.ActivateLastTab,
  },
  {
    key = "c",
    mods = "LEADER",
    action = wezterm.action.SpawnTab("CurrentPaneDomain"),
  },
  {
    key = "C",
    mods = "LEADER",
    action = wezterm.action_callback(function(win, pane)
      local dir = wezterm.mux.get_active_workspace()
      if dir == "default" then
        dir = wezterm.home_dir
      end

      win:perform_action(wezterm.action.SpawnCommandInNewTab({ cwd = dir }), pane)
    end),
  },

  {
    key = "T",
    mods = "LEADER",
    action = wezterm.action_callback(function(win, pane)
      local dir = pane:get_current_working_dir().file_path
      local cmd = { "task", "--dir", dir, "--list", "--json" }
      local ok, stdout, stderr = wezterm.run_child_process(cmd)
      if not ok then
        wezterm.log_error("failed to run the command:", stderr, "\nThe command:", cmd)
        return
      end

      ---@type InputSelectorItem[]
      local choices = {}
      local max_len = 0
      for _, task in ipairs(wezterm.serde.json_decode(stdout).tasks) do
        if #task.name > max_len then
          max_len = #task.name
        end
        table.insert(choices, { id = task.name, label = task.desc })
      end

      for _, choice in ipairs(choices) do
        choice.label = wezterm.pad_right(choice.id, max_len + 5) .. choice.label
      end

      win:perform_action(
        wezterm.action.InputSelector({
          fuzzy = true,
          choices = choices,
          action = wezterm.action_callback(function(_, _, id)
            if not id then
              return
            end

            win:perform_action(
              -- FIXME: this gets closed immediately after the command is done - it's not ideal.
              wezterm.action.SpawnCommandInNewTab({
                args = { "task", "--dir", dir, id },
              }),
              pane
            )
          end),
        }),
        pane
      )
    end),
  },
}

for i = 1, 8 do
  table.insert(config.keys, {
    key = tostring(i),
    mods = "LEADER",
    action = wezterm.action.ActivateTab(i - 1),
  })
end

tab_bar.setup(config)
theme.update(config)

return config
