#lang htdp/bsl
(require 2htdp/image)

; exercise 6. use picture primitives to draw a simple automobile

(define wheels (overlay/offset (circle 13 "solid" "blue")
                75 0
                (circle 13 "solid" "blue")))

(define cabin (overlay/offset
               (flip-horizontal (rotate 67 (rhombus 50 45 "solid" "gold")))
               35 0
               (rotate 67 (rhombus 50 45 "solid" "gold"))))

(define body (overlay/offset
              (rectangle 129 25 "solid" "gold")
              5 -15
              cabin))

(define carpic (overlay/offset
                body
                0 25
                wheels))

(place-image carpic
             100 100
             (empty-scene 200 200))




