local M = {}

local get_root = function(bufnr)
  local parser = vim.treesitter.get_parser(bufnr, "r", {})
  local tree = parser:parse()[1]
  return tree:root()
end

local get_reactives_declaration = function(bufnr)
  local query = [[
  (left_assignment
    name: (identifier) @reactive.declaration
    value: (
      call
      function: (identifier) @fName
      (#any-of? @fName "reactive" "eventReactive")))
  ]]
  local ts_query = vim.treesitter.query.parse("r", query)
  local result = {}
  for id, node, _ in ts_query:iter_captures(get_root(bufnr), bufnr) do
    if ts_query.captures[id] == "reactive.declaration" then
      result[vim.treesitter.get_node_text(node, bufnr)] = 1
    end
  end
  return vim.tbl_keys(result)
end

local quote = function(x)
  return string.format('"%s"', x)
end

local format_names = function(tbl)
  local tbl_quoted = vim.tbl_map(quote, tbl)
  return table.concat(tbl_quoted, " ")
end

local highlight_calls = function(bufnr)
  local reactives_names = get_reactives_declaration(bufnr)
  local query = string.format([[
  (call
    function: (identifier) @fName
    (#any-of? @fName %s))
  ]], format_names(reactives_names))
  local ts_query = vim.treesitter.query.parse("r", query)
  local ns = vim.api.nvim_create_namespace("reactive_calls")
  vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)
  for _, node, _ in ts_query:iter_captures(get_root(bufnr), bufnr) do
    local start_row, start_col, end_row, end_col = vim.treesitter.get_node_range(node)
    vim.highlight.range(
      bufnr,
      ns,
      "@r.reactive.call",
      { start_row, start_col },
      { end_row, end_col }
    )
  end
end

M.setup_highlight_calls = function(bufnr)
  bufnr = bufnr or 0
  vim.api.nvim_create_autocmd({ "BufWinEnter", "TextChanged", "TextChangedI" }, {
    buffer = bufnr,
    callback = function()
      highlight_calls(bufnr)
    end,
  })
end

return M
