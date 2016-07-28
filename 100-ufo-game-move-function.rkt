#lang htdp/bsl
(require 2htdp/image)
(require 2htdp/universe)

;; Exercise 100. Design the function si-move, which is called for every clock
;; tick. Accordingly it consumes an element of SIGS and produces another one.
;; Its purposes is to move all objects according to their velocity.


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

(define UFO
  (overlay (circle 4 "solid" "green")
           (rectangle 20 2 "solid" "green")))
(define UFO-DELTA-Y 2)
(define UFO-DELTA-X 5)

(define TANK (rectangle 30 15 "solid" "blue"))
(define TANK-Y (- (image-height BACKGROUND) (* 3/5 (image-height TANK))))
(define TANK-DELTA-X 3)

(define MISSILE (triangle 7 "solid" "red"))



; si-move
; SIGS -> SIGS
; consumes a SIGS and produces another SIGS where all the objects have moved,
; each in their own unique ways, after one clock tick
(define (si-move w)
  (si-move-proper w (create-random-number w)))

; SIGS Number -> SIGS
; do the moving on all objects, given prior SIGS and random number for ufo jump
(check-expect (si-move-proper (make-aim (make-posn 50 25)
                                        (make-tank 50 (- TANK-DELTA-X)))
                              3)
              (make-aim (make-posn 53 (+ 25 UFO-DELTA-Y))
                        (make-tank (+ 50 (- TANK-DELTA-X)) (- TANK-DELTA-X))))
(check-expect (si-move-proper (make-fired
                               (make-posn 50 25)
                               (make-tank 50 -3)
                               (make-posn 50 100))
                              4)
              (make-fired
               (make-posn 54 (+ 25 UFO-DELTA-Y))
               (make-tank 47 (- TANK-DELTA-X))
               (make-posn 50 (- (* 2 UFO-DELTA-Y) 100))))
(define (si-move-proper w n)
  (cond [(aim? w) (make-aim (make-posn
                             (+ n (posn-x (aim-ufo w)))
                             (+ UFO-DELTA-Y (posn-y (aim-ufo w))))
                            (make-tank
                             (+ (tank-vel (aim-tank w)) (tank-loc (aim-tank w)))
                             (tank-vel (aim-tank w))))]
        [else (make-fired
               (make-posn (+ n (posn-x (fired-ufo w)))
                          (+ UFO-DELTA-Y (posn-y (fired-ufo w))))
               (make-tank (+ (tank-vel (fired-tank w)) (tank-loc (fired-tank w)))
                          (tank-vel (fired-tank w)))
               (make-posn (posn-x (fired-missile w))
                          (- (* 2 UFO-DELTA-Y) (posn-y (fired-missile w)))))]))

; SIGS -> Number
; create a random number in case a UFO should perform jump
(check-random (create-random-number (make-aim (make-posn 45 67)
                                              (make-tank 54 76)))
              (random UFO-DELTA-X))
(define (create-random-number w)
  (random UFO-DELTA-X) )

; random
; N -> N
; produces a number in [0,n), possibly a different one
;  each time the function is called
;; (define (random n) ...)
