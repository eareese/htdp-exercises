; Syntactically legal expressions:

; x
;; This is a variable, so it is an expression. There are more complex kinds of expressions, but every variable itself is an expression.


; (= y z)
;; This is an expression. It applies a primitive expression `=` to the expressions (variables) y and z.


; (= (= y z) 0)
;; This is an expression of the form (primitive expr expr ...), where the first expr of that is another (primitive expr expr ...), followed by the expression 0 which is just a value.
