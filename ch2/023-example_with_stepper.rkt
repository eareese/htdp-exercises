#lang htdp/bsl

(define (ff a) (* 10 a))

(ff (+ 1 1))

(ff (ff 1))
