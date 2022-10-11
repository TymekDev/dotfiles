local M = {}

local function keymap(mode)
  return function(lhs, rhs, opts)
    local _rhs = rhs
    if type(rhs) == "table" then
      _rhs = function()
        if rhs.count == true then
          rhs.count = vim.api.nvim_eval("v:count1")
        end
        vim.api.nvim_cmd(rhs, {})
      end
    end
    vim.keymap.set(mode, lhs, _rhs, opts)
  end
end

M.nnoremap = keymap("n")
M.xnoremap = keymap("x")

return M
