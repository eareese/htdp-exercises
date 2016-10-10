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

; WorldState is a Number
; interpretation number of pixels between left border and the car

; key-stroke-handler
; mouse-event-handler

; WorldState -> Image
; places the image of the car x pixels from the left margin of
; the BACKGROUND image
(define (render x)
  (place-image/align CAR
                     x
                     Y-CAR
                     "right"
                     "center"
                     BACKGROUND))

; clock-tick-handler
; WorldState -> WorldState
; adds 3 to ws to move the car right
; example:
; given: 20, expect 23
; given: 78, expect 81
(define (tock ws)
  (+ ws 3))

; end?
; WorldState -> boolean
; delivers world ending condition. in this case, when the car
; has gone off the edge of the BACKGROUND.
; example:
; given: 35, expect #f
; given: 500, expect #t
(define (last-world ws)
  (>= ws 500))


; WorldState -> WorldState
; launches the program from some initial state
(define (main ws)
  (big-bang ws
            [on-tick tock]
            [to-draw render]
            [stop-when last-world]))

(main 100)

(check-expect (render 50) (place-image CAR 50 Y-CAR BACKGROUND))
(check-expect (render 200) (place-image CAR 200 Y-CAR BACKGROUND))

