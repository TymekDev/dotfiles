-- Splits
vim.keymap.set("n", "gh", "<C-w>h")
vim.keymap.set("n", "gj", "<C-w>j")
vim.keymap.set("n", "gk", "<C-w>k")
vim.keymap.set("n", "gl", "<C-w>l")

-- Tabs
vim.keymap.set("n", "[t", "<Cmd>tabprevious<CR>")
vim.keymap.set("n", "]t", "<Cmd>tabnext<CR>")

-- Quickfix list
vim.keymap.set("n", "<C-h>", function() -- Previous quickfix list with opening if non-empty
  vim.cmd.colder({ count = vim.api.nvim_eval("v:count1") })
  vim.cmd.cwindow()
end)
vim.keymap.set("n", "<C-j>", function() -- Next quickfix entry with wrapping and opening if non-empty
  local ok, msg = pcall(vim.cmd.cnext, { count = vim.api.nvim_eval("v:count1") })
  if ok == false and msg == "Vim:E553: No more items" then
    vim.cmd.cfirst()
  end
  vim.cmd.cwindow()
end)
vim.keymap.set("n", "<C-k>", function() -- Previous quickfix entry with wrapping and opening if non-empty
  local ok, msg = pcall(vim.cmd.cprev, { count = vim.api.nvim_eval("v:count1") })
  if ok == false and msg == "Vim:E553: No more items" then
    vim.cmd.clast()
  end
  vim.cmd.cwindow()
end)
vim.keymap.set("n", "<C-l>", function() -- Next quickfix list with opening if non-empty
  vim.cmd.cnewer({ count = vim.api.nvim_eval("v:count1") })
  vim.cmd.cwindow()
end)

-- Registers
vim.keymap.set("v", "<Leader>p", '"_dP') -- Don't overwrite paste register
vim.keymap.set({ "n", "v" }, "<Leader>y", '"+y') -- Use system register
vim.keymap.set({ "n", "v" }, "<Leader>Y", '"+Y')

-- Apply the first spell suggestion
vim.keymap.set("n", "<Leader>z", "1z=")

-- Easier terminal normal mode
vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]])

-- Spell toggle
vim.keymap.set("n", "<Leader>S", function()
  local opts = { scope = "local" }
  vim.api.nvim_set_option_value("spell", not vim.api.nvim_get_option_value("spell", opts), opts)
end)

vim.api.nvim_create_autocmd("OptionSet", { -- set those mappings only in diff mode
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
