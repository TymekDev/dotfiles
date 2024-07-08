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
  require("tymek.treesitter").highlight_nodes(
    bufnr,
    "r",
    require("tymek.r.box_imports").query_box_imports,
    vim.api.nvim_create_namespace("box_unused_imports"),
    "@r.box.unused.import",
    function(capture_name, node)
      if capture_name ~= "box.use.function" then
        return false
      end
      local func = vim.treesitter.get_node_text(node, bufnr)
      return not calls[func]
    end
  )
end

return M
