---@type Wezterm
local wezterm = require("wezterm")
local M = {}

---@alias InputSelectorItem {id: string, label: string}

---@param path string
---@return string
local home_as_tilde = function(path)
  local result, _ = string.gsub(path, "^" .. wezterm.home_dir, "~")
  return result
end

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
    table.insert(choices, { id = dir, label = home_as_tilde(dir) })
  end

  table.sort(choices, function(a, b)
    return a.label < b.label
  end)

  table.insert(choices, 1, { id = wezterm.home_dir, label = "default" })

  return choices
end

local switch_to_id = function(window, pane, id)
  local name = home_as_tilde(id)
  if name == "~" then
    name = "default"
  end

  window:perform_action(
    wezterm.action.SwitchToWorkspace({
      -- NOTE: I don't use label purposefully, so I can use wezterm.format for the InputSelector
      name = name,
      spawn = { cwd = id },
    }),
    pane
  )
end

---@param window Window
---@param pane Pane
---@param choices InputSelectorItem[]
local sessionize = function(window, pane, choices)
  window:perform_action(
    wezterm.action.InputSelector({
      title = "🔭 Sessionizing...",
      fuzzy = true,
      fuzzy_description = "> ",
      choices = choices,
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

---@param subdirs_of string[] Those directories and their direct subdirectories will be available for selection.
M.create_action = function(subdirs_of)
  return wezterm.action_callback(function(window, pane)
    local dirs = list_subdirs(subdirs_of)
    local choices = dirs_to_choices(dirs)
    sessionize(window, pane, choices)
  end)
end

return M
