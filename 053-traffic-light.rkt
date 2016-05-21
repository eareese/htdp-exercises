#lang htdp/bsl
(require 2htdp/image)
(require 2htdp/universe)

(define LIGHT-SIZE 50)
(define BACKGROUND (rectangle 200 200 "outline" "black"))

; TrafficLight is a String
; TrafficLight shows one of three colors:
; - "red"
; - "green"
; - "yellow"
; interpretation each element of TrafficLight represents which
; color of bulb is currently turned on.


; tock
; TrafficLight -> TrafficLight
; determines the next state of the traffic light from the given str
(check-expect (traffic-light-next "red") "green")
(define (traffic-light-next str)
  (cond
    [(string=? "red" str) "green"]
    [(string=? "green" str) "yellow"]
    [(string=? "yellow" str) "red"]))

; render
; TrafficLight -> Image
(define (render str)
  (place-image
   (circle LIGHT-SIZE "solid" str)
   (/ (image-width BACKGROUND) 2)
   (/ (image-height BACKGROUND) 2)
   BACKGROUND))

; main
(define (main ws rate)
  (big-bang ws
            [on-tick traffic-light-next rate]
            [to-draw render]))

(main "green" 3)
