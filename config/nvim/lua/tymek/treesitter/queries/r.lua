local M = {}

M.reactives_declarations = [[
(binary_operator
  lhs: (identifier) @target
  "<-"
  rhs: [
    (call
      function: (identifier) @fName)
    (binary_operator
      lhs: (call
        function: (identifier) @fName)
      "|>")
  ]
  (#any-of? @fName "reactive" "eventReactive"))
]]

---@overload fun(): string
---@overload fun(names: string[]): string
M.calls = function(names)
  if names == nil then
    return [[
(call
  function: (identifier) @target)
]]
  end
  return string.format(
    [[
(call
  function: (identifier) @target
  (#any-of? @target %s))
]],
    table.concat( -- wrap with double quotes and concatenate
      vim.tbl_map(function(x)
        return string.format('"%s"', x)
      end, names),
      " "
    )
  )
end

return M
