vim.api.nvim_create_autocmd("QuickfixCmdPost", {
  callback = function()
    vim.api.nvim_cmd({ cmd = "cwindow" }, {})
  end,
})

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
