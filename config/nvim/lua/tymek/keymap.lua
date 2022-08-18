local M = {}

local function nnoremap(lhs, rhs, opts)
  vim.keymap.set("n", lhs, rhs, opts)
end

M.nnoremap = nnoremap

return M
