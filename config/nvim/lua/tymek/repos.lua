local M = {}

M.setup = function(config)
  if config == nil or vim.tbl_count(config) == 0 then
    return
  end

  local root = vim.fn.system({ "git", "rev-parse", "--show-toplevel" })
  if root:find("fatal: not a git repository") ~= nil then
    return
  end

  vim.fn.jobstart({ "git", "remote", "get-url", "origin" }, {
    on_stdout = function(_, data)
      if data[1] ~= "" and config[data[1]] ~= nil then
        config[data[1]](root:gsub("\n", ""))
      end
    end,
    stdout_buffered = true,
  })
end

return M
