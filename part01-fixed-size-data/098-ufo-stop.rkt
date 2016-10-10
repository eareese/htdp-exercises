#lang htdp/bsl
(require 2htdp/image)
(require 2htdp/universe)

;; Exercise 98. Design the function si-game-over? for use as the stop-when handler. The game stops if the UFO lands or if the missile hits the UFO. For both conditions, we recommend that you check for proximity of one object to another.

;; The stop-when clause allows for an optional second sub-expression, namely a function that renders the final state of the game. Design si-render-final and use it as the second part for your stop-when clause in the main function of exercise 100.

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

(define MISSILE (triangle 12 "solid" "tan"))

(define UFO
  (overlay (circle 4 "solid" "green")
           (rectangle 20 2 "solid" "green")))

;; used by in-reach?
(define REACH 3)

;; Structure type definitions
(define-struct aim [ufo tank])
(define-struct fired [ufo tank missile])
(define-struct tank [loc vel])



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


; si-render-final
; SIGS -> Image
(check-expect (si-render-final
               (make-aim (make-posn 20 10) (make-tank 28 -3)))
              (overlay
               (text "GAME OVER" 24 "red") CANVAS))
(define (si-render-final w)
  (overlay (text "GAME OVER" 24 "red") CANVAS))

(si-render-final (make-aim (make-posn 20 10) (make-tank 28 -3)))

