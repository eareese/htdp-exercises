; (define (f "x") x)
;; This is illegal because "x" is a value, not a variable, since it is in quote marks. Therefore, (f "x") is not legal syntax for the "as many variables as you wish" part of the define syntax.

; (define (f x y z) (x))
;; This would be legal, if not for the (x), which is not valid syntax for an expression since a variable should not be enclosed in ().
