; (x)
;; This is not valid syntax for anything. It could be a variable x, if only it stood alone and not inside parentheses.

; (+ 1 (not x))
;; This is legal, I think. It is an expression that starts with a primitive expression, followed by a value, followed by another expression (not x). The inner expression is valid since it conforms to (primitive expr), and the outer expression has the valid format (primitive expr expr), where the second expr is that inner expression.

; (+ 1 2 3)
;; This is legal, it matches the format (primitive expr expr expr), which is valid syntax for an expression, and each of its `expr`s is a valid expression that is just a value.
