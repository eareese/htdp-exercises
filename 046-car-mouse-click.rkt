#lang htdp/bsl
(require 2htdp/image)
(require 2htdp/universe)

; Sample Problem: Design a program that moves a car across the world canvas,
; from left to right, at the rate of three pixels per clock tick. If the mouse
; is clicked anywhere on the canvas, the car is placed at the x-coordinate of
; that point.

(define tree
  (underlay/xy (circle 10 "solid" "green")
               9 15
               (rectangle 2 20 "solid" "brown")))

(define WIDTH-OF-WORLD 200)
(define HEIGHT-OF-WORLD 200)
(define BACKGROUND (overlay
                    tree
                    (rectangle
                     WIDTH-OF-WORLD
                     HEIGHT-OF-WORLD
                     "outline"
                     "black")))

(define Y-CAR (* HEIGHT-OF-WORLD 0.6))

; WHEEL-RADIUS is the single point of control for the size of CAR
(define WHEEL-RADIUS 5)

(define WHEEL-DISTANCE (* WHEEL-RADIUS 5))

(define WHEEL (circle WHEEL-RADIUS "solid" "black"))
(define SPACE (rectangle WHEEL-DISTANCE WHEEL-RADIUS
                         "solid" "transparent"))
(define BOTH-WHEELS (beside WHEEL SPACE WHEEL))

(define CAR-BODY-LENGTH (* 12 WHEEL-RADIUS))
(define CAR-BODY (overlay/align "middle" "bottom"
                                (rectangle
                                 (* 6 WHEEL-RADIUS)
                                 (* 4 WHEEL-RADIUS)
                                 "solid" "blue")
                                (rectangle
                                 CAR-BODY-LENGTH
                                 (/ CAR-BODY-LENGTH 6)
                                 "solid" "blue")))

(define CAR (above CAR-BODY BOTH-WHEELS))

; AnimationState is a Number
; interpretation the number of clock ticks since the animation started

; AnimationState -> Image
; use # of ticks since start as x to place the car from the left
; the BACKGROUND image
(define (render x)
  (place-image/align CAR
                     x
                     Y-CAR
                     "right"
                     "center"
                     BACKGROUND))

; clock-tick-handler
; AnimationState -> AnimationState
; adds 3 to anim-state
; example:
; given: 20, expect 23
; given: 4003, expect 4006
(define (tock anim-state)
  (+ anim-state 3))

; end?
; AnimationState -> boolean
; delivers world ending condition. in this case, when the car
; has gone off the edge of the BACKGROUND.
; example:
; given: 35, expect #f
; given: 500, expect #t
(define (last-state anim-state)
  (>= anim-state 500))

; mouse-event-handler
; AnimState Number Number String -> AnimState
; places the car at the x-coordinate if me is "button-down"
; given: 21 10 20 "enter"
; wanted: 21
; given: 42 10 20 "button-down"
; wanted: 10
; given: 42 10 20 "move"
; wanted: 42
(define (hyper x-position-of-car x-mouse y-mouse me)
  (cond
    [(string=? me "button-down") x-mouse]
    [else x-position-of-car]))


; AnimationState -> AnimationState
; launches the program from some initial state
(define (main anim-state)
  (big-bang anim-state
            [on-tick tock]
            [on-mouse hyper]
            [to-draw render]
            [stop-when last-state]))

(main 1)

(check-expect (hyper 42 10 20 "button-down") 10)
(check-expect (hyper 21 10 20 "enter") 21)
(check-expect (hyper 42 10 20 "move") 42)

