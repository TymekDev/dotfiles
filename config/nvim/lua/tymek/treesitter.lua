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
  vim.highlight.range(
    bufnr,
    hl_namespace,
    hl_group,
    { start_row, start_col },
    { end_row, end_col }
  )
end

M.highlight_nodes = function(bufnr, lang, query, hl_namespace, hl_group)
  local ts_query = vim.treesitter.query.parse(lang, query)
  vim.api.nvim_buf_clear_namespace(bufnr, hl_namespace, 0, -1)
  for _, node, _ in ts_query:iter_captures(M.get_root_factory(lang)(bufnr), bufnr) do
    M.highlight_node(bufnr, node, hl_namespace, hl_group)
  end
end

M.setup_highlight = function(bufnr, callback)
  bufnr = bufnr or 0
  vim.api.nvim_create_autocmd({ "BufWinEnter", "TextChanged", "TextChangedI" }, {
    buffer = bufnr,
    callback = function()
      callback()
    end,
  })
end

return M
