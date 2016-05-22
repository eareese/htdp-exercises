#lang htdp/bsl
(require 2htdp/image)
(require 2htdp/universe)

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
; adds 1 to anim-state
; example:
; given: 20, expect 21
; given: 4003, expect 4004
(define (tock anim-state)
  (+ anim-state 1))

; end?
; AnimationState -> boolean
; delivers world ending condition. in this case, when the car
; has gone off the edge of the BACKGROUND.
; example:
; given: 35, expect #f
; given: 500, expect #t
(define (last-state anim-state)
  (>= anim-state 500))


; AnimationState -> AnimationState
; launches the program from some initial state
(define (main anim-state)
  (big-bang anim-state
            [on-tick tock]
            [to-draw render]
            [stop-when last-state]))

(main 100)

(check-expect
 (render 50) (place-image/align CAR
                               50
                               Y-CAR
                               "right"
                               "center"
                               BACKGROUND))

