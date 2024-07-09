local M = {}

local get_root = function(bufnr, lang)
  local parser = vim.treesitter.get_parser(bufnr, lang, {})
  local tree = parser:parse()[1]
  return tree:root()
end

M.get_root_factory = function(lang)
  return function(bufnr)
    get_root(bufnr, lang)
  end
end

---@param bufnr integer
---@param lang string
---@param query string
---@return table<string, true> # A map with @target capture matches as keys.
M.get_target_matches = function(bufnr, lang, query)
  local ts_query = vim.treesitter.query.parse(lang, query)
  local result = {}
  for id, node, _ in ts_query:iter_captures(get_root(bufnr, lang), bufnr) do
    if ts_query.captures[id] == "target" then
      result[vim.treesitter.get_node_text(node, bufnr)] = true
    end
  end
  return result
end

M.highlight_node = function(bufnr, node, hl_namespace, hl_group)
  local start_row, start_col, end_row, end_col = vim.treesitter.get_node_range(node)
  vim.highlight.range(bufnr, hl_namespace, hl_group, { start_row, start_col }, { end_row, end_col })
end

---@param predicate? fun(capture_name: string, node: TSNode): boolean
M.highlight_nodes = function(bufnr, lang, query, hl_namespace, hl_group, predicate)
  predicate = predicate or function(_, _)
    return true
  end
  local ts_query = vim.treesitter.query.parse(lang, query)
  vim.api.nvim_buf_clear_namespace(bufnr, hl_namespace, 0, -1)
  for id, node, _ in ts_query:iter_captures(get_root(bufnr, lang), bufnr) do
    if predicate(ts_query.captures[id], node) then
      M.highlight_node(bufnr, node, hl_namespace, hl_group)
    end
  end
end

return M
