#lang htdp/bsl
(require 2htdp/image)
(require 2htdp/universe)

; guage-prog
; display and maintain "happiness guage"

(define WORLD-HEIGHT 200)
(define WORLD-WIDTH 200)

(define BACKGROUND
  (rectangle WORLD-WIDTH WORLD-HEIGHT "outline" "black"))


; data definition
; WorldState is represented by a Number for "happiness score"


; WorldState -> Image
; gauge display starts with max score, and on each clock tick it decreases by -0.1
; display
; scene with solid rectangle and balck frame
; lvl 0: blue bar none
; lvl max: bar goes all the way across scene
(define (render ws)
  (place-image/align
   (rectangle WORLD-WIDTH ws "solid" "blue")
   (/ WORLD-WIDTH 2)
   WORLD-HEIGHT
   "center"
   "bottom"
   BACKGROUND))

; WorldState -> WorldState
; happiness score falls by 0.1 each clock tick
; minimum score is 0
(define (tock ws)
  (cond
    [(< ws 1) 0]
    [else (min (- ws 0.1) WORLD-HEIGHT)]))


; event handler
; WorldState ke -> WorldState
; down arrow keyp
; hap inc by 1/5
; up arrow
; hap up by 1/3
(define (hyper ws ke)
  (cond
    [(string=? "down" ke) (min WORLD-HEIGHT (* 1.2 ws))]
    [(string=? "up" ke) (min WORLD-HEIGHT (* 1.3333 ws))]))


; main
; inital state
; WorldState -> WorldState
; give the number for 100% full happiness score
(define (main ws)
  (big-bang ws
            [on-tick tock]
            [to-draw render]
            [on-key hyper]))

(main 1000)


;(check-expect)
