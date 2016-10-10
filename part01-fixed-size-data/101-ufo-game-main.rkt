#lang htdp/bsl
(require 2htdp/image)
(require 2htdp/universe)

;; Exercise 101. Design the function si-control, which plays the role of the key
;; event handler. As such it consumes a game state and a KeyEvent and produces a
;; new game state. This specific function reacts to three different key events:

;; pressing the left arrow ensures that the tank moves left;

;; pressing the right arrow ensures that the tank moves right; and

;; pressing the space bar fires the missile if it hasn’t been launched yet.

;; Once you have this function, you can define the si-main function, which uses
;; big-bang to spawn the game-playing window.

;; Enjoy the game.


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
(define POSN-Y-OFFSET 10)

(define REACH 5)


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
                               (make-tank 50 (- TANK-DELTA-X))
                               (make-posn 50 100))
                              4)
              (make-fired
               (make-posn 54 (+ 25 UFO-DELTA-Y))
               (make-tank 47 (- TANK-DELTA-X))
               (make-posn 50 (- (* 2 UFO-DELTA-Y) 100))))
(define (si-move-proper w n)
  (cond [(aim? w)
         (make-aim
          (make-posn (+ n (posn-x (aim-ufo w)))
                     (+ UFO-DELTA-Y (posn-y (aim-ufo w))))
          (make-tank (+ (tank-vel (aim-tank w)) (tank-loc (aim-tank w)))
                     (tank-vel (aim-tank w))))]
        [else
         (make-fired
          (make-posn (+ n (posn-x (fired-ufo w)))
                     (+ UFO-DELTA-Y (posn-y (fired-ufo w))))
          (make-tank (+ (tank-vel (fired-tank w))
                        (tank-loc (fired-tank w)))
                     (tank-vel (fired-tank w)))
          (make-posn (posn-x (fired-missile w))
                     (- (* 2 UFO-DELTA-Y)
                        (posn-y (fired-missile w)))))]))

; SIGS -> Number
; create a random number in case a UFO should perform jump
(check-random (create-random-number (make-aim (make-posn 45 67)
                                              (make-tank 54 76)))
              (random UFO-DELTA-X))
(define (create-random-number w)
  (random UFO-DELTA-X) )


; Tank Image -> Image
; adds t to the given image img
(check-expect (tank-render (make-tank 20 TANK-DELTA-X) BACKGROUND)
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
  "space")
 (make-fired (make-posn 50 25)
             (make-tank 50 TANK-DELTA-X)
             (make-posn 50 (- TANK-Y POSN-Y-OFFSET))))
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
  "space")
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
(define (si-control w ke)
  (if (aim? w)
      (if (eq? ke "space")
          ; aim + space => fired missile
          (make-fired (make-posn (posn-x (aim-ufo w)) (posn-y (aim-ufo w)))
                      (make-tank (tank-loc (aim-tank w))
                                 (tank-vel (aim-tank w)))
                      ; missile initial posn
                      (make-posn (tank-loc (aim-tank w))
                                 (- TANK-Y POSN-Y-OFFSET)))
          ; regular aim state controls
          (make-aim (make-posn (posn-x (aim-ufo w)) (posn-y (aim-ufo w)))
                    (make-tank (tank-loc (aim-tank w))
                               (cond [(eq? ke "left") (- TANK-DELTA-X)]
                                     [(eq? ke "right") TANK-DELTA-X]
                                     [else (tank-vel (aim-tank w))]))))
      ; regular fired state controls
      (make-fired (make-posn (posn-x (fired-ufo w)) (posn-y (fired-ufo w)))
                  (make-tank (tank-loc (fired-tank w))
                             (cond [(eq? ke "left") (- TANK-DELTA-X)]
                                   [(eq? ke "right") TANK-DELTA-X]
                                   [else (tank-vel (fired-tank w))]))
                  (make-posn (posn-x (fired-missile w))
                             (posn-y (fired-missile w))))))

; SIGS -> Boolean
; si-game-over?
; stop the game if the UFO lands or if the missile hits the ufo
; land condition: ufo's y becomes scene height
; missile cond: use in-reach? from Exercise 97
(check-expect ;; in-reach? should be #t
 (si-game-over?
  (make-fired (make-posn 75 100)
              (make-tank 50 TANK-DELTA-X)
              (make-posn (+ 75 (* .5 REACH))
                         (+ 100 (* .5 REACH))))) #t)
(check-expect ;; in-reach? should be #f
 (si-game-over?
  (make-fired (make-posn 75 100)
              (make-tank 50 TANK-DELTA-X)
              (make-posn 5 5))) #f)
(check-expect ;; TODO: check land condition
 (si-game-over?
  (make-aim (make-posn 75 100)
            (make-tank 50 TANK-DELTA-X))) #f)
(define (si-game-over? w)
  (cond [(>= (posn-y (if (aim? w) (aim-ufo w) (fired-ufo w))) (image-height BACKGROUND)) #t]
        [(and (fired? w) (in-reach? (fired-ufo w) (fired-missile w))) #t]
        [else #f]))

; in-reach?
;; Posn Posn -> Boolean
; determines whether a given Posn is "close enough" to another given Posn, that
;; is, if the distance between Posns is strictly less than some constant REACH.
(check-expect
 (in-reach? (make-posn 50 50)
            (make-posn 50 (+ 50 (* .5 REACH))))
 #t)
(check-expect
 (in-reach? (make-posn 50 50) (make-posn (- 50 (* .5 REACH))
                                         (+ 50 (* .5 REACH))))
 #t)
(check-expect
 (in-reach? (make-posn 50 50)
            (make-posn 50 50))
 #t)
(check-expect
 (in-reach? (make-posn 50 50)
            (make-posn (+ 50 (+ 10 REACH)) (+ 50 (+ 10 REACH))))
 #f)
(check-expect (in-reach? (make-posn 50 50) (make-posn 50 50)) #t)
(define (in-reach? p1 p2)
   (<= (disty p1 p2) REACH))

;; distance formula by itself
; Posn Posn -> Number
; calculate the distance between two points
(check-expect (disty (make-posn 0 5) (make-posn 0 0))
              5)
(check-expect (disty (make-posn 5 0) (make-posn 0 0))
              5)
(check-expect (disty (make-posn 3 0) (make-posn 0 4))
              5)
(check-expect (disty (make-posn -5 -5) (make-posn -5 -5))
              0)
(define (disty p1 p2)
  (sqrt (+ (sqr (- (posn-x p2) (posn-x p1))) (sqr (- (posn-y p2) (posn-y p1))))))


;; si-render-image
; SIGS -> Image
(check-expect (si-render-final
               (make-aim (make-posn 20 10) (make-tank 28 -3)))
              (overlay
               (text "GAME OVER" 24 "red") BACKGROUND))
(define (si-render-final w)
  (overlay (text "GAME OVER" 24 "red") BACKGROUND))


; si-main
(define (si-main w)
  (big-bang (make-aim (make-posn (/ (image-width BACKGROUND) 2) 10)
                      (make-tank (/ (image-width BACKGROUND) 2) TANK-Y))
            [on-tick si-move]
            [to-draw si-render]
            [on-key si-control]
            [stop-when si-game-over? si-render-final]))

(si-main 0)
