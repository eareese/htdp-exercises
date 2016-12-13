#lang htdp/bsl

;; Exercise 165. Design the function subst-robot, which consumes a list of toy descriptions (one-word strings) and replaces all occurrences of "robot" with "r2d2"; all other descriptions remain the same.
;; 
;; Generalize subst-robot to substitute. The latter consumes two strings, called new and old, and a list of strings. It produces a new list of strings by substituting all occurrences of old with new.

; consumes a list of toy descriptions, which are one-word strings.
; produces new list of strings by replacing all "robot" with "r2d2"
(check-expect (subst-robot (cons "ball" '())) (cons "ball" '()))
(check-expect (subst-robot (cons "robot" (cons "ball" '()))) (cons "r2d2" (cons "ball" '())))
(check-expect (subst-robot '()) '())
(define (subst-robot descs)
  (cond
    [(empty? descs) '()]
    [else (cons
           (if (string=? "robot" (first descs)) "r2d2" (first descs))
           (subst-robot (rest descs)))]))

; consumes a list of toy descriptions, which are one-word strings, as well
; as two strings called 'new' and 'old' which are used for substitution.
; produces new list of strings by replacing all 'old' with 'new'
(check-expect (substitute (cons "ball" '()) "robot" "r2d2") (cons "ball" '()))
(check-expect (substitute (cons "robot" (cons "ball" '())) "robot" "r2d2") (cons "r2d2" (cons "ball" '())))
(check-expect (substitute '() "robot" "r2d2") '())
(define (substitute descs old new)
  (cond
    [(empty? descs) '()]
    [else (cons
           (if (string=? old (first descs)) new (first descs))
           (substitute (rest descs) old new))]))
