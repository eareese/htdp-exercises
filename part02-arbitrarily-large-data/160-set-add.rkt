#lang htdp/bsl

;; Exercise 160. Design the functions set+.L and set+.R, which create a set by adding a number x to some given set s for the left-hand and right-hand data definition, respectively.

; A Son.L is one of:
; – empty
; – (cons Number Son.L)
;
; Son is used when it
; applies to Son.L and Son.R

; A Son.R is one of:
; – empty
; – (cons Number Son.R)
;
; Constraint If s is a Son.R,
; no number occurs twice in s.
;; Figure 58: Two data representations for sets


; Son
;; empty set
(define es '())

; Number Son -> Son
; is x in s
(define (in? x s)
  (member? x s))


;; Figure 59: Functions for the two data representations of sets
; Number Son.L -> Son.L
; remove x from s
(define s1.L
  (cons 1 (cons 1 '())))

(check-expect
 (set-.L 1 s1.L) es)

(define (set-.L x s)
  (remove-all x s))

; Number Son.R -> Son.R
; remove x from s
(define s1.R
  (cons 1 '()))

(check-expect
 (set-.R 1 s1.R) es)

(define (set-.R x s)
  (remove x s))


(define ASET (cons 1 (cons 2 '())))

; Number Son.L -> Son.L
; add x to s
(check-expect (set+.L 2 ASET) (cons 2 (cons 1 (cons 2 '()))))
(define (set+.L x s)
  (append (cons x '()) s))

; Number Son.R -> Son.R
; add x to s
(check-expect (set+.R 2 ASET) (cons 1 (cons 2 '()))) ; set is unique
(check-expect (set+.R 3 ASET) (cons 3 (cons 1 (cons 2 '()))))
(define (set+.R x s)
  (if (member? x s) s (append (cons x '()) s)))
