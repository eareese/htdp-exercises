#lang htdp/bsl
(require 2htdp/image)
(require 2htdp/universe)

;; Design a game program using the 2htdp/universe library for playing a simple
;; space invader game. The player is in control of a tank (a small rectangle)
;; that must defend our planet (the bottom of the canvas) from a UFO (see
;; Intervals for one possibility) that descends from the top of the canvas to
;; the bottom. In order to stop the UFO from landing, the player may fire a
;; single missile (a triangle smaller than the tank) by hitting the space bar.
;; In response, the missile emerges from the tank. If the UFO collides with the
;; missile, the player wins; otherwise the UFO lands and the player loses.

;; Here are some details concerning the three game objects and their movements.
;; First, the tank moves a constant speed along the bottom of the canvas though
;; the player may use the left arrow key and the right arrow key to change
;; directions. Second, the UFO descends at a constant velocity but makes small
;; random jumps to the left or right. Third, once fired the missile ascends
;; along a straight vertical line at a constant speed at least twice as fast as
;; the UFO descends. Finally, the UFO and the missile collide if their reference
;; points are close enough, for whatever you think “close enough” means.


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
     (tank-render (fired-tank s)
                  (ufo-render (fired-ufo s)
                              (missile-render (fired-missile s) BACKGROUND)))]))


; SIGS -> Boolean
; si-game-over?
; stop the game if the UFO lands or if the missile hits the ufo
; land condition: ufo's y becomes scene height
; missile cond: and (missile x is close to ufo x) (missle y close to ufo y)
; what is close to? something to do with their width/size?


;; INITIAL SCENE
(place-images
 (list UFO TANK)
 (list (make-posn (* 1/2 (image-width BACKGROUND)) (image-height UFO))
       (make-posn (* 1/2 (image-width BACKGROUND)) TANK-Y))
 BACKGROUND)
