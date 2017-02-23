#lang htdp/bsl+
;;---------------------------------------------------------------------------------------------------
;;---------------------------------------------------------------------------------------------------

;; Exercise 215. Design a world program that continually moves a one-segment worm and enables a
;; player to control the movement of the worm with the four cardinal arrow keys. Your program should
;; use a red disk to render the one-and-only segment of the worm. For each clock tick, the worm
;; should move a diameter.

;; Hints (1) Re-read Designing World Programs to recall how to design world programs. When you define
;; the worm-main function, use the rate at which the clock ticks as its argument. See the
;; documentation for on-tick on how to describe the rate. (2) When you develop a data representation
;; for the worm, contemplate the use of two different kinds of representations: a physical
;; representation and a logical one. The physical representation keeps track of the actual physical
;; position of the worm on the canvas; the logical one counts how many (widths of) segments the worm
;; is from the left and the top. For which of the two is it easier to change the physical appearances
;; (size of worm segment, size of game box) of the “game?”

(require 2htdp/image)
(require 2htdp/universe)

; size is worm diameter
(define SIZE 10)
(define PART (circle (/ SIZE 2) "solid" "blue"))
(define SCALE 15)
(define WORLD (empty-scene (* SCALE SIZE) (* SCALE SIZE)))
(define MIDDLE (floor (/ SCALE 2)))


; A Direction is one of:
; - "up"
; - "down"
; - "left"
; - "right"
; INTERP: the direction the Worm will move next

(define-struct game [posn dir])
; A GameState is a structure:
;   (make-game Posn Direction)
; INTERP: (make-game pos d) represents a Game when the Worm is at Posn pos, which counts the *number
;; of segments away from the top-left*,
; and Direction d.
; EXAMPLE: (make-game (make-posn 0 0) "right") is a game where the Worm is in the top left corner
; and is heading to the right.


; GameState -> Image
; Consumes a GameState and produces an Image that displays the state of the game.
;; (check-expect (render (make-game )))
(check-expect (render (make-game (make-posn 1 0) "right"))
              (place-image PART (+ (/ SIZE 2) (* 1 SIZE)) (+ (/ SIZE 2) (* 0 SIZE)) WORLD))
(check-expect (render (make-game (make-posn (- SCALE 1) (- SCALE 1)) "down"))
              (place-image PART
                           (+ (/ SIZE 2) (* (- SCALE 1) SIZE))
                           (+ (/ SIZE 2) (* (- SCALE 1) SIZE))
                           WORLD))
(define (render gs)
  (place-image PART
               (+ (/ SIZE 2) (* (posn-x (game-posn gs)) SIZE))
               (+ (/ SIZE 2) (* (posn-y (game-posn gs)) SIZE))
               WORLD))

; GameState -> GameState
; increment the game clock and advance the Snake to its next position, which depends on
; incrementing the part of game-posn indicated by game-dir, unless the move would go into
; the boundary of the world.
(check-expect (advance (make-game (make-posn 0 1) "right"))
              (make-game (make-posn 1 1) "right"))
(check-expect (advance (make-game (make-posn 0 0) "down"))
              (make-game (make-posn 0 1) "down"))
; invalid posn + dir -> stay the same
(check-expect (advance (make-game (make-posn 0 0) "up"))
              (make-game (make-posn 0 0) "up"))
(check-expect (advance (make-game (make-posn (- SCALE 1) 0) "right"))
              (make-game (make-posn (- SCALE 1) 0) "right"))
(check-expect (advance (make-game (make-posn 1 (- SCALE 1)) "down"))
              (make-game (make-posn 1 (- SCALE 1)) "down"))
(define (advance gs)
  (cond
    [(and (string=? (game-dir gs) "up") (> (posn-y (game-posn gs)) 0))
     (make-game (make-posn (posn-x (game-posn gs)) (- (posn-y (game-posn gs)) 1)) "up")]
    [(and (string=? (game-dir gs) "down") (< (posn-y (game-posn gs)) (- SCALE 1)))
     (make-game (make-posn (posn-x (game-posn gs)) (+ (posn-y (game-posn gs)) 1)) "down")]
    [(and (string=? (game-dir gs) "left") (> (posn-x (game-posn gs)) 0))
     (make-game (make-posn (- (posn-x (game-posn gs)) 1) (posn-y (game-posn gs))) "left")]
    [(and (string=? (game-dir gs) "right") (< (posn-x (game-posn gs)) (- SCALE 1)))
     (make-game (make-posn (+ (posn-x (game-posn gs)) 1) (posn-y (game-posn gs))) "right")]
    [else gs]))


; key-event-handler
; GameState KeyEvent -> GameState
; consumes a game and the key pressed and produces the next game, which is always the same except
; when the KeyEvent was a directional arrow (up, down, right, left). When it is one of those, the
; Worm should change to that direction for the next GameState
(check-expect (move-worm (make-game (make-posn 3 4) "right") "left")
              (make-game (make-posn 3 4) "left"))
(check-expect (move-worm (make-game (make-posn 3 4) "down") "up")
              (make-game (make-posn 3 4) "up"))
(check-expect (move-worm (make-game (make-posn 3 4) "down") "down")
              (make-game (make-posn 3 4) "down"))
(check-expect (move-worm (make-game (make-posn 3 4) "down") "left")
              (make-game (make-posn 3 4) "left"))
(check-expect (move-worm (make-game (make-posn 3 4) "right") "down")
              (make-game (make-posn 3 4) "down"))
(check-expect (move-worm (make-game (make-posn 3 4) "left") "up")
              (make-game (make-posn 3 4) "up"))
(define (move-worm gs ke)
  (if (or (string=? "up" ke) (string=? "down" ke) (string=? "left" ke) (string=? "right" ke))
      (make-game (make-posn (posn-x (game-posn gs)) (posn-y (game-posn gs))) ke)
      gs))


(define (game-main t)
  (big-bang (make-game (make-posn MIDDLE MIDDLE) "left")
            [on-tick advance t]
            [to-draw render]
            [on-key move-worm]))

(game-main (/ 1 4))
