;;---------------------------------------------------------------------------------------------------
#lang htdp/bsl
(require 2htdp/image)
(require 2htdp/universe)

;; Exercise 227. The BW Machine is a FSM that flips from black to white and back to black for every
;; key event. Formulate a data representation for the BW Machine.

; BWState is one of:
; - "black"
; - "white"
; interpretation A FSM represents whether a white or black background is shown.


; A SimulationState is a BWState.

; BWState -> Image
; renders a world state as an image
(check-expect (state-as-colored-square "black")
              (square 100 "solid" "black"))
(check-expect (state-as-colored-square "white")
              (square 100 "solid" "white"))
(define (state-as-colored-square a-fs)
  (square 100 "solid" a-fs))

; SimulationState -> SimulationState
; finds the next state given current state
(check-expect (find-next-state "white" "x") "black")
(check-expect (find-next-state "black" "a") "white")
(define (find-next-state cs ke)
  (if (string=? cs "black") "white" "black"))

; FSM-State -> SimulationState
; match the keys pressed with the given FSM
(define (simulate s0)
  (big-bang s0
            [to-draw state-as-colored-square]
            [on-key find-next-state]))

(simulate "white")
