#lang htdp/bsl
(require 2htdp/image)

(define cat (bitmap "images/cat.png"))

; compute area in pixels of cat image
(* (image-height cat) (image-width cat))
