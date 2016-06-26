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

(place-image ROCKET ROCKET-X HEIGHT BACKG)
(place-image ROCKET ROCKET-X 0 BACKG)
(place-image ROCKET ROCKET-X 87 BACKG)

(place-image ROCKET ROCKET-X (- HEIGHT ROCKET-CENTER) BACKG)
