;;---------------------------------------------------------------------------------------------------
#lang htdp/isl
;; Exercise 245. Develop function=at-1.2-3-and-5.775?. Given two functions from numbers to numbers,
;; the function determines whether the two produce the same results for 1.2, 3, and -5.775.

; Number -> Number
; add 2 to the given number
(check-expect (add2 3) 5)
(define (add2 n) (+ 2 n))

; Number -> Number
; subtract 7 from the given number
(check-expect (minus7 4) -3)
(define (minus7 n) (- n 7))

; Number -> Number
; subtract 7 from the given number
(check-expect (sub7 4) -3)
(define (sub7 n) (- n 7))

; Function Function -> Boolean
; produces #t if the two functions produce the same results for 1.2, 3, and -5.775
(check-expect (function=at-1.2-3-and-5.775? add2 sub7) #f)
(check-expect (function=at-1.2-3-and-5.775? sub7 minus7) #t)
(define (function=at-1.2-3-and-5.775? f g)
  (and (= (f 1.2) (g 1.2))
       (= (f 3) (g 3))
       (= (f -5.775) (g -5.775))))

;; Mathematicians say that two functions are equal if they compute the same result when given the
;; same input—for all possible inputs.

;; Can we hope to define function=?, which determines whether two functions from numbers to numbers
;; are equal? If so, define the function. If not, explain why and consider the implication that you
;; have encountered the first easily definable idea for which you cannot define a function.


;; I don't think it's possible to define a function that tests all possible inputs, because that
;; amounts to infinitely many inputs.
;; It's good and all, to test the inputs at 1.2, and 1.22, and 1.222, and so on, but that's only good
;; enough and not really testing each and every possible input.
