local wider_active_buf = vim.api.nvim_get_option_value("winwidth", {})
  > vim.api.nvim_get_option_info2("winwidth", {}).default
vim.api.nvim_create_user_command("WiderActiveBufToggle", function()
  if wider_active_buf then
    vim.opt.winwidth = vim.api.nvim_get_option_info2("winwidth", {}).default
    vim.cmd("normal =")
  else
    vim.opt.winwidth = 87
  end
  wider_active_buf = not wider_active_buf
end, {})

vim.api.nvim_create_user_command("MarkdownTableSeparator", "s/[^|]/-/g", {})
