---@module "lazy"
---@type LazySpec
return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  keys = {
    {
      mode = "i",
      "<M-j>",
      function()
        require("copilot.suggestion").accept()
      end,
    },
  },
  ---@module "copilot"
  ---@type CopilotConfig
  opts = {
    panel = {
      enabled = false,
    },
  },
}
