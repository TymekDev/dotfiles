---@type Wezterm
local wezterm = require("wezterm")
local M = {}

---@alias InputSelectorItem {id: string, label: string}

---@param dirs string[]
---@return string[]
local list_subdirs = function(dirs)
  if #dirs == 0 then
    wezterm.log_error("list_subdirs: no args provided")
    return {}
  end

  local home = wezterm.home_dir
  local cmd = { "find", "-type", "d", "-maxdepth", "1" }
  for _, dir in ipairs(dirs) do
    dir, _ = string.gsub(dir, "^~", home)
    table.insert(cmd, 2, dir)
  end

  local ok, stdout, stderr = wezterm.run_child_process(cmd)
  if not ok then
    wezterm.log_error("list_subdirs: failed to run the command:", stderr, "\nThe command:", cmd)
    return {}
  end

  return wezterm.split_by_newlines(stdout)
end

---@param dirs string[]
---@return InputSelectorItem[]
local dirs_to_choices = function(dirs)
  if not dirs or #dirs == 0 then
    wezterm.log_warn("dirs_to_choices: no dirs were provided")
    return {}
  end

  ---@type InputSelectorItem[]
  local choices = {}
  for _, dir in ipairs(dirs) do
    local label, _ = string.gsub(dir, "^" .. wezterm.home_dir, "~")
    if label == "~" then
      label = wezterm.format({
        { Text = "~ " },
        { Attribute = { Italic = true } },
        { Text = "(default)" },
      })
    end
    table.insert(choices, { id = dir, label = label })
  end

  table.sort(choices, function(a, b)
    return a.label < b.label
  end)

  return choices
end

local id_to_name = function(id)
  local name = id
  if name == wezterm.home_dir then
    name = "default"
  end
  return name
end

---@param choices InputSelectorItem[]
---@return InputSelectorItem[]
local format_choices = function(choices)
  local active_workspace = wezterm.mux.get_active_workspace()
  local workspaces = {}
  for _, ws in ipairs(wezterm.mux.get_workspace_names()) do
    workspaces[ws] = 0
  end

  for _, choice in ipairs(choices) do
    local name = id_to_name(choice.id)
    if name == active_workspace then
      choice.label = "󰐍  " .. choice.label
    elseif workspaces[name] ~= nil then
      choice.label = "󰏦  " .. choice.label
    else
      choice.label = "   " .. choice.label
    end
  end

  return choices
end

local switch_to_id = function(window, pane, id)
  wezterm.GLOBAL.sessionizer_last_id = wezterm.mux.get_active_workspace()

  window:perform_action(
    wezterm.action.SwitchToWorkspace({
      -- NOTE: I don't use label purposefully, so I can use wezterm.format for the InputSelector
      name = id_to_name(id),
      spawn = { cwd = id },
    }),
    pane
  )
end

---@param window Window
---@param pane Pane
---@param subdirs_of string[] Those directories and their direct subdirectories will be available for selection.
---@param extra_dirs string[]? Additional directories to include
M.select = function(window, pane, subdirs_of, extra_dirs)
  local dirs = list_subdirs(subdirs_of)
  for _, dir in ipairs(extra_dirs or {}) do
    dir, _ = string.gsub(dir, "^~", wezterm.home_dir)
    table.insert(dirs, dir)
  end
  local choices = dirs_to_choices(dirs)

  window:perform_action(
    wezterm.action.InputSelector({
      title = "🔭 Sessionizing...",
      fuzzy = true,
      fuzzy_description = "> ",
      choices = format_choices(choices),
      action = wezterm.action_callback(function(_, _, id)
        if not id then
          return -- cancelled with escape
        end

        switch_to_id(window, pane, id)
      end),
    }),
    pane
  )
end

---@param window Window
---@param pane Pane
M.switch_to_last = function(window, pane)
  local id = wezterm.GLOBAL.sessionizer_last_id
  if not id then
    wezterm.log_warn("switch_to_last: last ID not found")
    return
  end

  switch_to_id(window, pane, id)
end

return M
