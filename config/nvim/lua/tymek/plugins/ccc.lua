-- FIXME: highlighter breaks on converting to hex / removing a colored text (including conversion)
return {
  "uga-rosa/ccc.nvim",
  event = "VeryLazy",
  keys = {
    { "<Leader>cc", "<Cmd>CccConvert<CR>", desc = "Convert the color format (via ccc.nvim)" },
    { "<Leader>cp", "<Cmd>CccPick<CR>", desc = "Pick a color (via ccc.nvim)" },
  },
  config = function()
    local ccc = require("ccc")
    ccc.setup({
      highlighter = { auto_enable = true },
      alpha_show = false,
      inputs = { ccc.input.hsl },
      outputs = { ccc.output.css_hsl },
    })
  end,
}
