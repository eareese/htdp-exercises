#lang htdp/bsl
(require 2htdp/image)

; physical constants
(define HEIGHT 300)
(define WIDTH 100)
(define YDELTA 3)

; graphical constants
(define BACKG  (empty-scene WIDTH HEIGHT))
(define ROCKET (rectangle 5 30 "solid" "blue"))
(define ROCKET-CENTER (/ (image-height ROCKET) 2))
(define ROCKET-X 10)

; given 0, rocket should be on the ground
(place-image ROCKET ROCKET-X (- (- HEIGHT 0) ROCKET-CENTER) BACKG)

; given 33, rocket should be a lil up from the ground
(place-image ROCKET ROCKET-X (- (- HEIGHT 33) ROCKET-CENTER) BACKG)
