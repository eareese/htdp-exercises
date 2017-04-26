;;---------------------------------------------------------------------------------------------------
#lang htdp/bsl+

;; Exercise 236. Create test suites for the following two functions:
;; ; Lon -> Lon
;; ; add 1 to each item on l
;; (define (add1* l)
;;   (cond
;;     [(empty? l) '()]
;;     [else
;;      (cons
;;       (add1 (first l))
;;       (add1* (rest l)))]))

;; ; Lon -> Lon
;; ; adds 5 to each item on l
;; (define (plus5 l)
;;   (cond
;;     [(empty? l) '()]
;;     [else
;;      (cons
;;       (+ (first l) 5)
;;       (plus5 (rest l)))]))
;; Then abstract over them. Define the above two functions in terms of the abstraction as one-liners and use the existing test suites to confirm that the revised definitions work properly. Finally, design a function that subtracts 2 from each number on a given list.

; Lon -> Lon
; add 1 to each item on l
(check-expect (add1* '()) '())
(check-expect (add1* '(1 3 5)) '(2 4 6))
(check-expect (add1* '(10 20 30 40 50)) '(11 21 31 41 51))
(define (add1* l)
  (cond
    [(empty? l) '()]
    [else
     (cons
      (add1 (first l))
      (add1* (rest l)))]))

; Lon -> Lon
; adds 5 to each item on l
(check-expect (plus5 '()) '())
(check-expect (plus5 '(1 3 5)) '(6 8 10))
(check-expect (plus5 '(-5 0 2 8)) '(0 5 7 13))
(define (plus5 l)
  (cond
    [(empty? l) '()]
    [else
     (cons
      (+ (first l) 5)
      (plus5 (rest l)))]))

; List-of-Numbers -> List-of-Numbers
; add n to each item on l
(check-expect (addn 1 '()) '())
(check-expect (addn 1 '(1 3 5 7)) '(2 4 6 8))
(check-expect (addn 13 '(-13 7)) '(0 20))
(define (addn n l)
  (cond
    [(empty? l) '()]
    [else
     (cons (+ n (first l)) (addn n (rest l)))]))

;; List-of-Numbers -> List-of-Numbers
;; subtract 2 from each number on l
(check-expect (sub2 '(2 3 4)) '(0 1 2))
(define (sub2 l)
  (addn -2 l))
