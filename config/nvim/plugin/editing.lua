vim.pack.add({
  "https://github.com/kylechui/nvim-surround",
  "https://github.com/tpope/vim-abolish",
  "https://github.com/tpope/vim-rsi",
  "https://github.com/junegunn/vim-easy-align",
  "https://github.com/uga-rosa/ccc.nvim",
}, { confirm = false })

require("nvim-surround").setup({
  move_cursor = false,
})

local ccc = require("ccc")
ccc.setup({
  alpha_show = "hide",
  inputs = { ccc.input.hsl },
  outputs = { ccc.output.css_hsl },
})

vim.keymap.set({ "n", "v" }, "<Leader>a", "<Plug>(EasyAlign)")
vim.keymap.set("n", "<Leader>cc", "<Cmd>CccConvert<CR>", { desc = "Convert the color format (via ccc.nvim)" })
vim.keymap.set("n", "<Leader>cp", "<Cmd>CccPick<CR>", { desc = "Pick a color (via ccc.nvim)" })
