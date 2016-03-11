#lang htdp/bsl
(require 2htdp/image)

; exercise 7. use picture primitives to draw a simple boat

(define ocean (rectangle 200 85 "solid" "blue"))

; Resourceful Raft
(define boat (rectangle 100 20 "solid" "brown"))

(place-image (overlay/offset boat 0 41 ocean)
             100 158
             (empty-scene 200 200))




