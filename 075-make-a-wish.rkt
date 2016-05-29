#lang htdp/bsl

; Sample Problem: Your team is designing a game program that keeps
; track of an object that moves across the canvas at changing speed.
; The chosen data representation requires two data definitions:

(define-struct vel [deltax deltay])
; a Vel is a structure: (make-vel Number Number)
; interpretation (make-vel dx dy) means a velocity of dx pixels per
; tick along the horizontal, and dy pixels along the vertical.

(define-struct ufo [loc vel])
; a UFO is a structure: (make-ufo Posn Vel)
; interpretation (make-ufo p v) is at location p moving at velocity v


(define v1 (make-vel 8 -3))
(define v2 (make-vel -5 -3))

(define p1 (make-posn 22 80))
(define p2 (make-posn 30 77))

(define u1 (make-ufo p1 v1))
(define u2 (make-ufo p1 v2))
(define u3 (make-ufo p2 v1))
(define u4 (make-ufo p2 v2))

; UFO -> UFO
; determines where u moves in one clock tick;
; leaves velocity as it is
(check-expect (ufo-move-1 u1) u3)
(check-expect (ufo-move-1 u2) (make-ufo (make-posn 17 77) v2))
(define (ufo-move-1 u)
  (make-ufo (posn+ (ufo-loc u) (ufo-vel u)) (ufo-vel u)))

; NOTE: "making a wish"
; Posn Vel -> Posn
; adds v to p
; (define (posn+ p v) p)

; Posn Vel -> Posn
; adds v to p
(check-expect (posn+ p1 v1) p2)
(check-expect (posn+ p1 v2) (make-posn 17 77))
(define (posn+ p v)
  (make-posn (+ (posn-x p) (vel-deltax v))
             (+ (posn-y p) (vel-deltay v))))
