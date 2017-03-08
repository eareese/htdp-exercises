#lang htdp/bsl+
;;---------------------------------------------------------------------------------------------------
;; Exercise 217. Develop a data representation for worms with tails. A worm’s tail is a possibly
;; empty sequence of “connected” segments. Here “connected” means that the coordinates of a segment
;; differ from those of its predecessor in at most one direction. To keep things simple, treat all
;; segments—head and tail segments—the same.

;; Now modify your program from exercise 215 to accommodate a multi-segment worm. Keep things simple:
;; (1) your program may render all worm segments as red disks and (2) ignore that the worm may run
;; into the wall or itself. Hint One way to realize the worm’s movement is to add a segment in the
;; direction in which it is moving and to delete the last one.

(require 2htdp/image)
(require 2htdp/universe)

; size is worm segment diameter
(define SIZE 10)
(define PART (circle (/ SIZE 2) "solid" "blue"))
(define SCALE 15)
(define WORLD (empty-scene (* SCALE SIZE) (* SCALE SIZE)))
(define MIDDLE (floor (/ SCALE 2)))

(define DEMOWORM (cons (make-posn 1 1) (cons (make-posn 1 2) (cons (make-posn 1 3) '()))))


; A Segment is a Posn.
; INTERP: the Posn counts by number of segment-widths away from the origin, in this case top-left.


; A Worm (with tail) is a List-of-segments:
; - '()
; - (cons List-of-segments '())
; Every segment must be "connected", that is, its coords will be different from its next neighbor in
; one direction at most.
; The head of the worm is the last segment in the list, and the first in the list represents the tail-end of the worm.
; Examples:
;; (cons (posn 1 1) '())
;; (cons (posn 1 1) (cons (posn 1 0) '()))


; A Direction is one of:
; - "up"
; - "down"
; - "left"
; - "right"
; INTERP: the direction the Worm will move next

(define-struct game [worm dir])
; A GameState is a structure:
;   (make-game Worm Direction)
; INTERP: (make-game worm d) represents a Game when the Worm is traveling in Direction d.
; EXAMPLE: (make-game (cons (make-posn 0 0) '()) "right") is a game where the Worm is one segment
; long, located in the top left corner, and traveling to the right.


; Consumes a Worm (a List-of-Posns described in segment offsets) and produces a List-of-Posns that
; are real coordinates to be used by  place-images
(check-expect (part-posns DEMOWORM)
              (list (make-posn (+ (/ SIZE 2) (* 1 SIZE)) (+ (/ SIZE 2) (* 1 SIZE)))
                    (make-posn (+ (/ SIZE 2) (* 1 SIZE)) (+ (/ SIZE 2) (* 2 SIZE)))
                    (make-posn (+ (/ SIZE 2) (* 1 SIZE)) (+ (/ SIZE 2) (* 3 SIZE)))))
(check-expect (part-posns '()) '())
(define (part-posns wl)
  (cond
    [(empty? wl) '()]
    [else (cons (make-posn (+ (/ SIZE 2) (* (posn-x (first wl)) SIZE))
                           (+ (/ SIZE 2) (* (posn-y (first wl)) SIZE)))
                (part-posns (rest wl)))]))


; Worm -> List-of-parts
; Makes the List-of-parts for place-images to draw in the render function
(check-expect (worm-part-list DEMOWORM) (cons PART (cons PART (cons PART '()))))
(check-expect (worm-part-list '()) '())
(define (worm-part-list w)
  (cond
    [(empty? w) '()]
    ;; [(list? w) (cons PART (worm-part-list (rest w)))]))
    [else (cons PART (worm-part-list (rest w)))]))


; GameState -> Image
; Consumes the GameState's Worm (really a List-of-Posns) and renders all the worm's segments to WORLD
(check-expect (render (make-game DEMOWORM "up"))
              (place-images (list PART PART PART) (part-posns DEMOWORM) WORLD))
(define (render gs)
  (place-images (worm-part-list (game-worm gs)) (part-posns (game-worm gs)) WORLD))


; GameState -> GameState
; increment the game clock and advance the Snake to its next position, which depends on
; incrementing the part of game-posn indicated by game-dir, unless the move would go into
; the boundary of the world.
(check-expect (advance (make-game DEMOWORM "down"))
              (make-game (list (make-posn 1 2)
                               (make-posn 1 3)
                               (make-posn 1 4)) "down"))
(check-expect (advance (make-game DEMOWORM "right"))
              (make-game (list (make-posn 1 2)
                               (make-posn 1 3)
                               (make-posn 2 3)) "right"))
(define (advance gs)
  (make-game
   (append (rest (game-worm gs))
           (list
            (make-posn
             (cond
               [(string=? "left" (game-dir gs)) (- (posn-x (last (game-worm gs))) 1)]
               [(string=? "right" (game-dir gs)) (+ (posn-x (last (game-worm gs))) 1)]
               [else (posn-x (last (game-worm gs)))])
             (cond
               [(string=? "up" (game-dir gs)) (- (posn-y (last (game-worm gs))) 1)]
               [(string=? "down" (game-dir gs)) (+ (posn-y (last (game-worm gs))) 1)]
               [else (posn-y (last (game-worm gs)))]))))
   (game-dir gs)))

(define (last l)
  (first (reverse l)))

; GameState KeyEvent -> GameState
; consumes a game and the key pressed and produces the next game, which is always the same except
; when the KeyEvent was a directional arrow (up, down, right, left). When it is one of those, the
; Worm should change to that direction for the next GameState
(check-expect (move-worm (make-game DEMOWORM "right") "left")
              (make-game DEMOWORM "left")) ; TODO dont care for now about worm traveling into itself
(check-expect (move-worm (make-game DEMOWORM "right") "up")
              (make-game DEMOWORM "up"))
(check-expect (move-worm (make-game DEMOWORM "down") "left")
              (make-game DEMOWORM "left"))
(check-expect (move-worm (make-game DEMOWORM "right") "down")
              (make-game DEMOWORM "down"))
(check-expect (move-worm (make-game DEMOWORM "right") "q")
              (make-game DEMOWORM "right")); no change for invalid input
(define (move-worm gs ke)
  (if (or (string=? "up" ke) (string=? "down" ke) (string=? "left" ke) (string=? "right" ke))
      (make-game (game-worm gs) ke)
      gs))


(define (game-main t)
  (big-bang (make-game DEMOWORM "down")
            [on-tick advance t]
            [to-draw render]
            [on-key move-worm]))

(game-main (/ 1 4))
