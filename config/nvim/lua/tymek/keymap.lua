local M = {}

local function nnoremap(lhs, rhs, opts)
  if opts ~= nil and opts.cmd then
    _rhs = function() vim.cmd(rhs) end
    opts.cmd = nil
  end
  vim.keymap.set("n", lhs, _rhs or rhs, opts)
end

M.nnoremap = nnoremap

return M
