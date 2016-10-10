#lang htdp/bsl

(define-struct ball [location velocity])

(define-struct vel [deltax deltay])

(define ball1 (make-ball (make-posn 30 40) (make-vel -10 5)))
; interpretation
; a ball that is 30px from the left, 40px from top. it moves
; -10px toward left per tick, and its vertical direction drops
; at 5px per tick, since adding + to y increases distance from top.

; exercise 69
; flat representation
(define-struct ballf [x y deltax deltay])

; create an instance of ballf that has the same interpretation
; as ball1 above.

; is this it?
(define ball2 (make-ballf 30 40 -10 5))
