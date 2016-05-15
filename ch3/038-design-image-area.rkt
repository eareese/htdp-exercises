#lang htdp/bsl
(require 2htdp/image)

; Exercise 38. Design the function image-area, which counts the number of
; pixels in a given image.

; 1. how to represent info as data?
; an image is an image. the image area is a number.

; 2. signature, purpose statement, function header
; Image -> Number
; compute the number of pixels in a given image
; (define (image-area img) 3600)

; 3. functional examples
; Image -> Number
; compute the number of pixels in a given image
; given: (square 10 "solid" "blue"); expect: 100
; given: (rect 10 20 "solid" "blue"); expect: 200
; (define (image-area img) 3600)

; 4. take inventory
; Image -> Number
; compute the number of pixels in a given image
; given: (square 10 "solid" "blue"); expect: 100
; given: (rect 10 20 "solid" "blue"); expect: 200
; (define (image-area img)
;   (* (image-width img) (image-height img))

; 5. code
(define (image-area img)
  (* (image-width img) (image-height img)))

; 6. test
(define shape-to-test (rectangle 60 7 "solid" "blue"))
(image-area shape-to-test)

(check-expect (image-area shape-to-test) 420)
