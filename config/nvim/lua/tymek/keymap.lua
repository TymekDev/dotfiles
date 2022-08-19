local M = {}

local function nnoremap(lhs, rhs, opts)
  _rhs = rhs
  if opts ~= nil and opts.cmd == true then
    _rhs = function() vim.cmd(rhs) end
    opts.cmd = nil
  end
  vim.keymap.set("n", lhs, _rhs, opts)
end

M.nnoremap = nnoremap

return M
