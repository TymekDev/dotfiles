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

M.highlight_roxygen2_comments = function(bufnr)
  local ns = vim.api.nvim_create_namespace("roxygen2_comments")
  vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)

  local ts_query = vim.treesitter.query.parse("r", queries.roxygen2_comments)
  for id, node, metadata in ts_query:iter_captures(ts.get_root(bufnr, "r"), bufnr) do
    if ts_query.captures[id] ~= "comment.roxygen2" then
      goto next
    end

    local start_row, _, end_row, _ = vim.treesitter.get_node_range(node)
    local position = 3 -- skip initial "#' "

    ---@overload fun(hl_groups: string[], length: integer)
    local highlight_length = function(hl_groups, length)
      for hl_group in vim.iter(hl_groups) do
        vim.highlight.range(bufnr, ns, hl_group, { start_row, position }, { end_row, position + length })
      end
      position = position + length + 1
    end

    local tag_name = metadata[id].text
    highlight_length({ "@keyword" }, #tag_name)

    if tag_name == "@import" or tag_name == "@importFrom" then
      local line = vim.api.nvim_buf_get_text(bufnr, start_row, position, end_row, -1, {})[1]
      if string.match(line, "^ ") ~= nil or string.match(line, "  ") ~= nil then
        highlight_length({ "SpellBad" }, #line)
        goto next
      end

      local words = vim.gsplit(line, " ", { trimempty = true })
      highlight_length({ "Bold", "@module.r" }, #words()) -- Package name
      for word in words do
        highlight_length({ "@function.r" }, #word)
      end
    end

    if tag_name == "@param" then
      local line = vim.api.nvim_buf_get_text(bufnr, start_row, position, end_row, -1, {})[1]
      if string.match(line, "^ ") ~= nil or string.match(line, "^%S*, ") ~= nil or string.match(line, "  ") ~= nil then
        highlight_length({ "SpellBad" }, #line)
        goto next
      end

      local params = string.match(line, "^%S+")
      for param in vim.gsplit(params, ",") do
        highlight_length({ "Bold", "@variable.parameter.r" }, #param)
      end
    end

    ::next::
  end
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
