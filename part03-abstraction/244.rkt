;;---------------------------------------------------------------------------------------------------
#lang htdp/isl


;; Exercise 244. Argue why the following sentences are now legal:

;; (define (f x) (x 10))
;; It is legal since x itself can be a function that's called on 10 by f

;; (define (f x) (x f))
;; This seems legal if x and f are functions which can summon each other recursively


(define (f x y) (x 'a y 'b))
;; Yes, this function can apply other functions to some lists

;; Explain your reasoning.
