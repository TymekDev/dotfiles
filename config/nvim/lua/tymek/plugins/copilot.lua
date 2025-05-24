---@module "lazy"
---@type LazySpec
return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  event = "InsertEnter",
  ---@module "copilot"
  ---@type CopilotConfig
  opts = {
    panel = {
      enabled = false,
    },
    suggestion = {
      keymap = {
        accept = "<M-j>",
      },
    },
  },
}
