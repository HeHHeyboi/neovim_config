;; extends
(type
  (identifier) @type
  (#set! priority 130))
(struct_declaration
  (identifier) @type
  "::"
(#set! priority 130))

(enum_declaration
  (identifier) @type
  "::"
(#set! priority 130))

(union_declaration
  (identifier) @type
  "::"
(#set! priority 130))

(bit_field_declaration
  (identifier) @type
  "::"
(#set! priority 130))

(const_declaration
  (identifier) @type
  "::"
(#set! priority 130)
  [
    (array_type)
    (distinct_type)
    (bit_set_type)
    (pointer_type)
  ])
(struct
  .
  (identifier) @type
  (#set! priority 130))

(field_type
  .
  (identifier) @module
  "."
  (identifier) @type
  (#set! priority 130))

(bit_set_type
  (identifier) @type
  ";"
  (#set! priority 130))

(procedure_type
  (parameters
    (parameter
      (identifier) @type
	  (#set! priority 130))))

(polymorphic_parameters
  (identifier) @type
  (#set! priority 130))

(using_statement
  (identifier) @module
  (#set! priority 130))

((identifier) @type
  (#lua-match? @type "^[_A-Z][_a-zA-Z0-9]*$")
  (#not-has-parent? @type parameter procedure_declaration call_expression)
  (#set! priority 130))
("..." @type.builtin (#set! priority 130))
((identifier) @constant
  (#lua-match? @constant "^_*[A-Z][A-Z0-9_]*$")
  (#not-has-parent? @constant type parameter)
  (#set! priority 130))
