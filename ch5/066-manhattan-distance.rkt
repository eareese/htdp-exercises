#lang htdp/bsl

; measures the manhattan distance of a given posn to the origin
(check-expect (manhattan-dist (make-posn 3 4)) 7)
(check-expect (manhattan-dist (make-posn 4 3)) 7)
(define (manhattan-dist a-posn)
  (+ (posn-x a-posn) (posn-y a-posn)))
