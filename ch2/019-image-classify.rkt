#lang htdp/bsl
(require 2htdp/image)

(define wide-thing (rectangle 100 25 "solid" "blue"))
(define tall-thing (rectangle 25 100 "solid" "blue"))
(define square-thing (square 50 "solid" "blue"))

(define cat (bitmap "images/cat.png"))

(define (image-classify image)
  (if (<= (image-width image) (image-height image))
      ; w = h -> square
      ; w < h -> tall
      (if (= (image-width image) (image-height image))
          "square"
          "tall")
      ; w > h -> wide
      "wide"))

(check-expect (image-classify wide-thing) "wide")
(check-expect (image-classify tall-thing) "tall")
(check-expect (image-classify square-thing) "square")
(check-expect (image-classify cat) "tall")
