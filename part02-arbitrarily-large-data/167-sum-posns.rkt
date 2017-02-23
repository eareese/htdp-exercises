#lang htdp/bsl

;; Exercise 167. Design the function sum, which consumes a list of Posns and produces the sum of all of its x-coordinates.

; Lop
;; A List of positions is one of:
;; - '()
;; - (cons Posn Lop)
;; interpretation a list of (x, y) coordinate positions

; Lop -> Number
; consumes a Lop and produces the sum of all its x coords
(check-expect (sum '()) 0)
(check-expect (sum (cons (make-posn 0 0) '())) 0)
(check-expect (sum (cons (make-posn 0 1) '())) 0)
(check-expect (sum (cons (make-posn 7 0) '())) 7)
(check-expect (sum (cons (make-posn 7 7) (cons (make-posn 7 0) '()))) 14)
(check-expect (sum (cons (make-posn 8 7) (cons (make-posn 8 1) '()))) 16)
(define (sum alop)
  (cond
    [(empty? alop) 0]
    [(cons? alop) (+ (posn-x (first alop)) (sum (rest alop)))]))
