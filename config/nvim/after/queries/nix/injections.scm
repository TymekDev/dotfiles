; extends

(binding
  attrpath: (attrpath
    (identifier)*
    (identifier) @attrs
    (identifier)* @last.attr
    (#any-eq? @attrs "fish"))
  expression: [
    ; fish.shellInit = ""
    ((indented_string_expression
      (string_fragment) @injection.content)
      (#set! injection.language "fish")
      (#any-of? @last.attr "shellInit" "interactiveShellInit"))
    ; fish = { shellInit = ""}
    (attrset_expression
      (binding_set
        (binding
          attrpath: (attrpath
            (identifier) @attr)
          expression: ((#any-of? @attr "shellInit" "interactiveShellInit")
          (indented_string_expression
            (string_fragment) @injection.content
            (#set! injection.language "fish"))))))
  ])
