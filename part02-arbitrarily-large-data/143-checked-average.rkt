#lang htdp/bsl

; A List-of-temperatures is one of:
; – '()
; – (cons CTemperature List-of-temperatures)

; A CTemperature is a Number greater than -273.

; List-of-temperatures -> Number
; computes the average temperature
;; (check-expect
;;  (average (cons 1 (cons 2 (cons 3 '())))) 2)
;; (define (average alot)
;;   (/ (sum alot) (how-many alot)))

; List-of-temperatures -> Number
; adds up the temperatures on the given list
;; (define (sum alot)
;;   (cond
;;     [(empty? alot) 0]
;;     [else (+ (first alot) (sum (rest alot)))]))

; List-of-temperatures -> Number
; counts the temperatures on the given list
;; (define (how-many alot)
;;   (cond
;;     [(empty? alot) 0]
;;     [else (+ (how-many (rest alot)) 1)]))

;; Exercise 143. Determine how average behaves in DrRacket when applied to the empty list. Then design checked-average, a function that produces an informative error message when it is applied to '().
;; (average '())
; Calling average on an empty list causes a divide-by-zero error.

;; ; NumberOrError is one of:
;; ; – Number
;; ; – Error

; List-of-temperatures -> NumberOrError
; computes the average temperature. If the list is empty, produces an error.
(check-expect
 (average (cons 1 (cons 2 (cons 3 '())))) 2)
(check-error (average '()) "Can't average an empty list.")
(define (average alot)
  (if (empty? alot)
      (error "Can't average an empty list.")
      (/ (sum alot) (how-many alot))))

; List-of-temperatures -> Number
; adds up the temperatures on the given list
(define (sum alot)
  (cond
    [(empty? alot) 0]
    [else (+ (first alot) (sum (rest alot)))]))

; List-of-temperatures -> Number
; counts the temperatures on the given list
(define (how-many alot)
  (cond
    [(empty? alot) 0]
    [else (+ (how-many (rest alot)) 1)]))

;; NOTE: In mathematics, we would say exercise 143 shows that average is a partial function because it raises an error for '().
