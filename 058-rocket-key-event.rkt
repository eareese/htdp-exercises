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
(define ROCKET-X 10)

; LRCD -> Image
; renders the state as a resting or flying rocket
; NOTE: there is a test per subclass in the data definition.
(check-expect (show "resting")
 (place-image ROCKET
              ROCKET-X (- HEIGHT ROCKET-CENTER)
              BACKG))
(check-expect (show 0)
              (place-image ROCKET ROCKET-X (- 0 ROCKET-CENTER) BACKG))
(check-expect (show -2)
 (place-image (text "-2" 20 "red")
              ROCKET-X (* 3/4 HEIGHT)
              (place-image ROCKET
                           ROCKET-X (- HEIGHT ROCKET-CENTER)
                           BACKG)))
(check-expect (show 53)
 (place-image ROCKET ROCKET-X (- 53 ROCKET-CENTER) BACKG))

(check-expect
 (show HEIGHT)
 (place-image ROCKET ROCKET-X (- HEIGHT ROCKET-CENTER) BACKG))
(define (show x)
  (cond
    ; NOTE: string?  would be incorrect here because we don't care
    ; about dealing with any string except the indicator "resting"
    ; want "a Boolean expression that evaluates to #true precisely
    ; when x belongs to the first subclass of LRCD."
    [(and (string? x) (string=? x "resting")) (place-image ROCKET ROCKET-X (- HEIGHT ROCKET-CENTER) BACKG)]
    [(<= -3 x -1)
     (place-image (text (number->string x) 20 "red")
                  ROCKET-X (* 3/4 HEIGHT)
                  (draw-rocket HEIGHT))]
    [(>= x 0)
     (draw-rocket x)]))

; LRCD KeyEvent -> LRCD
; starts the countdown when spacebar is pressed,
; if the rocket is still resting
; ke about resting state
(check-expect (launch "resting" " ") -3)
(check-expect (launch "resting" "a") "resting")
; ke about countdown state
(check-expect (launch -3 " ") -3)
(check-expect (launch -1 " ") -1)
; ke about in-flight rocket
(check-expect (launch 33 " ") 33)
(check-expect (launch 33 "a") 33)
(define (launch x ke)
  (cond
    [(string? x) (if (string=? ke " ") -3 x)]
    [(<= -3 x -1) x]
    [(>= x 0) x]))

; LRCD -> LRCD
; raises the rocket by YDELTA, if it is moving already
(check-expect (fly "resting") "resting")
(check-expect (fly -3) -2)
(check-expect (fly -2) -1)
(check-expect (fly -1) HEIGHT)
(check-expect (fly 10) (- 10 YDELTA))
(check-expect (fly 22) (- 22 YDELTA))
(define (fly x)
  (cond
    [(string? x) x]
    [(<= -3 x -1) (if (= x -1) HEIGHT (+ x 1))]
    [(> x 0) (- x YDELTA)]))

; LRCD -> Image
; draws the rocket resting or in flight
(check-expect (draw-rocket 17)
              (place-image ROCKET ROCKET-X (- 17 ROCKET-CENTER) BACKG))
(define (draw-rocket x)
  (place-image ROCKET ROCKET-X (- x ROCKET-CENTER) BACKG))


; LRCD -> Boolean
; stop and reset when the rocket leaves the top of world
(define (gone s)
  (cond
    [(and (number? s)
          (= s 0)) #t]
    [else #f]))

; LRCD -> LRCD
(define (main1 s)
  (big-bang s
            [to-draw show]
            [on-key launch]))
(define (main2 s)
  (big-bang s
            [to-draw show]
            [on-tick fly 0.1]
            [stop-when gone]
            [close-on-stop #t]
            [on-key launch]))

(main2 "resting")
