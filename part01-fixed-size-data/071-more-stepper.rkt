#lang htdp/bsl

(define HEIGHT 200)
(define MIDDLE (quotient HEIGHT 2))
(define WIDTH 400)
(define CENTER (quotient WIDTH 2))

(define-struct game [left-player right-player ball])
; (game-left-player (make-game lp0 rp0 ball0) lp0)

(define game0
  (make-game MIDDLE MIDDLE (make-posn CENTER CENTER)))


; explain & stepper:
(game-ball game0)

(posn? (game-ball game0))

(game-left-player game0)
