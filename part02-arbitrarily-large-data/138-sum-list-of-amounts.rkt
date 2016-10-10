#lang htdp/bsl

;; Exercise 138. Here is a data definition for representing sequences of amounts of money:

;; ; A List-of-amounts is one of:
;; ; – '()
;; ; – (cons PositiveNumber List-of-amounts)

;; Create some examples to make sure you understand the data definition. Also add an arrow for the self-reference.

(cons 7 '())
'()
(cons 7 (cons 17 '()))
(cons 7
      (cons 17
            (cons 77
                  '())))

;; Design the sum function, which consumes a List-of-amounts and computes the sum of the amounts. Use DrRacket’s stepper to see how (sum l) works for a short list l in List-of-amounts.

; List-of-amounts -> Number
; described above.
(check-expect (sum '()) 0)
(check-expect (sum (cons 7 (cons 3 '()))) 10)
(check-expect (sum (cons 7 '())) 7)
(check-expect (sum (cons 1 (cons 1 (cons 1 '())))) 3)
(define (sum aloa)
  ;; (if (empty? aloa) 0 (sum (rest aloa))))
  (cond
    [(empty? aloa) 0]
    [(cons? aloa) (+ (first aloa) (sum (rest aloa)))]))

(define l (cons 2 (cons 4 (cons 6 '()))))
(sum l)
