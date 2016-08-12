; Illegal expressions

; (3 + 4)
;; The primitive expression + operator is not in the right place to be a properly formed expression. Should be (+ 3 4)

; number?
;; A primitive cannot stand alone. The only way it is syntactically valid is as part of a properly formed expression.

; (x)
;; The only places where parens are valid syntax are as part of certain expressions or definition statements. A variable by itself should not be enclosed in parentheses, because a variable alone constitutes a properly formed expression.
