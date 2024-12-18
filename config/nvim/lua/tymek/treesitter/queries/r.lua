local M = {}

M.box_imports = [[
(call
  function: (namespace_operator
    lhs: (identifier) @namespace
    (#eq? @namespace "box")
    rhs: (identifier) @function
    (#eq? @function "use"))
  arguments: (arguments
    argument: (argument
      (subset
        function: (identifier) @box.use.namespace
        arguments: (arguments
          argument: (argument
            (identifier) @box.use.function))))))
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
    vim
      .iter(names)
      :map(function(x)
        return '"' .. x .. '"'
      end)
      :join(" ")
  )
end

M.calls_namespaced = [[
(namespace_operator
  lhs: (identifier) @namespace
  rhs: (identifier) @function)
]]

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
    (call
      function: (extract_operator
        rhs: (identifier) @fName))
    (binary_operator
      lhs: (call
        function: (extract_operator
          rhs: (identifier) @fName))
      "|>")
  ]
  (#any-of? @fName "reactive" "eventReactive"))
]]

M.roxygen2_comments = [[
((comment) @comment.roxygen2
  (#lua-match? @comment.roxygen2 "^#' (@%a+).*$")
  (#gsub! @comment.roxygen2 "^#' (@%a+).*$" "%1"))
]]

return M
