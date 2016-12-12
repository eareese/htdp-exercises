#lang htdp/bsl

;; Exercise 151. Design the function multiply. It consumes a natural number n
;; and multiplies it with a number x without using *.
;; 
;; Use DrRacket’s stepper to evaluate (multiply 3 x) for any x you like. How
;; does multiply relate to what you know from grade school.


; N Number -> Number
; consumes a natural number n and multiplies it with a number x without using *
(check-expect (multiply 3 2.1) 6.3)
(check-expect (multiply 3 7.7) 23.1)
(check-expect (multiply 3 0) 0)
(check-expect (multiply 0 7) 0)
(check-expect (multiply 0 0) 0)
(define (multiply n x)
  (cond
    [(zero? n) 0]
    [else (+ (multiply (sub1 n) x) x)]))

;; when you first learn multiplication, you learn that it's the same as totaling
;; a group of the same number. For instance, you can say that 3x7=21 is "three
;; sevens" (or "seven threes") and that is analagous to addition, which is the
;; operation used here to avoid the * operator.
