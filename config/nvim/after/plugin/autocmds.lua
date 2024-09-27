vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({
      higroup = "IncSearch",
      timeout = 50,
    })
  end,
})

vim.api.nvim_create_autocmd("FocusGained", {
  callback = require("tymek.theme").update,
})

vim.api.nvim_create_autocmd("OptionSet", {
  pattern = "diff",
  callback = function()
    vim.keymap.set("v", "do", ":diffget<CR>", {
      buffer = 0,
      desc = "Diff obtain the selected range",
    })
    vim.keymap.set("v", "dp", ":diffput<CR>", {
      buffer = 0,
      desc = "Diff put the selected range",
    })
  end,
})
