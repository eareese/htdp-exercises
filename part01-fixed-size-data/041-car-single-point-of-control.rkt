#lang htdp/bsl
(require 2htdp/image)
(require 2htdp/universe)

(define WIDTH-OF-WORLD 200)
(define HEIGHT-OF-WORLD 200)
(define BACKGROUND (rectangle
                    WIDTH-OF-WORLD
                    HEIGHT-OF-WORLD
                    "outline"
                    "black"))
(define Y-CAR (/ HEIGHT-OF-WORLD 2))

; WHEEL-RADIUS is the single point of control for the size of CAR
(define WHEEL-RADIUS 10)

(define WHEEL-DISTANCE (* WHEEL-RADIUS 5))

(define WHEEL (circle WHEEL-RADIUS "solid" "black"))
(define SPACE (rectangle WHEEL-DISTANCE WHEEL-RADIUS
                         "solid" "transparent"))
(define BOTH-WHEELS (beside WHEEL SPACE WHEEL))

(define CAR-BODY (overlay/align "middle" "bottom"
                                (rectangle
                                 (* 6 WHEEL-RADIUS)
                                 (* 4 WHEEL-RADIUS)
                                 "solid" "blue")
                                (rectangle
                                 (* 12 WHEEL-RADIUS)
                                 (* 2 WHEEL-RADIUS)
                                 "solid" "blue")))

(define CAR (above CAR-BODY BOTH-WHEELS))

; WorldState is a Number
; interpretation number of pixels between left border and the car

; clock-tick-handler
; key-stroke-handler
; mouse-event-handler

; end?

; WorldState -> Image
; places the image of the car x pixels from the left margin of
; the BACKGROUND image
(define (render x)
  (place-image CAR x Y-CAR BACKGROUND))

; WorldState -> WorldState
; adds 3 to x to move the car right
; example:
; given: 20, expect 23
; given: 78, expect 81
(define (tock ws)
  (+ ws 3))

; WorldState -> WorldState
; launches the program from some initial state
(define (main ws)
  (big-bang ws
            [on-tick tock]
            [to-draw render]))

(main 13)

(check-expect (render 50) (place-image CAR 50 Y-CAR BACKGROUND))
(check-expect (render 200) (place-image CAR 200 Y-CAR BACKGROUND))
