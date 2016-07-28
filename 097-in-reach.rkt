#lang htdp/bsl
(require 2htdp/image)

;; Exercise 97. A programmer has chosen to represent locations on the Cartesian
;; plane as pairs (x, y) or as single numbers if the point lies on one of the
;; axes:
;
; Location is one of:
; – Posn
; – Number
; interpretation Posn are positions on the Cartesian plane,
; Numbers are positions on either the x- or the y-axis.
;
;; Design the function in-reach?, which determines whether a given location’s
;; distance to the origin is strictly less than some constant R.
;
;; Note This function has no connection to any other material in this chapter.


; in-reach?
;; Location Number -> Boolean
; Number test
; determines whether a given location’s distance to the origin is strictly less
; than some constant R.
(check-expect (in-reach? 7 5) #f)
(check-expect (in-reach? 7 7) #f)
(check-expect (in-reach? 7 19) #t)
(check-expect (in-reach? (make-posn 3 4) 2) #f)
(check-expect (in-reach? (make-posn 3 4) 5) #f)
(check-expect (in-reach? (make-posn 3 4) 19) #t)
(define R 99)
(define (in-reach? loc R)
  (<
   (cond [(posn? loc) (origin-distance (posn-x loc) (posn-y loc))]
         [else (origin-distance loc 0)])
   R))

; origin-distance
; Number Number -> Number
; returns the distance to origin (0,0) given x and y of a cartesian coordinate
(check-expect (origin-distance 0 -7) 7)
(check-expect (origin-distance -7 0) 7)
(check-expect (origin-distance 3 4) 5)
(check-expect (origin-distance -3 -4) 5)
(define (origin-distance x y)
  (sqrt (+ (sqr x) (sqr y))))
