#lang htdp/bsl

;; Exercise 163. Design convertFC. The function converts a list of measurements in Fahrenheit to a list of Celsius measurements.


; List-of-numbers -> List-of-numbers
; consumes a list of temp measurements in F, returns list of C temps
(check-expect (convertFC (cons 32 '())) (cons 0 '()))
(check-expect (convertFC (cons 100 (cons 200 '()))) (cons (calc 100) (cons (calc 200) '())))
(define (convertFC temps)
  (cond
    [(empty? temps) '()]
    [else (cons (calc (first temps)) (convertFC (rest temps)))]))

; Number -> Number
; consumes a Fahrenheit measurement, converts to Celsius measurement
(check-expect (calc 32) 0)
(check-expect (calc 212) 100)
(define (calc f)
  (/ (- f 32) 1.8))
