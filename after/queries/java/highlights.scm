;; extends

((type_identifier) @type (#set! priority 130))

(field_declaration
  declarator: (variable_declarator
    name: (identifier) @variable.member) (#set! priority 130))

(field_access
  field: (identifier) @variable.member(#set! priority 130))
([
  "record"
  "class"
  "enum"
  "interface"
] @keyword.type (#set! priority 130))

([
  "abstract"
  "final"
  "native"
  "non-sealed"
  "open"
  "private"
  "protected"
  "public"
  "sealed"
  "static"
  "strictfp"
  "transitive"
] @keyword.modifier (#set! priority 130))

