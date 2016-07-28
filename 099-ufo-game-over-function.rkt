#lang htdp/bsl
(require 2htdp/image)
(require 2htdp/universe)

;; Exercise 99. Design the function si-game-over? for use as the stop-when
;; handler. The game stops if the UFO lands or if the missile hits the UFO. For
;; both conditions, we recommend that you check for proximity of one object to
;; another.
;
;; The stop-when clause allows for an optional second sub-expression, namely a
;; function that renders the final state of the game. Design si-render-final and
;; use it as the second part for your stop-when clause in the main function of
;; exercise 101.


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
(define TANK-DELTA-X 3)

(define MISSILE (triangle 7 "solid" "red"))

(define UFO
  (overlay (circle 4 "solid" "green")
           (rectangle 20 2 "solid" "green")))

(define REACH 5)


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


; SIGS -> Boolean
; si-game-over?
; stop the game if the UFO lands or if the missile hits the ufo
; land condition: ufo's y becomes scene height
; missile cond: use in-reach? from Exercise 97
(check-expect ;; in-reach? should be #t
 (si-game-over
  (make-fired (make-posn 75 100)
              (make-tank 50 TANK-DELTA-X)
              (make-posn (+ 75 (* .5 REACH))
                         (+ 100 (* .5 REACH))))) #t)
(check-expect ;; in-reach? should be #f
 (si-game-over
  (make-fired (make-posn 75 100)
              (make-tank 50 TANK-DELTA-X)
              (make-posn 5 5))) #f)
(check-expect ;; TODO: check land condition
 (si-game-over
  (make-aim (make-posn 75 100)
            (make-tank 50 TANK-DELTA-X))) #f)
(define (si-game-over w)
  (cond [(>= (posn-y (if (aim? w) (aim-ufo w) (fired-ufo w))) (image-height BACKGROUND)) #t]
        [(and (fired? w) (in-reach? (fired-ufo w) (fired-missile w))) #t]
        [else #f]))

;; si-render-image
; SIGS -> Image
(check-expect (si-render-final
               (make-aim (make-posn 20 10) (make-tank 28 -3)))
              (overlay
               (text "GAME OVER" 24 "red") BACKGROUND))
(define (si-render-final w)
  (overlay (text "GAME OVER" 24 "red") BACKGROUND))

(si-render-final (make-aim (make-posn 20 10) (make-tank 28 -3)))
