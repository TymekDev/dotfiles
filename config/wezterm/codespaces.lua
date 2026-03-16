-- FEAT: mapping for serve-remote-open
-- TODO: mapping for local port forwarding

---@type Wezterm
local wezterm = require("wezterm")

local M = {}

local DOMAIN_NAME_PREFIX = "Codespace:"

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

---@param config Config
M.setup = function(config)
  config.exec_domains = config.exec_domains or {}
  for host, ssh_config in pairs(wezterm.enumerate_ssh_hosts()) do
    local is_codespace = string.find(ssh_config.identityfile, "codespaces%.auto") ~= nil

    if is_codespace then
      table.insert(
        config.exec_domains,
        wezterm.exec_domain(DOMAIN_NAME_PREFIX .. host, function(cmd)
          local args = {
            "ssh",
            "-o",
            "ControlMaster=auto",
            "-o",
            "ControlPersist=600",
            "-o",
            "ControlPath=~/.ssh/sockets/%r@%h:%p",
            "-R",
            "8765:localhost:8765",
            host,
          }

          for _, arg in ipairs(cmd.args or {}) do
            table.insert(args, arg)
          end

          cmd.args = args

          return cmd
        end)
      )
    end
  end
end

return M
