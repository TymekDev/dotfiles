vim.api.nvim_create_autocmd("QuickfixCmdPost", {
  callback = function()
    vim.cmd("cwindow")
  end,
})
