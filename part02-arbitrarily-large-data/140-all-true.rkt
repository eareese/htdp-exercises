#lang htdp/bsl

;; Exercise 140. Design the function all-true, which consumes a list of Boolean values and determines whether all of them are #true. In other words, if there is any #false on the list, the function produces #false.

; A List-of-booleans is one of:
; – '()
; – (cons Boolean List-of-booleans)


; List-of-booleans -> Boolean
; determines whether all of the list items are true. If there is
; any #false on the list, the function produces #false.
(check-expect (all-true (cons #t '())) #t)
(check-expect (all-true (cons #t (cons #f '()))) #f)
(check-expect (all-true '()) #t)
(define (all-true alob)
  (cond [(empty? alob) #t]
        [(cons? alob)
         (if (false? (first alob)) #f (all-true (rest alob)))]))

;; Now design one-true, a function that consumes a list of Boolean values and determines whether at least one item on the list is #true.

; List-of-booleans -> Boolean
; determines whether AT LEAST ONE item on the list is #true.
(check-expect (one-true '()) #f)
(check-expect (one-true (cons #t '())) #t)
(check-expect (one-true (cons #t (cons #f (cons #f '())))) #t)
(check-expect (one-true (cons #f (cons #f (cons #t '())))) #t)
(check-expect (one-true (cons #f '())) #f)
(define (one-true alob)
  (cond [(empty? alob) #f]
        [(cons? alob)
         (if (eq? #t (first alob)) #t (one-true (rest alob)))]))
