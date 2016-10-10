#lang htdp/bsl

;; Exercise 134. Develop the function contains?. It determines whether some given string occurs on a given list of strings.

;; Note BSL actually comes with member?, a function that consumes two values and checks whether the first occurs in the second, a list:

;; > (member? "Flatt" (cons "b" (cons "Flatt" '())))

;; #true

;; Don’t use member? to define the contains? function.

; List-of-names given -> Boolean
; determines whether the given string occurs on alon
(check-expect
 (contains? (cons "X" (cons "Y"  (cons "Z" '()))) "Flatt")
 #false)
(check-expect
 (contains? (cons "A" (cons "Flatt" (cons "C" '()))) "Flatt")
 #true)
(define (contains? alon given)
  (cond
    [(empty? alon) #false]
    [(cons? alon)
     (cond
       [(string=? (first alon) given) #true]
       [else (contains? (rest alon) given)])]))

