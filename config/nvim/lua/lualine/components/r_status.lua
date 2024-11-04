---@class (exact) RStatus
---@field super RStatus
---@field init fun(self: RStatus, options: table)
---@field create_hl fun(self: RStatus, color: vim.api.keyset.highlight, name: string)
---@field format_hl fun(self: RStatus, name: string)
---@field update_status fun(self: RStatus): string?
---
---@field highlights table<integer, string>
local M = require("lualine.component"):extend()

---@type { text: string, highlight: vim.api.keyset.highlight }[]
local r_status = {
  { text = "-", highlight = { fg = "#aaaaaa" } }, -- 1: ftplugin/* sourced, but nclientserver not started yet.
  { text = "S", highlight = { fg = "#757755" } }, -- 2: nclientserver started, but not ready yet.
  { text = "S", highlight = { fg = "#117711" } }, -- 3: nclientserver is ready.
  { text = "S", highlight = { fg = "#ff8833" } }, -- 4: nclientserver started the TCP server
  { text = "S", highlight = { fg = "#3388ff" } }, -- 5: TCP server is ready
  { text = "R", highlight = { fg = "#ff8833" } }, -- 6: R started, but nvimcom was not loaded yet.
  { text = "R", highlight = { fg = "#3388ff" } }, -- 7: nvimcom is loaded.
}

function M:init(options)
  M.super.init(self, options)
  self.highlights = vim
    .iter(r_status)
    :enumerate()
    :map(function(i, t)
      return self:create_hl(t.highlight, i)
    end)
    :totable()
end

function M:update_status()
  local status = vim.g.R_Nvim_status
  if status == nil or status == 0 then
    return nil
  end

  return self:format_hl(self.highlights[status]) .. r_status[status].text
end

return M
