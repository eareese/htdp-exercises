#lang htdp/bsl

;; Exercise 145. Design sorted>?. The function consumes a NEList-of-temperatures. It produces #true if the temperatures are sorted in descending order, that is, if the second is smaller than the first, the third smaller than the second, and so on. Otherwise it produces #false.

;; Hint This problem is another one where the table-based method for guessing the combinator works well. Here is a partial table for a number of examples in figure 54. Fill in the rest of the table. Then try to create an expression that computes the result from the pieces.

;   l        (first l)        (rest l)      (sorted>? (rest l))    (sorted>? l)
;-------------------------------------------------------------------------------
;(cons 1
; (cons 2      1            (cons 2 '())      #true                 #false
;  '()))
;
;(cons 3
; (cons 2      3            (cons 2 '())      #true                 #true
;  '()
;
;(cons 0
; (cons 3      0            (cons 3           #true                 #false
;  (cons 2                   (cons 2
;   '())))                    '()))


; NEList-of-temperatures -> Boolean
; Produces #true if the list of temps is sorted in DESCENDING order:
; if the second element is smaller than the first, the third smaller
; than the second, and so on. Otherwise, produces #false.
(check-expect (sorted>? (cons 1 (cons 2 '()))) #f)
(check-expect (sorted>? (cons 3 (cons 2 '()))) #t)
(check-expect (sorted>? (cons 0 (cons 3 (cons 2 '())))) #f)
(define (sorted>? temps)
  (cond [(empty? (rest temps)) #t]
        [(cons? temps)
         (if (>= (first (rest temps)) (first temps))
             #f
             (sorted>? (rest temps)))]))

(sorted>? (cons 7 '()))
