#lang htdp/bsl+
;;---------------------------------------------------------------------------------------------------

;; Exercise 186. Take a second look at Intermezzo: BSL, the intermezzo that presents BSL and its ways
;; of formulating tests. One of the latter is check-satisfied, which determines whether an expression
;; satisfies a certain property. Use sorted>? from exercise 145 to re-formulate the tests for sort>
;; with check-satisfied.

;; Now consider this function definition:

;;     ; List-of-numbers -> List-of-numbers
;;     ; produces a sorted version of l
;;     (define (sort>/bad l)
;;      '(9 8 7 6 5 4 3 2 1 0))

;; Can you formulate a test case that shows sort>/bad is not a sorting function? Can you use
;; check-satisfied to formulate this test case?

;; Notes (1) What may surprise you here is that we define a function to create a test. In the real
;; world, this step is common and, on occasion, you really need to design functions for tests—with
;; their own tests and all. (2) Formulating tests with check-satisfied is occasionally easier than
;; using check-expect (or other forms), and it is also a bit more general. When the predicate
;; completely describes the relationship between all possible inputs and outputs of a function,
;; computer scientists speak of a specification. Specifying with lambda explains how to specify
;; sort> completely.


; List-of-numbers -> List-of-numbers
; produces a sorted version of l
(define (sort>/bad l)
  '(9 8 7 6 5 4 3 2 1 0))

(define (sorted? l)
  (cond
    [(empty? l) #t]
    [else (and (<= (first l) (second l)) (sorted? (rest l)))]))

(check-satisfied (sort>/bad (list 1 3 0 2)) sorted?)
