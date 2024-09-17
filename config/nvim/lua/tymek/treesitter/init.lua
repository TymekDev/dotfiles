---@alias tymek.TSMatchesSimple table<string, table>
---@alias tymek.TSMatches table<string, tymek.TSMatchesSimple>
local M = {}

---@param bufnr integer
---@param lang string
---@return TSNode
M.get_root = function(bufnr, lang)
  local parser = vim.treesitter.get_parser(bufnr, lang, {})
  local tree = parser:parse()[1]
  return tree:root()
end

---Returns a mapping of capture group matches.
---Outer keys consist of capture_name_outer capture group matches.
---Optionally, inner keys consist of capture_name_inner capture group matches.
---@overload fun(bufnr: integer, lang: string, query: string, capture_name_outer: string): tymek.TSMatchesSimple
---@overload fun(bufnr: integer, lang: string, query: string, capture_name_outer: string, capture_name_inner: string): tymek.TSMatches
M.get_matches = function(bufnr, lang, query, capture_name_outer, capture_name_inner)
  local ts_query = vim.treesitter.query.parse(lang, query)
  local outer
  local result = {}
  for id, node, _ in ts_query:iter_captures(M.get_root(bufnr, lang), bufnr) do
    local capture_name = ts_query.captures[id]
    if capture_name == capture_name_outer then
      outer = vim.treesitter.get_node_text(node, bufnr)
      if not result[outer] then
        result[outer] = {}
      end
    elseif capture_name == capture_name_inner then
      local inner = vim.treesitter.get_node_text(node, bufnr)
      result[outer][inner] = {}
    end
  end
  return result
end

---@param bufnr integer
---@param node TSNode
---@param hl_namespace integer
---@param hl_group string
M.highlight_node = function(bufnr, node, hl_namespace, hl_group)
  local start_row, start_col, end_row, end_col = vim.treesitter.get_node_range(node)
  vim.highlight.range(bufnr, hl_namespace, hl_group, { start_row, start_col }, { end_row, end_col })
end

---@param bufnr integer
---@param lang string
---@param query string
---@param hl_namespace integer
---@param hl_group string
---@param predicate? fun(capture_name: string, node: TSNode): boolean
M.highlight_nodes = function(bufnr, lang, query, hl_namespace, hl_group, predicate)
  predicate = predicate or function(_, _)
    return true
  end
  local ts_query = vim.treesitter.query.parse(lang, query)
  vim.api.nvim_buf_clear_namespace(bufnr, hl_namespace, 0, -1)
  for id, node, _ in ts_query:iter_captures(M.get_root(bufnr, lang), bufnr) do
    if predicate(ts_query.captures[id], node) then
      M.highlight_node(bufnr, node, hl_namespace, hl_group)
    end
  end
end

return M
