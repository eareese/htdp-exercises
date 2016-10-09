#lang htdp/bsl

;; Exercise 146. Design how-many for NEList-of-temperatures. Doing so completes average, so ensure that average passes all of its tests, too.

; A NEList-of-temperatures is one of:
; – (cons CTemperature '())
; – (cons CTemperature NEList-of-temperatures)
; interpretation non-empty lists of Celsius temperatures

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

; NEList-of-temperatures -> Number
; counts the temperatures on the given non-empty list-of-temperatures
(check-expect (how-many (cons 0 (cons 0 (cons 0 '())))) 3)
(define (how-many lot)
  (cond [(empty? (rest lot)) 1]
        [else (+ 1 (how-many (rest lot)))]))
