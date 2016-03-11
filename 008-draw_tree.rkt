#lang htdp/bsl
(require 2htdp/image)

; exercise 8. draw a tree

(define trunk (rectangle 15 85 "solid" "brown"))

(define leaves (circle 55 "solid" "green"))

(place-image (overlay/offset leaves 0 41 trunk)
             100 100
             (empty-scene 200 200))




