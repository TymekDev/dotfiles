local M = {}

local get_root = require("tymek.treesitter").get_root_factory("r")

local get_reactives_declaration = function(bufnr)
  local query = [[
  (left_assignment
    name: (identifier) @reactive.declaration
    value: [
      (call
        function: (identifier) @fName)
      (pipe
        left: (call
                function: (identifier) @fName))
    ]
    (#any-of? @fName "reactive" "eventReactive"))
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

M.highlight_calls = function(bufnr)
  bufnr = bufnr or 0
  local reactives_names = get_reactives_declaration(bufnr)
  local query = string.format(
    [[
  (call
    function: (identifier) @fName
    (#any-of? @fName %s))
  ]],
    format_names(reactives_names)
  )
  require("tymek.treesitter").highlight_nodes(
    bufnr,
    "r",
    query,
    vim.api.nvim_create_namespace("reactive_calls"),
    "@r.reactive.call"
  )
end

return M
