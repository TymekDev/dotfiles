---@alias r_status.Color fun(): { fg: string }

---@class (exact) r_status.Component
---@field super r_status.Component
---@field init fun(self: r_status.Component, options: table)
---@field create_hl fun(self: r_status.Component, color: r_status.Color, name: string)
---@field format_hl fun(self: r_status.Component, name: string)
---@field update_status fun(self: r_status.Component): string?
---
---@field highlights table<integer, string>
local M = require("lualine.component"):extend()

---@param hl_name string
---@return r_status.Color
local function color(hl_name)
  return function()
    return { fg = require("lualine.utils.utils").extract_highlight_colors(hl_name, "fg") }
  end
end

---@class (exact) r_status.Meta
---@field msg string
---@field color r_status.Color

---1: ftplugin/* sourced, but nclientserver not started yet.
---2: nclientserver started, but not ready yet.
---3: nclientserver is ready.
---4: nclientserver started the TCP server
---5: TCP server is ready
---6: R started, but nvimcom was not loaded yet.
---7: nvimcom is loaded.
---@type r_status.Meta[]
local r_status = {
  [1] = { msg = "Booting", color = color("DiagnosticWarn") },
  [3] = { msg = "Ready", color = color("DiagnosticHint") },
  [6] = { msg = "Starting", color = color("DiagnosticWarn") },
  [7] = { msg = "Active", color = color("DiagnosticInfo") },
}

function M:init(options)
  M.super.init(self, options)

  self.highlights = {}
  for status, meta in pairs(r_status) do
    self.highlights[status] = self:create_hl(meta.color, string.format(status))
  end
end

function M:update_status()
  local status = vim.g.R_Nvim_status
  if status == nil or r_status[status] == nil then
    return nil
  end

  return self:format_hl(self.highlights[status]) .. "󰟔 " .. r_status[status].msg
end

return M
