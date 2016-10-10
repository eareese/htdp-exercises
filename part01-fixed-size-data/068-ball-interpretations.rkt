#lang htdp/bsl

(define-struct ball [location velocity])
; (make-ball 10 -3)
; represents a ball that is 10px from the top and moves up
; at 3px per clock tick.



; other ways
; interpret this program fragment and then create other instances of balld.

(define SPEED 3)
(define-struct balld [location direction])
; represents a ball that is 10px from the top and moves up at some
; fixed rate per clock tick (we'll say 3px per tick still)
(make-balld 10 "up")
(make-balld 10 "down")

; could represent other states such as rest: when direction is "stop",
; ignore the per-tick movement and remain in same location
(make-balld 20 "stop")

; depending on the interpretation of location, we could maybe let
; a direction keyword move the ball left or right. then location
; would represent y-position from left to right
(make-balld 50 "left")
