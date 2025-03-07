; extends

(element
  (start_tag
    (tag_name) @tag.name
    (#eq? @tag.name "Code")
    (attribute
      (attribute_name) @attr.name
      (#eq? @attr.name "lang")
      (quoted_attribute_value
        (attribute_value) @injection.language)))
  ; FIXME: this includes also the closing tag, but it shouldn't
  _ @injection.content
  (#set! injection.include-children)
  (#set! injection.combined))
