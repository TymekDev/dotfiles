local M = {}

local function keymap(mode)
  return function(lhs, rhs, opts)
    _rhs = rhs
    if opts ~= nil and opts.cmd == true then
      if opts.count == true then
        _rhs = function() vim.cmd(vim.api.nvim_eval("v:count1") .. rhs) end
        opts.count = nil
      else
        _rhs = function() vim.cmd(rhs) end
      end
      opts.cmd = nil
    end
    vim.keymap.set(mode, lhs, _rhs, opts)
  end
end

M.nnoremap = keymap("n")
M.xnoremap = keymap("x")

return M
