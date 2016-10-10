; (define (f x) x)
;; This is syntactically legal.
;; The def syntax requires the format (define (var var ...) expr)
;; Where there are any number of vars or variables.
;; So, the (f x) matches the format of (variable variable), and the final x is a valid expression since it is just a variable too.

; (define (f x) y)
;; This is legal, I think. It appears to have the same valid def format as the one above, except I know it would be broken because the variable y isn't part of the (checks vocab chart) function parameters. But, I can't point to the "rule" about that in the syntax

; (define (f x y) 3)
;; This is syntactically legal.
;; Since the second part of the define syntax calls for as many variables as you wish enclosed in parentheses, (f x y) matches that. Finally, the 3 is just a value so it is an expression.
