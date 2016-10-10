#lang htdp/bsl
(require 2htdp/image)
(require 2htdp/universe)

; TODO there are so many improvements to make, but this is at a good point. Demoable!

;; Sample Problem
;; Design a game program using the 2htdp/universe library for playing a simple space invader game. The player is in control of a tank (a small rectangle) that must defend our planet (the bottom of the canvas) from a UFO (see Intervals for one possibility) that descends from the top of the canvas to the bottom. In order to stop the UFO from landing, the player may fire a single missile (a triangle smaller than the tank) by hitting the space bar. In response, the missile emerges from the tank. If the UFO collides with the missile, the player wins; otherwise the UFO lands and the player loses.

;; Here are some details concerning the three game objects and their movements. First, the tank moves a constant speed along the bottom of the canvas though the player may use the left arrow key and the right arrow key to change directions. Second, the UFO descends at a constant velocity but makes small random jumps to the left or right. Third, once fired the missile ascends along a straight vertical line at a constant speed at least twice as fast as the UFO descends. Finally, the UFO and the missile collide if their reference points are close enough, for whatever you think “close enough” means.

;; constants
;; canvas
(define CANVAS
  (scene+curve
   (scene+curve
    (rectangle 200 200 "outline" "black")
    0 195 10 1/2
    100 195 10 1/3
    "purple")
   100 195 10 1/2
   200 195 10 1/3
   "purple"))
(define HEIGHT (image-height CANVAS))

(define TANK (rectangle 30 15 "solid" "blue"))
(define TANK-HEIGHT (image-height TANK))
(define TANK-Y (- (image-height CANVAS) (* 3/5 (image-height TANK))))
(define TANK-DELTA-X 5)

(define UFO
  (overlay (circle 4 "solid" "green")
           (rectangle 20 2 "solid" "green")))
(define UFO-DELTA-Y 1.5)
(define UFO-MAX-DELTA-X 5)

(define MISSILE (triangle 12 "solid" "tan"))
(define MISSILE-Y-OFFSET -10)
(define MISSILE-DELTA-Y (* 2 UFO-DELTA-Y))

;; used by in-reach?
(define REACH 10)

;; Structure type definitions
(define-struct aim [ufo tank])
(define-struct fired [ufo tank missile])
(define-struct tank [loc vel])




; si-move
; SIGS -> SIGS
; consumes a SIGS and produces another SIGS where all the objects have moved,
; each in their own unique ways, after one clock tick
(define (si-move s)
  (si-move-proper s (create-random-number s)))

; si-move-proper
; SIGS Number -> SIGS
; do the moving on all objects, given prior SIGS and random number for ufo jump
(check-expect (si-move-proper (make-aim (make-posn 50 25)
                                        (make-tank 50 (- TANK-DELTA-X)))
                              3)
              (make-aim (make-posn 53 (+ 25 UFO-DELTA-Y))
                        (make-tank (+ 50 (- TANK-DELTA-X)) (- TANK-DELTA-X))))
(check-expect (si-move-proper (make-fired
                               (make-posn 50 25)
                               (make-tank 50 (- TANK-DELTA-X))
                               (make-posn 50 100))
                              4)
              (make-fired
               (make-posn 54 (+ 25 UFO-DELTA-Y))
               (make-tank (- 50 TANK-DELTA-X) (- TANK-DELTA-X))
               (make-posn 50 (- 100 (* 2 UFO-DELTA-Y)))))
(define (si-move-proper s n)
  (if (aim? s)
      (make-aim
       (make-posn (modulo (+ n (posn-x (aim-ufo s))) (image-width CANVAS))
                  (+ UFO-DELTA-Y (posn-y (aim-ufo s))))
       (make-tank (modulo (+ (tank-loc (aim-tank s)) (tank-vel (aim-tank s))) (image-width CANVAS))
                  (tank-vel (aim-tank s))))
      (make-fired
       (make-posn (modulo (+ n (posn-x (fired-ufo s))) (image-width CANVAS))
                  (+ UFO-DELTA-Y (posn-y (fired-ufo s))))
       (make-tank (modulo (+ (tank-loc (fired-tank s)) (tank-vel (fired-tank s))) (image-width CANVAS))
                  (tank-vel (fired-tank s)))
       (make-posn (posn-x (fired-missile s))
                  (- (posn-y (fired-missile s)) MISSILE-DELTA-Y)))))

; SIGS -> Number
; create a random number in case a UFO should perform jump
;; (check-random (create-random-number (make-aim (make-posn 45 67)
;;                                               (make-tank 54 76)))
;;               (random UFO-MAX-DELTA-X))
; NOTE added another call to random so the jump can be positive or negative.
; TODO now I don't know how to write the test using check-random
(define (create-random-number w)
  (if (eq? 0 (random 2))
      (- (random UFO-MAX-DELTA-X)); random jump left for 0
      (random UFO-MAX-DELTA-X))) ; random jump right for 1


; si-game-over?
; SIGS -> Boolean
; checks for one of two stop conditions:
; - when the UFO lands
; - when the missile hits the UFO
(check-expect
 (si-game-over? (make-aim
                 (make-posn 50 (image-height CANVAS))
                 (make-tank 25 3)))
              #t)
(check-expect (si-game-over? (make-aim
                              (make-posn 50 10)
                              (make-tank 25 3)))
              #f)
(define (si-game-over? s)
  (cond
    [(>= (posn-y (if (aim? s)
                     (aim-ufo s)
                     (fired-ufo s)))
         (image-height CANVAS))
     #t] ;; ufo has landed!
    [(and
      (fired? s)
      (in-reach? (fired-ufo s) (fired-missile s)))
     #t] ;; missile hit!
    [else #f]))


; in-reach?
; Posn Posn -> Boolean
; compares the proximity of the two positions using REACH constant, returning #t if they are close enough
(check-expect (in-reach? (make-posn 10 10) (make-posn 100 100)) #f)
(check-expect (in-reach? (make-posn 100 100) (make-posn 100 100)) #t)
(define (in-reach? p1 p2)
  (if (>= REACH
          (sqrt
           (+
            (sqr (- (posn-x p2) (posn-x p1)))
            (sqr (- (posn-y p2) (posn-y p1))))))
      #t #f))

; SIGS -> Image
; adds TANK, UFO, and possibly the MISSILE to BACKGROUND
(define (si-render s)
  (cond
    [(aim? s)
     (tank-render (aim-tank s)
                  (ufo-render (aim-ufo s) CANVAS))]
    [(fired? s)
     (tank-render (fired-tank s)
                  (ufo-render (fired-ufo s)
                              (missile-render (fired-missile s) CANVAS)))]))


; si-render-final
; SIGS -> Image
(check-expect (si-render-final
               (make-aim (make-posn 20 10) (make-tank 28 -3)))
              (overlay
               (text "GAME OVER" 24 "red") CANVAS))
(define (si-render-final w)
  (overlay (text "GAME OVER" 24 "red") CANVAS))


; tank-render
; Tank Image -> Image
; adds t to the given image im
(define (tank-render t im)
  (place-image TANK (tank-loc t) TANK-Y im))
;; (tank-render (make-tank 50 -3) CANVAS)

; ufo-render
; UFO Image -> Image
; adds u to the given image im
(define (ufo-render u im)
  (place-image UFO (posn-x u) (posn-y u) im))
;; (ufo-render (make-posn 50 50) CANVAS)

; missile-render
; Missile Image -> Image
; adds m to the given image im
(define (missile-render m im)
  (place-image MISSILE (posn-x m) (posn-y m) im))



; si-control
; SIGS KeyEvent -> SIGS
; returns a new game state, given a game state and a KeyEvent.
; left: move tank left
; right: move tank right
; space: fires missile if not fired
(check-expect ;; aim, moving right, ke left
 (si-control
  (make-aim (make-posn 50 25)
            (make-tank 50 TANK-DELTA-X))
  "left")
 (make-aim (make-posn 50 25)
           (make-tank 50 (- TANK-DELTA-X))))
(check-expect ;; aim, moving left, ke left
 (si-control
  (make-aim (make-posn 50 25)
            (make-tank 50 (- TANK-DELTA-X)))
  "left")
 (make-aim (make-posn 50 25)
           (make-tank 50 (- TANK-DELTA-X))))
(check-expect ;; aim, moving right, ke right
 (si-control
  (make-aim (make-posn 50 25)
            (make-tank 50 TANK-DELTA-X))
  "right")
 (make-aim (make-posn 50 25)
           (make-tank 50 TANK-DELTA-X)))
(check-expect ;; aim, moving right, ke left
 (si-control
  (make-aim (make-posn 50 25)
            (make-tank 50 TANK-DELTA-X))
  "left")
 (make-aim (make-posn 50 25)
           (make-tank 50 (- TANK-DELTA-X))))
(check-expect ;; aim, ke space
 (si-control
  (make-aim (make-posn 50 25)
            (make-tank 50 TANK-DELTA-X))
  " ")
 (make-fired (make-posn 50 25)
             (make-tank 50 TANK-DELTA-X)
             (make-posn 50 (+ TANK-Y MISSILE-Y-OFFSET))))
(check-expect ;; fired, change right to left
 (si-control
  (make-fired (make-posn 50 25)
              (make-tank 50 TANK-DELTA-X)
              (make-posn 50 100))
  "left")
 (make-fired (make-posn 50 25)
             (make-tank 50 (- TANK-DELTA-X))
             (make-posn 50 100)))
(check-expect ;; fired, left is still left
 (si-control
  (make-fired (make-posn 50 25)
              (make-tank 50 (- TANK-DELTA-X))
              (make-posn 50 100))
  "left")
 (make-fired (make-posn 50 25)
             (make-tank 50 (- TANK-DELTA-X))
             (make-posn 50 100)))
(check-expect ;; fired, change left to right
 (si-control
  (make-fired (make-posn 50 25)
              (make-tank 50 (- TANK-DELTA-X))
              (make-posn 50 100))
  "right")
 (make-fired (make-posn 50 25)
             (make-tank 50 TANK-DELTA-X)
             (make-posn 50 100)))
(check-expect ;; fired, right is still right
 (si-control
  (make-fired (make-posn 50 25)
              (make-tank 50 TANK-DELTA-X)
              (make-posn 50 100))
  "right")
 (make-fired (make-posn 50 25)
             (make-tank 50 TANK-DELTA-X)
             (make-posn 50 100)))
(check-expect ;; fired, space does nothing
 (si-control
  (make-fired (make-posn 50 25)
              (make-tank 50 TANK-DELTA-X)
              (make-posn 50 100))
  " ")
 (make-fired (make-posn 50 25)
             (make-tank 50 TANK-DELTA-X)
             (make-posn 50 100)))
(check-expect ;; fired, garbage ke
 (si-control
  (make-fired (make-posn 50 25)
              (make-tank 50 TANK-DELTA-X)
              (make-posn 50 100))
  "x")
 (make-fired (make-posn 50 25)
             (make-tank 50 TANK-DELTA-X)
             (make-posn 50 100)))
(define (si-control s ke)
  (if (aim? s)
      (if (string=? ke " ")
          ; aim + space => fired missile
          (make-fired (make-posn (posn-x (aim-ufo s)) (posn-y (aim-ufo s)))
                      (make-tank (tank-loc (aim-tank s))
                                 (tank-vel (aim-tank s)))
                      ; missile initial posn
                      (make-posn (tank-loc (aim-tank s)) (+ TANK-Y MISSILE-Y-OFFSET)))
          ; regular aim state controls
          (make-aim (make-posn (posn-x (aim-ufo s)) (posn-y (aim-ufo s)))
                    (make-tank (tank-loc (aim-tank s))
                               (cond [(string=? ke "left") (- TANK-DELTA-X)]
                                     [(string=? ke "right") TANK-DELTA-X]
                                     [else (tank-vel (aim-tank s))]))))
      ; regular fired state controls
      (make-fired (make-posn (posn-x (fired-ufo s)) (posn-y (fired-ufo s)))
                  (make-tank (tank-loc (fired-tank s))
                             (cond [(string=? ke "left") (- TANK-DELTA-X)]
                                   [(string=? ke "right") TANK-DELTA-X]
                                   [else (tank-vel (fired-tank s))]))
                  (make-posn (posn-x (fired-missile s))
                             (posn-y (fired-missile s))))))


; si-main
(define (si-main s)
  (big-bang (make-aim (make-posn (/ (image-width CANVAS) 2) 10)
                      (make-tank (/ (image-width CANVAS) 2) TANK-DELTA-X))
            [on-tick si-move]
            [to-draw si-render]
            [on-key si-control]
            [stop-when si-game-over? si-render-final]))

(si-main 0)
