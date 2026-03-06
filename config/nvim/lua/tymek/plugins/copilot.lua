---@module "lazy"
---@type LazySpec
return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  event = "InsertEnter",
  ---@module "copilot"
  ---@type CopilotConfig
  ---@diagnostic disable-next-line missing-fields
  opts = {
    should_attach = function(_, bufname)
      if string.match(bufname, "env") then
        return false
      end
      return true
    end,
    ---@diagnostic disable-next-line missing-fields
    panel = {
      enabled = false,
    },
    ---@diagnostic disable-next-line missing-fields
    suggestion = {
      enabled = true,
      auto_trigger = true,
      ---@diagnostic disable-next-line missing-fields
      keymap = {
        accept = "<M-j>",
        accept_word = "<M-k>",
        accept_line = "<M-l>",
      },
    },
  },
}
