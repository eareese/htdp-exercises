#lang htdp/bsl
(require 2htdp/universe)
(require 2htdp/image)

(define (main y)
  (big-bang y
            [on-tick sub1]
            [stop-when zero?]
            [to-draw place-dot-at]
            [on-key stop]))

(define (place-dot-at y)
  (place-image (circle 3 "solid" "blue") 50 y (empty-scene 100 100)))

(define (stop y ke)
  0)

(main 90)
