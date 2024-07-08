; extends
(call
  function: [
    (extract_operator
      "$"
      rhs: (identifier) @function)
    (identifier) @function2
  ]
  arguments: (arguments
    argument: (argument
      value: (string
        content: (string_content) @injection.content)))
  (#any-of? @function "run_js" "JS")
  (#any-of? @function2 "run_js" "JS")
  (#set! injection.language "javascript")
)

(call
  function: (identifier) @function (#eq? @function "glue_sql")
  arguments: (arguments
    argument: (argument
      value: (string
        content: (string_content) @injection.content)))
  (#set! injection.language "sql")
)
