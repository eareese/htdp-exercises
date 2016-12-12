#lang htdp/bsl
(require 2htdp/image)

;; Exercise 152. Design two functions: col and row.

;; The function col consumes a natural number n and an image img. It produces a column—a vertical arrangement—of n copies of img.

;; The function row consumes a natural number n and an image img. It produces a row—a horizontal arrangement—of n copies of img.

(define CIR (circle 20 "solid" "blue"))

; N Image -> Image
; takes a natural number n and an image img, produces a column
(check-expect (column 3 CIR) (above CIR CIR CIR))
(define (column n img)
  (cond
    [(<= n 1) img]
    [else (above img (column (sub1 n) img))]))

; N Image -> Image
; takes a natural number n and an image img, produces a row
(check-expect (row 3 CIR) (beside CIR CIR CIR))
(define (row n img)
  (cond
    [(<= n 1) img]
    [else (beside img (row (sub1 n) img))]))
