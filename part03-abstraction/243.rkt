;;---------------------------------------------------------------------------------------------------
#lang htdp/isl
;; Exercise 243. Assume the definitions area in DrRacket contains
(define (f x) x)

;; Identify the values among the following expressions:

(cons f '())
;; Sure, since a function is a value, it can be on a list.

(f f)
;; This is another valid function value, my assumption is that it will work like function composition.

(cons f (cons 10 (cons (f 10) '())))
;; Well, (f 10) certainly evaluates to a value, and 10 is clearly a value. If what I said above is true and functions-as-values can be list items, then this must be a value, too.


;; Explain why they are (not) values.
