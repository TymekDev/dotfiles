vim.api.nvim_create_autocmd("QuickfixCmdPost", {
  callback = function()
    vim.cmd("cwindow")
  end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({
      higroup = "IncSearch",
      timeout = 50,
    })
  end,
})
