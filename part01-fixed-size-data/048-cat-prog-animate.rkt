#lang htdp/bsl
(require 2htdp/image)
(require 2htdp/universe)

(define cat1 (bitmap "../images/cat1.png"))
(define cat2 (bitmap "../images/cat2.png"))

(define CAT-Y 250)

(define HEIGHT-OF-WORLD
  (* 3 (image-height cat1)))
(define WIDTH-OF-WORLD
  (* 10 (image-width cat1)))

(define BACKGROUND
  (rectangle
   WIDTH-OF-WORLD
   HEIGHT-OF-WORLD
   "outline"
   "black"))

; WorldState is a Number
; interpretation the number of ticks since the world began

; WorldState -> Image
; places the cat in the world
; expect movement from left to right
; expect it to appear back on the left after it goes to right edge
; expect it on the BACKGROUND
(define (render ws)
  (place-image
   (cond [(odd? ws) cat1]
         [else cat2])
   (modulo (* 3 ws) WIDTH-OF-WORLD)
   CAT-Y
   BACKGROUND))

; WorldState -> WorldState
; increments x to move the cat right
(define (tock x)
  (+ x 1))

; WorldState -> WorldState
; launches the program from some initial state
(define (main ws)
  (big-bang ws
            [on-tick tock]
            [to-draw render]))

(main 13)

(check-expect (render 13) (place-image cat1 (* 3 13) CAT-Y BACKGROUND))
