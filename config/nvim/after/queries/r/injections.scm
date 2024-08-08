; extends

(call
  function: [
    (extract_operator
      "$"
      rhs: (identifier) @function)
    (identifier) @function
  ]
  arguments: (arguments
    argument: (argument
      value: (string
        content: (string_content) @injection.content)))
  (#any-of? @function "run_js" "JS")
  (#set! injection.language "javascript"))

(call
  function: [
    (identifier) @function
    (namespace_operator
      rhs: (identifier) @function)
  ]
  arguments: (arguments
    argument: (argument
      value: (string
        content: (string_content) @injection.content)))
  (#eq? @function "glue_sql")
  (#set! injection.language "sql"))
