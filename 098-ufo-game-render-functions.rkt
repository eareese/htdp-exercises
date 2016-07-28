#lang htdp/bsl
(require 2htdp/image)
(require 2htdp/universe)

;; Exercise 98. Design the functions tank-render, ufo-render, and
;; missile-render. Is the result of this expression
;
;; ... (tank-render (fired-tank s)
;;                  (ufo-render (fired-ufo s)
;;                              (missile-render (fired-missile s)
;;                                              BACKGROUND))) ...
;
;; the same as the result of
;
;; ... (ufo-render (fired-ufo s)
;;                 (tank-render (fired-tank s)
;;                              (missile-render (fired-missile s)
;;                                              BACKGROUND))) ...
;
;; When do the two expressions produce the same result?


;; Structure type definitions

;; the time period when the player is trying to get the tank in position for a shot
(define-struct aim [ufo tank])

;; represents states after the missile is fired
(define-struct fired [ufo tank missile])

; A UFO is Posn.
; interpretation (make-posn x y) is the UFO's current location

(define-struct tank [loc vel])
; A Tank is (make-tank Number Number).
; interpretation (make-tank x dx) means the tank is at position
; (x, TANK-Y) and that it moves dx pixels per clock tick

; A Missile is Posn.
; interpretation (make-posn x y) is the missile's current location

; A SIGS is one of:
; – (make-aim UFO Tank)
; – (make-fired UFO Tank Missile)
; interpretation represents the state of the space invader game

;; constants
;; canvas
(define BACKGROUND
  (scene+curve
   (scene+curve
    (rectangle 200 200 "outline" "black")
    0 195 10 1/2
    100 195 10 1/3
    "purple")
   100 195 10 1/2
   200 195 10 1/3
   "purple"))

(define TANK (rectangle 30 15 "solid" "blue"))
(define TANK-Y (- (image-height BACKGROUND) (* 3/5 (image-height TANK))))

(define MISSILE (triangle 7 "solid" "red"))

(define UFO
  (overlay (circle 4 "solid" "green")
           (rectangle 20 2 "solid" "green")))


; Tank Image -> Image
; adds t to the given image img
(check-expect (tank-render (make-tank 20 3) BACKGROUND)
              (place-image TANK 20 TANK-Y BACKGROUND))
(define (tank-render t img)
  (place-image TANK (tank-loc t) TANK-Y img))

; UFO Image -> Image
; adds u to the given image img
(check-expect (ufo-render (make-posn 66 33) BACKGROUND)
              (place-image UFO 66 33 BACKGROUND))
(define (ufo-render u img)
  (place-image UFO (posn-x u) (posn-y u) img))

; Missile Image -> Image
; adds m to the given image img
(check-expect (missile-render (make-posn 100 100) BACKGROUND)
              (place-image MISSILE 100 100 BACKGROUND))
(define (missile-render m img)
  (place-image MISSILE (posn-x m) (posn-y m) img))

; SIGS -> Image
; adds TANK, UFO, and possibly the MISSILE to BACKGROUND
(define (si-render s)
  (cond
    [(aim? s)
     (tank-render (aim-tank s)
                  (ufo-render (aim-ufo s) BACKGROUND))]
    [(fired? s)
     ;; (ufo-render (fired-ufo s)
     ;;             (tank-render (fired-tank s)
     ;;                          (missile-render (fired-missile s)
     ;;                                          BACKGROUND)))]))
     (tank-render (fired-tank s)
                  (ufo-render (fired-ufo s)
                              (missile-render (fired-missile s) BACKGROUND)))]))
; the commented expression will produce the same result unless the ufo has a
; position such that it overlaps with the tank. in the commented expression, the
; ufo would overlap the tank.

