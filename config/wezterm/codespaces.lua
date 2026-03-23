-- FEAT: mapping for serve-remote-open

---@type Wezterm
local wezterm = require("wezterm")

local M = {}

local DOMAIN_NAME_PREFIX = "Codespace:"

---@param ... string|string[]
---@return string[]
local ssh_command = function(...)
  local result = {
    "ssh",
    "-o",
    "ControlMaster=auto",
    "-o",
    "ControlPersist=600",
    "-o",
    "ControlPath=~/.ssh/sockets/%r@%h:%p",
  }

  for _, arg in ipairs({ ... }) do
    if type(arg) == "table" then
      for _, sub_arg in ipairs(arg) do
        table.insert(result, sub_arg)
      end
    else
      table.insert(result, arg)
    end
  end

  return result
end

---@param name string
M.is_codespace_domain = function(name)
  return name:find("^" .. DOMAIN_NAME_PREFIX) ~= nil
end

---@param window Window
---@return string[]
M.list_domains = function(window)
  local result = {}
  for _, exec_domain in ipairs(window:effective_config().exec_domains) do
    ---@type string
    local name = exec_domain.name
    if M.is_codespace_domain(name) then
      table.insert(result, name)
    end
  end
  return result
end

---@param domain_name string
---@param port integer
M.local_forward_port = function(domain_name, port)
  if not M.is_codespace_domain(domain_name) then
    wezterm.log_warn("local_forward_port: not a codespace domain:", domain_name)
    return
  end

  local host, _ = domain_name:gsub("^" .. DOMAIN_NAME_PREFIX, "")
  local port_map = string.format("%d:localhost:%d", port, port)
  local args = ssh_command({
    "-O",
    "forward",
    "-L",
    port_map,
    host,
  })

  wezterm.background_child_process(args)
  wezterm.log_info("Started local forward -L", port_map, "to", host)
end

---@param config Config
M.setup = function(config)
  config.exec_domains = config.exec_domains or {}
  for host, ssh_config in pairs(wezterm.enumerate_ssh_hosts()) do
    local is_codespace = string.find(ssh_config.identityfile, "codespaces%.auto") ~= nil

    if is_codespace then
      table.insert(
        config.exec_domains,
        wezterm.exec_domain(DOMAIN_NAME_PREFIX .. host, function(cmd)
          local dir = cmd.cwd
          if not dir or M.is_codespace_domain(dir) then -- sessionizer passes the workspace name as cwd
            dir = "/workspaces/" .. host
          end

          local args = ""
          if cmd.args and #cmd.args > 0 then
            args = " -c " .. wezterm.shell_quote_arg(wezterm.shell_join_args(cmd.args))
          end

          cmd.args = ssh_command(
            "-R",
            "8765:localhost:8765",
            host,
            "-o",
            "RequestTTY=yes",
            "cd " .. dir .. ' && exec "$SHELL"' .. args
          )

          return cmd
        end)
      )
    end
  end
end

---@param domain_name string
---@return table?
M.status = function(domain_name)
  if not M.is_codespace_domain(domain_name) then
    wezterm.log_warn("status: not a codespace domain:", domain_name)
    return
  end

  local host, _ = domain_name:gsub("^" .. DOMAIN_NAME_PREFIX, "")

  local ok, _, stderr = wezterm.run_child_process(ssh_command("-O", "check", host))
  if not ok then
    return
  end

  local pid = stderr:match("Master running %(pid=(%d+)%)")

  local _, stdout, _ = wezterm.run_child_process({
    "lsof",
    "-p",
    pid,
    "-a",
    "-i",
    "4",
    "-P",
  })

  local ports = {}
  for _, line in ipairs(wezterm.split_by_newlines(stdout)) do
    local port = line:match("localhost:(%d+) %(LISTEN%)")
    if port ~= nil then
      table.insert(ports, port)
    end
  end

  return {
    pid = pid,
    ports = ports,
  }
end

return M
