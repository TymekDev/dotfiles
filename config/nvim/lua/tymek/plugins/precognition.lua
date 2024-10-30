---@module "lazy"
---@type LazySpec
return {
  "tris203/precognition.nvim",
  event = "VeryLazy",
  keys = {
    { "<Leader>P", "<Cmd>Precognition toggle<CR>", desc = "Toggle hints (via precognition.nvim)" },
  },
  ---@module "precognition"
  ---@type Precognition.PartialConfig
  opts = {
    showBlankVirtLine = false,

    gutterHints = { ---@diagnostic disable-line: missing-fields
      gg = { prio = 0 }, ---@diagnostic disable-line: missing-fields
      G = { prio = 0 }, ---@diagnostic disable-line: missing-fields
    },
  },
}
