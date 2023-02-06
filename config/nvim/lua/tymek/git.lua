local M = {}

local function system_call(tbl)
  return string.gsub(vim.fn.system(tbl), "\n$", "")
end

-- TODO: check for SSH vs HTTPS
-- TODO: check for different remote vendors
local function current_file_url()
  local ref = system_call({ "git", "rev-parse", "--symbolic-full-name", "@{upstream}" })
  ref = string.gsub(ref, "^refs/remotes/", "")

  local remote = string.match(ref, "^[^/]*")
  local remote_url = system_call({ "git", "remote", "get-url", remote })

  local repo = string.gsub(remote_url, "^[^:]*:", "") --
  local revision = system_call({ "git", "rev-parse", "@" })
  local file = vim.fn.expand("%")
  local line = vim.api.nvim_win_get_cursor(0)[1]

  return string.format("https://github.com/%s/blob/%s/%s#L%d", repo, revision, file, line)
end

M.open = function()
  vim.fn.system({ "open", current_file_url() })
end

return M
