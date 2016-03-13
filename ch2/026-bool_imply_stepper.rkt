#lang htdp/bsl

#| use the stepper |#
(define (bool-imply x y)
  (or (not x) y))
