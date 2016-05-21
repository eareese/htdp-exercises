#lang htdp/bsl
(require 2htdp/image)
(require 2htdp/universe)

; a LRCD (short for: launching rocket count down) is one of:
; - "resting"
; - a number in [-3,-1]
; - non-negative number
; interpretation a rocket resting on the ground, in countdown mode,
; or the number of pixels from the top i.e. its height

; physical constants
(define HEIGHT 300)
(define WIDTH 100)
(define YDELTA 3)

; graphical constants
(define BACKG  (empty-scene WIDTH HEIGHT))
(define ROCKET (rectangle 5 30 "solid" "blue"))
(define ROCKET-CENTER (/ (image-height ROCKET) 2))

; LRCD -> Image
; renders the state as a resting or flying rocket
; NOTE: there is a test per subclass in the data definition.
(check-expect
 (show "resting")
 (place-image ROCKET
              10 (- HEIGHT ROCKET-CENTER)
              BACKG))
(check-expect
 (show -2)
 (place-image (text "-2" 20 "red")
              10 (* 3/4 HEIGHT)
              (place-image ROCKET
                           10 (- HEIGHT ROCKET-CENTER)
                           BACKG)))
(check-expect
 (show 53)
 (place-image ROCKET 10 (- 53 ROCKET-CENTER) BACKG))

(check-expect
 (show HEIGHT)
 (place-image ROCKET 10 (- HEIGHT ROCKET-CENTER) BACKG))
(define (show x)
  (cond
    ; NOTE: string?  would be incorrect here because we don't care
    ; about dealing with any string except the indicator "resting"
    ; want "a Boolean expression that evaluates to #true precisely
    ; when x belongs to the first subclass of LRCD."
    [(and (string? x) (string=? x "resting")) (place-image ROCKET 10 (- HEIGHT ROCKET-CENTER) BACKG)]
    [(<= -3 x -1)
     (place-image (text (number->string x) 20 "red")
                  10 (* 3/4 HEIGHT)
                  (place-image
                   ROCKET
                   10 (- HEIGHT ROCKET-CENTER)
                   BACKG))]
    [(>= x 0)
     (place-image ROCKET
                  10 (- x ROCKET-CENTER)
                  BACKG)]))

; LRCD KeyEvent -> LRCD
; starts the countdown when spacebar is pressed,
; if the rocket is still resting
(define (launch x ke)
  x)

; LRCD -> LRCD
; raises the rocket by YDELTA, if it is moving already
(define (fly x)
  x)

