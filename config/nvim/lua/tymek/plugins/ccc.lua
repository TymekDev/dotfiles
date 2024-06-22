return {
  "uga-rosa/ccc.nvim",
  keys = {
    { "<Leader>cc", "<Cmd>CccConvert<CR>", desc = "Convert the color format (via ccc.nvim)" },
    { "<Leader>cp", "<Cmd>CccPick<CR>", desc = "Pick a color (via ccc.nvim)" },
  },
  config = function()
    local ccc = require("ccc")
    ccc.setup({
      alpha_show = false,
      inputs = { ccc.input.hsl },
      outputs = { ccc.output.css_hsl },
    })
  end,
}
