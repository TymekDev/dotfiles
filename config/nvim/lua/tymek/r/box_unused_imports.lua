local M = {}

local get_root = require("tymek.treesitter").get_root_factory("r")

local query_calls = [[
(call
  function: (identifier) @fName)
]]

local get_calls = function(bufnr)
  local ts_query = vim.treesitter.query.parse("r", query_calls)
  local result = {}
  for id, node, _ in ts_query:iter_captures(get_root(bufnr), bufnr) do
    if ts_query.captures[id] == "fName" then
      result[vim.treesitter.get_node_text(node, bufnr)] = 0
    end
  end
  return result
end

-- NOTE: caveats:
--  - This works only for imports from packages (i.e. not from files).
--  - There might be false positives when importing non-function objects.
M.highlight_unused_imports = function(bufnr)
  bufnr = bufnr or 0
  local calls = get_calls(bufnr)
  local ts_query = vim.treesitter.query.parse("r", require("tymek.r.box_imports").query_box_imports)
  local ns = vim.api.nvim_create_namespace("box_unused_imports")
  for id, node, _ in ts_query:iter_captures(get_root(bufnr), bufnr) do
    if ts_query.captures[id] == "box.use.function" then
      local func = vim.treesitter.get_node_text(node, bufnr)
      if not calls[func] then
        require("tymek.treesitter").highlight_node(bufnr, node, ns, "@r.box.unused.import")
      end
    end
  end
end

return M
