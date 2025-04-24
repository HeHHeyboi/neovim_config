;; extends
((identifier) @constant
  (#lua-match? @constant "^_*[A-Z][A-Z0-9_]*$")
  (#not-has-parent? @constant type parameter)
  (#set! priority 130))
