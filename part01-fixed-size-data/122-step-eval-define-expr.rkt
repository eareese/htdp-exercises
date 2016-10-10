#lang htdp/bsl

;; Exercise 122. Suppose the program contains these definitions:
(define (f x y)
  (+ (* 3 x) (* y y)))

;; Show how DrRacket evaluates the following expressions, step by step:

;; 1
(+ (f 1 2) (f 2 1))


;; 2
(f 1 (* 2 3))


;; 3
(f (f 1 (* 2 3)) 19)

