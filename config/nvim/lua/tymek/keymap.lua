local M = {}

local function nnoremap(lhs, rhs, opts)
  opts = opts or { buffer = 0 }
  vim.keymap.set("n", lhs, rhs, opts)
end

M.nnoremap = nnoremap

return M
