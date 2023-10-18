; extends
(call
  function: (identifier) @function (#eq? @function "JS")

  (arguments
    (string) @injection.content
    (#offset! @injection.content 0 1 0 -1)
    (#set! injection.language "javascript")
  )
)
