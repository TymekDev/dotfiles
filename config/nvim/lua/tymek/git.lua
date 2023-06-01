local M = {}

local function system_call(tbl)
  return string.gsub(vim.fn.system(tbl), "\n$", "")
end

local function try_refs(refs)
  local result
  for _, ref in ipairs(refs) do
    result = system_call({ "git", "rev-parse", "--symbolic-full-name", ref .. "@{upstream}" })
    if string.find(result, "fatal", 1, true) == nil then
      break
    end
  end
  return result
end

-- TODO: check for SSH vs HTTPS
-- TODO: check for different remote vendors
local function current_file_url(refs)
  local ref = try_refs(refs)
  ref = string.gsub(ref, "^refs/remotes/", "")

  local remote = string.match(ref, "^[^/]*")
  local remote_url = system_call({ "git", "remote", "get-url", remote })


  remote_url = string.gsub(remote_url, "^ssh://", "")
  remote_url = string.gsub(remote_url, "/$", "")
  local repo = string.gsub(remote_url, "^git@github%.com.", "")
  local revision = system_call({ "git", "rev-parse", "@" })
  local file = vim.fn.expand("%")
  local line = vim.api.nvim_win_get_cursor(0)[1]

  return string.format("https://github.com/%s/blob/%s/%s#L%d", repo, revision, file, line)
end

M.open = function(refs)
  if type(refs) ~= "table" then
    refs = { "", "main", "master" }
  end
  vim.fn.system({ "open", current_file_url(refs) })
end

return M
