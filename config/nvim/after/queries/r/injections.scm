; extends
(call
  function: [
    (dollar (identifier) @function)
    (identifier) @function
  ]

  (#any-of? @function "run_js" "JS")

  (arguments
    (string) @injection.content
    (#offset! @injection.content 0 1 0 -1)
    (#set! injection.language "javascript")
  )
)

(call
  function: (identifier) @function (#eq? @function "glue_sql")
  arguments: (arguments
    (string) @injection.content
    (#offset! @injection.content 0 1 0 -1)
    (#set! injection.language "sql")
  )
)
