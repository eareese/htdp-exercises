#lang htdp/bsl
(require 2htdp/image)
(require 2htdp/universe)

; display constants
(define TL-GREEN (bitmap "images/tl-green.png"))
(define TL-RED (bitmap "images/tl-red.png"))
(define TL-YELLOW (bitmap "images/tl-yellow.png"))

; so, i think the string representation of tl-next conveyed its intention most clearly.
; the tests and code were easier to write and verify because we are making images after
; all, and it's helpful to be able to visually map the traffic light states.

; a N-TrafficLight shows one of three colors:
; - 0
; - 1
; - 2
; interpretation 0 means the tl shows red, 1 green, and 2 yellow
; N-TrafficLight -> N-TrafficLight
(check-expect (tl-next-numeric 0) 1)
(check-expect (tl-next-numeric 1) 2)
(check-expect (tl-next-numeric 2) 0)
(define (tl-next-numeric current-state)
  (modulo (+ current-state 1) 3))

; render
; N-TrafficLight -> Image
(check-expect (tl-render 0) (bitmap "images/tl-red.png"))
(check-expect (tl-render 1) (bitmap "images/tl-green.png"))
(check-expect (tl-render 2) (bitmap "images/tl-yellow.png"))
(define (tl-render current-state)
  (cond
    [(= current-state 0) TL-RED]
    [(= current-state 1) TL-GREEN]
    [(= current-state 2) TL-YELLOW]))

; N-TrafficLight -> N-TrafficLight
; simulates a traffic light that changes with each clock tick
(define (traffic-light-simulation initial-state)
  (big-bang initial-state
            [to-draw tl-render]
            [on-tick tl-next-numeric 1]))
