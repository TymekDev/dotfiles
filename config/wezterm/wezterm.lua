local sessionizer = require("sessionizer")
local tab_bar = require("tab_bar")
local theme = require("theme")
---@type Wezterm
local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.term = "wezterm"
config.font_size = 16
config.cell_width = 0.9
config.window_padding = {
  top = 0,
  right = 0,
  bottom = 0,
  left = 0,
}
config.window_decorations = "RESIZE"
config.exit_behavior = "Hold"

local local_mux_domain = "sessionizer"
config.default_gui_startup_args = { "connect", local_mux_domain }
config.unix_domains = { { name = local_mux_domain } }

local function cmd_to_meta(key)
  return { key = key, mods = "CMD", action = wezterm.action.SendKey({ key = key, mods = "META" }) }
end

---@param args string[]
---@param pane Pane
local function shell_cmd(args, pane)
  if not pane or pane:get_domain_name() == "local" then
    if #args == 0 then
      return { os.getenv("SHELL") }
    end
    return { os.getenv("SHELL"), "-c", wezterm.shell_join_args(args) }
  end

  local cd_prefix = ""
  local url = pane:get_current_working_dir()
  if url and url.file_path then
    cd_prefix = "cd " .. wezterm.shell_quote_arg(url.file_path) .. " && "
  end

  local args_suffix = ""
  if #args > 0 then
    args_suffix = " -c " .. wezterm.shell_quote_arg(wezterm.shell_join_args(args))
  end

  return {
    "sh",
    "-c",
    cd_prefix .. 'exec "$SHELL"' .. args_suffix,
  }
end

config.leader = { key = " ", mods = "CTRL", timeout_milliseconds = 1000 }
config.keys = {
  cmd_to_meta("a"), -- telescope.nvim
  cmd_to_meta("s"), -- telescope.nvim
  cmd_to_meta("["), -- copilot.lua        cycle between suggestions
  cmd_to_meta("]"), -- copilot.lua        cycle between suggestions
  cmd_to_meta("f"), -- fish & vim-rsi     forward one word
  cmd_to_meta("h"), -- fish               open manpage for current command
  cmd_to_meta("j"), -- copilot.lua        accept suggestion
  cmd_to_meta("k"), -- lsp_signature.nvim toggle signature help
  cmd_to_meta("b"), -- fish & vim-rsi     backward one word
  cmd_to_meta("."), -- fish               insert previous command's last argument

  cmd_to_meta("p"), -- R in nvim
  cmd_to_meta(","), -- R in nvim

  -- These two send SIGQUIT to R console
  { key = "4", mods = "CTRL", action = wezterm.action.Nop },
  { key = "\\", mods = "CTRL", action = wezterm.action.Nop },

  { key = "h", mods = "CMD", action = wezterm.action.ActivatePaneDirection("Left") },
  { key = "l", mods = "CMD", action = wezterm.action.ActivatePaneDirection("Right") },

  { key = "h", mods = "CMD|SHIFT", action = wezterm.action.SplitPane({ direction = "Left" }) },
  { key = "l", mods = "CMD|SHIFT", action = wezterm.action.SplitPane({ direction = "Right" }) },

  { key = "[", mods = "LEADER", action = wezterm.action.ActivateCopyMode },

  -- Sessionizer stuff
  {
    key = "s",
    mods = "LEADER",
    action = wezterm.action_callback(function(win, pane)
      sessionizer.select(
        win,
        pane,
        { "~/personal", "~/work" },
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
    action = wezterm.action_callback(function(win, pane)
      local cmd = shell_cmd({}, pane)
      win:perform_action(wezterm.action.SpawnCommandInNewTab({ args = cmd, domain = "CurrentPaneDomain" }), pane)
    end),
  },
  {
    key = "C",
    mods = "LEADER",
    action = wezterm.action_callback(
      function(win, pane) -- NOTE: we need the wrapper to get the active workspace when the mapping runs (not when it is defined)
        local dir = sessionizer.active_workspace_dir()
        win:perform_action(wezterm.action.SpawnCommandInNewTab({ cwd = dir }), pane)
      end
    ),
  },

  -- Commands mappings
  {
    key = "G",
    mods = "LEADER",
    action = wezterm.action_callback(function(win, pane)
      local cmd = shell_cmd({ "nvim", "+set titlestring=Fugitive", "+Git", "+only" }, pane)
      win:perform_action(wezterm.action.SpawnCommandInNewTab({ args = cmd }), pane)
    end),
  },
  {
    key = "O",
    mods = "LEADER",
    action = wezterm.action_callback(function(win, pane)
      local dir = sessionizer.active_workspace_dir()
      local cmd = shell_cmd({ "opencode", dir }, pane)
      win:perform_action(wezterm.action.SpawnCommandInNewTab({ args = cmd }), pane)
    end),
  },
  {
    key = "T",
    mods = "LEADER",
    action = wezterm.action_callback(function(win, pane)
      local dir = sessionizer.active_workspace_dir()
      local cmd = shell_cmd({ "task", "--dir", dir, "--list", "--json" }, pane)
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
              wezterm.action.SpawnCommandInNewTab({
                args = shell_cmd({ "task", "--dir", dir, id }, pane),
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
