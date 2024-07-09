local M = {}

M.get_root_factory = function(lang)
  return function(bufnr)
    local parser = vim.treesitter.get_parser(bufnr, lang, {})
    local tree = parser:parse()[1]
    return tree:root()
  end
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
  for id, node, _ in ts_query:iter_captures(M.get_root_factory(lang)(bufnr), bufnr) do
    if predicate(ts_query.captures[id], node) then
      M.highlight_node(bufnr, node, hl_namespace, hl_group)
    end
  end
end

return M
