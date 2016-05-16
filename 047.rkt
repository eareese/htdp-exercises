#lang htdp/bsl
(require 2htdp/image)
(require 2htdp/universe)
(define cat (bitmap "images/cat.png"))
(define cat2 (bitmap "images/cat2.png"))

(define CAT-Y 250)

(define HEIGHT-OF-WORLD
  (* 3 (image-height cat)))
(define WIDTH-OF-WORLD
  (* 10 (image-width cat)))

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
   cat
   (modulo ws WIDTH-OF-WORLD)
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
