-- Mappings overview
--   g + h/j/k/l           - splits
--   Ctrl + n/p            - tabs
--   Ctrl + h/j/k/l        - quickfix list
--   g + <any>             - LSP stuff
--   <Leader> + f + <any>  - Telescope
--   <Leader> + h + <any>  - Harpoon
-- TODO: add git mappings (next/prev hunk, stage hunk)
-- TODO: add diagnostics jump mappings (vim.diagnostic.goto_*)

local M = {}

M.setup = function()
  -- Splits
  vim.keymap.set({ "n", "x" }, "gh", "<C-w>h")
  vim.keymap.set({ "n", "x" }, "gj", "<C-w>j")
  vim.keymap.set({ "n", "x" }, "gk", "<C-w>k")
  vim.keymap.set({ "n", "x" }, "gl", "<C-w>l")

  -- Screen
  vim.keymap.set({ "n", "x" }, "<C-u>", "<C-u>zz") -- Half a screen up with center on cursor
  vim.keymap.set({ "n", "x" }, "<C-d>", "<C-d>zz") -- Half a screen down with center on cursor
  vim.keymap.set({ "n", "x" }, "<C-b>", "<NOP>")

  -- Search Results
  vim.keymap.set({ "n", "x" }, "n", "nzzzv") -- Next search result, center on cursor, and open folds
  vim.keymap.set({ "n", "x" }, "N", "Nzzzv") -- Previous search result, center on cursor, and open folds

  -- Quickfix list
  vim.keymap.set({ "n", "x" }, "<C-h>", function() -- Previous quickfix list with opening if non-empty
    vim.cmd.colder({ count = vim.api.nvim_eval("v:count1") })
    vim.cmd.cwindow()
  end)
  vim.keymap.set({ "n", "x" }, "<C-j>", function() -- Next quickfix entry with wrapping and opening if non-empty
    local ok, msg = pcall(vim.cmd.cnext, { count = vim.api.nvim_eval("v:count1") })
    if ok == false and msg == "Vim:E553: No more items" then
      vim.cmd.cfirst()
    end
    vim.cmd.cwindow()
  end)
  vim.keymap.set({ "n", "x" }, "<C-k>", function() -- Previous quickfix entry with wrapping and opening if non-empty
    local ok, msg = pcall(vim.cmd.cprev, { count = vim.api.nvim_eval("v:count1") })
    if ok == false and msg == "Vim:E553: No more items" then
      vim.cmd.clast()
    end
    vim.cmd.cwindow()
  end)
  vim.keymap.set({ "n", "x" }, "<C-l>", function() -- Next quickfix list with opening if non-empty
    vim.cmd.cnewer({ count = vim.api.nvim_eval("v:count1") })
    vim.cmd.cwindow()
  end)

  -- Registers
  vim.keymap.set("x", "<Leader>p", '"_dP') -- Don't overwrite paste register
  vim.keymap.set({ "n", "x" }, "<Leader>y", '"+y') -- Use system register
  vim.keymap.set({ "n", "x" }, "<Leader>Y", '"+Y')

  -- Miscellaneous
  vim.keymap.set({ "n", "x" }, "<C-s>", "<Cmd>silent !tmux run-shell tmux-sessionizer<CR>")
  vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]])
end

return M
