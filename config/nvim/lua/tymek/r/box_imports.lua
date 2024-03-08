local M = {}

local get_root = function(bufnr)
  local parser = vim.treesitter.get_parser(bufnr, "r", {})
  local tree = parser:parse()[1]
  return tree:root()
end

local query_namespaced_calls = [[
  (namespace_get
    namespace: (identifier) @namespace
    function: (identifier) @function)
]]

local query_box_imports = [[
  (call
    function: (namespace_get
      namespace: (identifier) @namespace (#eq? @namespace "box")
      function: (identifier) @function (#eq? @function "use"))
    arguments: (arguments
      (subset
        (identifier) @box.use.namespace
        (arguments
          (identifier) @box.use.function))))
]]

local get_map = function(bufnr, query, capture_name_key, capture_name_value)
  local ts_query = vim.treesitter.query.parse("r", query)
  local result = {}
  local ns
  for id, node, _ in ts_query:iter_captures(get_root(bufnr), bufnr) do
    local capture_name = ts_query.captures[id]
    if capture_name == capture_name_key then
      ns = vim.treesitter.get_node_text(node, bufnr)
      if not result[ns] then
        result[ns] = {}
      end
    elseif capture_name == capture_name_value then
      local func = vim.treesitter.get_node_text(node, bufnr)
      if not result[ns][func] then
        result[ns][func] = 0
      end
    end
  end
  return result
end

local get_namespaced_calls = function(bufnr)
  return get_map(bufnr, query_namespaced_calls, "namespace", "function")
end

local get_box_imports = function(bufnr)
  return get_map(bufnr, query_box_imports, "box.use.namespace", "box.use.function")
end

local tbl_diff = function(tbl_a, tbl_b)
  local result = {}
  for ns, funcs in pairs(tbl_a) do
    for func, _ in pairs(funcs) do
      if vim.tbl_get(tbl_b, ns, func) == nil then
        if not result[ns] then
          result[ns] = {}
        end
        result[ns][func] = 0
      end
    end
  end
  return result
end

local drop_box_use = function(tbl)
  if tbl["box"] and tbl["box"]["use"] then
    tbl["box"]["use"] = nil
    if vim.tbl_count(tbl["box"]) == 0 then
      tbl["box"] = nil
    end
  end
  return tbl
end

local format_diff = function(diff)
  local result = {}
  for ns, funcs in pairs(diff) do
    local line = ns .. "["
    for func, _ in pairs(funcs) do
      line = line .. func .. ", "
    end
    line = string.gsub(line, ", $", "") .. "],"
    table.insert(result, line)
  end
  return result
end

M.put_missing = function(bufnr)
  local bufnr = bufnr or 0
  local diff = tbl_diff(get_namespaced_calls(bufnr), get_box_imports(bufnr))
  drop_box_use(diff)
  vim.api.nvim_put(format_diff(diff), "l", true, false)
end

return M
