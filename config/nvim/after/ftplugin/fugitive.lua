-- TODO: move to mappings?
vim.keymap.set({ "n", "x" }, "<Leader>gf", "<Cmd>Git fetch<CR>")
vim.keymap.set({ "n", "x" }, "<Leader>gl", "<Cmd>Git pull<CR>")
vim.keymap.set({ "n", "x" }, "<Leader>gp", "<Cmd>Git push<CR>")
vim.keymap.set({ "n", "x" }, "<Leader>gpf", function()
  local out = vim.fn.system({ "git", "push", "--force-with-lease" })
  if out ~= nil then
    vim.notify(out)
  end
end)
