#lang htdp/bsl

(define (cube-volume side)
  (* (* side side) side))

(define (cube-surface side)
  (* (* side side) 6))

(check-expect (cube-volume 3) 27)
(check-expect (cube-volume 1) 1)

(check-expect (cube-surface 1) 6)
