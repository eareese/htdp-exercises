#lang htdp/bsl

;; Exercise 161. Translate the examples into tests and make sure they all succeed. Then change the function in figure 60 so that everyone gets $14 per hour. Now revise the entire program so that changing the wage for everyone is a single change to the entire program and not several.

; wage per hour = $14
(define WPH 14)

; Number -> Number
; computes the wage for h hours of work
(define (wage h)
  (* WPH h))

; List-of-numbers -> List-of-numbers
; computes the weekly wages for the weekly hours
(check-expect (wage* '()) '())
(check-expect (wage* (cons 28 '())) (cons (* 28 WPH) '()))
(check-expect (wage* (cons 4 (cons 2 '()))) (cons (* 4 WPH) (cons (* 2 WPH) '())))
(define (wage* whrs)
  (cond
    [(empty? whrs) '()]
    [else (cons (wage (first whrs)) (wage* (rest whrs)))]))
