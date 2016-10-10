#lang htdp/bsl
(require 2htdp/image)
(require 2htdp/universe)

(define cat (bitmap "images/cat.png"))

;; Define a structure type that keeps track of the cat’s x-coordinate and its
;; happiness. Then formulate a data definition for cats, dubbed VCat, including
;; an interpretation with respect to a combined world.

(define-struct cat [x hap])
; Cat = (make-cat Number Number)
; ex: (make-cat 10 1)
; interpretation (make-cat x n) describes a Cat that is at x-position 'x' and
; has happiness level 'n'.

; VCat
; interpretation The world state of a cat, represented by Cat values to denote
; the cat's position along x-axis and its happiness level. Both position and
; happiness level change on every clock tick.
