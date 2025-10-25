;; extends
("return" @keyword.return (#set! priority 130))

([
  "import"
  "package"
] @keyword.import (#set! priority 130))

((escape_sequence) @string.escape (#set! priority 130))
([ (true) (false) ] @boolean (#set! priority 130))

(const_spec
  name: (identifier) @constant (#set! priority 130))
