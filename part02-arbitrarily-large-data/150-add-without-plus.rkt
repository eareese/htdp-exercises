#lang htdp/bsl

;; Exercise 150. Design the function add-to-pi. It consumes a natural number n
;; and adds it to pi without using the primitive + operation. Here is a start:
;;
;; ; N -> Number
;; ; computes (+ n pi) without using +
;;
;; (check-within (add-to-pi 3) (+ 3 pi) 0.001)
;;
;; (define (add-to-pi n)
;;   pi)
;;
;; Once you have a complete definition, generalize the function to add, which
;; adds a natural number n to some arbitrary number x without using +. Why
;; does the skeleton use check-within?


; N -> Number
; computes (+ n pi) without using +
(check-within (add-to-pi 3) (+ 3 pi) 0.001)
(define (add-to-pi n)
  (cond
    [(zero? n) pi]
    [else (add1 (add-to-pi (sub1 n)))]))

; N Number -> Number
; adds a natural number n to some number x without using +
(check-expect (add 3 9.7) 12.7)
(check-expect (add 0 0) 0)
(check-expect (add 7 7.77) 14.77)
(define (add n x)
  (cond
    [(zero? n) x]
    [else (add1 (add (sub1 n) x))]))

;; to answer the check-within question: pi is involved, making it impossible to
;; check with exactness. We couldn't even check whether pi is equal to 3.14 ...
;; and so on -- for the exact reason that I can't write out a number that's
;; precisely equal to pi.
