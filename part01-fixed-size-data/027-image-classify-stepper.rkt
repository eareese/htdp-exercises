#lang htdp/bsl

(define (image-classify img)
  (cond
    [(>= (image-height img) (image-width img)) "tall"]
    [(= (image-height img) (image-width img)) "square"]
    [(<= (image-height img) (image-width img)) "wide"]))

#| use the stepper |#
(image-classify (circle 3 "solid" "red"))

#| does stepping show how to fix this? |#
