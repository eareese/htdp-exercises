#lang htdp/bsl

;; Exercise 127. Suppose the program contains:

(define-struct ball [x y speed-x speed-y])

;; Predict the results of evaluating the following expressions:

(number? (make-ball 1 2 3 4))
; #false

(ball-speed-y (make-ball (+ 1 2) (+ 3 3) 2 3))
; 3

(ball-y (make-ball (+ 1 2) (+ 3 3) 2 3))
; 6

(ball-x (make-posn 1 2))
; invalid syntax!
;; ball-x: expects a ball, given (make-posn 1 2)

(ball-speed-y 5)
; invalid syntax!
;; ball-speed-y: expects a ball, given 5

;; Check your predictions in the interactions area and with the stepper.
