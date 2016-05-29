#lang htdp/bsl
(require 2htdp/image)
(require 2htdp/universe)

; visual constants
(define MTS (empty-scene 100 100))
(define DOT (circle 3 "solid" "blue"))

; the state of the world is represented by a Posn.
; Posn -> Posn
(define (main p0)
  (big-bang p0
            [on-tick x+]
            [on-mouse reset-dot]
            [to-draw scene+dot]))

; Posn -> Image
; adds a spot to MTS at p
(check-expect (scene+dot (make-posn 10 20))
              (place-image DOT 10 20 MTS))
(check-expect (scene+dot (make-posn 88 73))
              (place-image DOT 88 73 MTS))
(define (scene+dot p)
  (place-image DOT (posn-x p) (posn-y p) MTS))


; Posn -> Posn
; increases the x-coordinate of p by 3
(check-expect (x+ (make-posn 10 0)) (make-posn 13 0))
(define (x+ p)
  (make-posn (+ (posn-x p) 3) (posn-y p)))


; Posn Number -> Posn
; consumes p and number n, produces posn like p with n as posn-x
(check-expect (posn-up-x (make-posn 47 10) 0)
              (make-posn 0 10))
(define (posn-up-x p n)
  (make-posn n (posn-y p)))

; mouse-event handlers consume 4 values:
; - current world state
; - x-coord of mouse click
; - y-coord of mouse click
; - a MouseEvt
; Posn Number Number MouseEvt -> Posn
(check-expect (reset-dot (make-posn 10 20) 29 31 "button-down")
              (make-posn 29 31))
(check-expect (reset-dot (make-posn 10 20) 29 31 "button-up")
              (make-posn 10 20))
(define (reset-dot p x y me)
  (cond
    [(mouse=? me "button-down") (make-posn x y)]
    [else p]))

; (main (make-posn 30 30))
