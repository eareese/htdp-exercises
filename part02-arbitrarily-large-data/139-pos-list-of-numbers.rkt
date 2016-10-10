#lang htdp/bsl

;; Exercise 139. Now take a look at this data definition:

;; ; A List-of-numbers is one of:
;; ; – '()
;; ; – (cons Number List-of-numbers)

;; Some elements of this class of data are appropriate inputs for sum from exercise 138 and some aren’t.

;; Design the function pos?, which consumes a List-of-numbers and determines whether all numbers are positive numbers. In other words, if (pos? l) yields #true, then l is an element of List-of-amounts. Use DrRacket’s stepper to understand how pos? works for (cons 5 '()) and (cons -1 '()).

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

; List-of-numbers -> Boolean
; consumes a List-of-numbers and determines whether all numbers are positive numbers.
(check-expect (pos? (cons 7 (cons -1 '()))) #f)
(check-expect (pos? (cons 7 (cons 0 '()))) #f)
(check-expect (pos? (cons 7 (cons 77 '()))) #t)
(check-expect (pos? (cons 7 '())) #t)
(check-expect (pos? '()) #t) ; ensure this is a valid List-of-amounts
(define (pos? alon)
  (cond [(empty? alon) #t]
        [(cons? alon)
         (if (not (positive? (first alon))) #f (pos? (rest alon)))]))

;; Also design checked-sum. The function consumes a List-of-numbers. It produces their sum if the input also belongs to List-of-amounts; otherwise it signals an error. Hint Recall to use check-error.

; List-of-numbers -> Number
; produces sum of numbers if the input belongs to List-of-amounts.
; otherwise, it signals an error.
(check-expect (checked-sum (cons 7 (cons 77 '()))) 84)
(check-error (checked-sum (cons 7 (cons -1 '()))) "Not a List-of-amounts.")
(define (checked-sum alon)
  (if (pos? alon)
      (sum alon)
      (error "Not a List-of-amounts.")))

;; What does sum compute for an element of List-of-numbers?
; still the sum? just not a cumulative sum, since the negative numbers get subtracted from the total.
