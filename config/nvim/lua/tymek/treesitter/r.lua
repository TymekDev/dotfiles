local queries = require("tymek.treesitter.queries.r")
local ts = require("tymek.treesitter")

local M = {}

---@param tbl_a tymek.TSMatches
---@param tbl_b tymek.TSMatches
---@return tymek.TSMatches # A mapping of keys found in tbl_a that are missing from tbl_b.
local tbl_diff = function(tbl_a, tbl_b)
  local result = {}
  for ns, funcs in pairs(tbl_a) do
    for func, _ in pairs(funcs) do
      if vim.tbl_get(tbl_b, ns, func) == nil then
        if not result[ns] then
          result[ns] = {}
        end
        result[ns][func] = {}
      end
    end
  end
  return result
end

---Format a tymek.TSMatches table to an equivalent a box::use import.
---For example:
---```lua
---  local diff = {
---    ns = {
---      func1 = {},
---      func2 = {},
---    },
---    ns2 = {
---      func3 = {},
---    },
---  }
---  vim.print(format_diff(diff))
---  -- {
---  --   "ns[func1, func2]",
---  --   "ns2[func3]",
---  -- }
---```
---@param tbl tymek.TSMatches
---@return string[]
local format_box_imports = function(tbl)
  local result = {}
  for ns, funcs in pairs(tbl) do
    local line = ns .. "["
    for func, _ in pairs(funcs) do
      line = line .. func .. ", "
    end
    line = string.gsub(line, ", $", "") .. "],"
    table.insert(result, line)
  end
  return result
end

---@param bufnr? integer
M.put_missing_box_imports = function(bufnr)
  bufnr = bufnr or 0
  local imports = ts.get_matches(bufnr, "r", queries.box_imports, "box.use.namespace", "box.use.function")
  local calls = ts.get_matches(bufnr, "r", queries.calls_namespaced, "namespace", "function")
  local missing_imports = tbl_diff(calls, imports)
  if missing_imports["box"] then
    missing_imports["box"]["use"] = nil
    if vim.tbl_count(missing_imports["box"]) == 0 then
      missing_imports["box"] = nil
    end
  end
  vim.api.nvim_put(format_box_imports(missing_imports), "l", true, false)
end

return M
