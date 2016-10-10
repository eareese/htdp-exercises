#lang htdp/bsl
(define x 3)
(define y 4)

(define (distance x y)
  (sqrt (+
         (sqr x)
         (sqr y))))

(distance x y)

(check-expect (distance 3 4) 5)

