#lang htdp/bsl

;; Exercise 147. Develop a data definition for NEList-of-Booleans, a representation of non-empty lists of Boolean values. Then re-design the functions all-true and one-true from exercise 140.

; A NEList-of-Booleans is one of:
; - (cons #true '())
; - (cons #false '())
; - (cons #true NEList-of-Booleans)
; - (cons #false NEList-of-Booleans)
; interpretation non-empty lists of Boolean values

; NEList-of-booleans -> Boolean
; determines whether all of the list items are true. If there is
; any #false on the list, the function produces #false.
(check-expect (all-true (cons #t '())) #t)
(check-expect (all-true (cons #t (cons #f '()))) #f)
(define (all-true alob)
  (cond [(and (empty? (rest alob)) (eq? #t (first alob))) #t]
        [(cons? alob)
         (if (false? (first alob)) #f (all-true (rest alob)))]))


; NEList-of-booleans -> Boolean
; determines whether #true appears at least once in the list.
(check-expect (one-true (cons #t '())) #t)
(check-expect (one-true (cons #t (cons #f (cons #f '())))) #t)
(check-expect (one-true (cons #f (cons #f (cons #t '())))) #t)
(check-expect (one-true (cons #f '())) #f)
(define (one-true alob)
  (cond [(and (eq? #t (first alob)) (empty? (rest alob))) #t]
        [(and (eq? #f (first alob)) (empty? (rest alob))) #f]
        [(cons? alob)
         (if (eq? #t (first alob)) #t (one-true (rest alob)))]))
