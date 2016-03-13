#lang htdp/bsl

; calculate distance from origin to point (x, y)
(define (origin-distance x y)
  (sqrt (+
         (sqr x)
         (sqr y))))

(check-expect (origin-distance 3 4) 5)
