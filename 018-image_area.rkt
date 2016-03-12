#lang htdp/bsl
(require 2htdp/image)

(define (image-area img)
  (* (image-height img) (image-width img)))

(check-expect (image-area (square 20 "solid" "blue")) 400)
