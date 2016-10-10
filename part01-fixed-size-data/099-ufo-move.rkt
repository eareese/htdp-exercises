#lang htdp/bsl
(require 2htdp/image)
(require 2htdp/universe)

;; Exercise 99. Design si-move. This function is called for every clock tick to determine to which position the objects move now. Accordingly it consumes an element of SIGS and produces another one.

;; Moving the tank and the missile (if any) is relatively straightforward. They move in straight lines at a constant speed. Moving the UFO calls for small random jumps to the left or the right. Since you have never with functions that create random numbers, the rest of this exercise is a longish hint on how to deal with this issue.

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
(define TANK-DELTA-X 3)

(define MISSILE (triangle 12 "solid" "tan"))

(define UFO
  (overlay (circle 4 "solid" "green")
           (rectangle 20 2 "solid" "green")))
(define UFO-DELTA-Y 2)
(define UFO-DELTA-X 5)

;; used by in-reach?
(define REACH 3)

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
                               (make-tank 50 -3)
                               (make-posn 50 100))
                              4)
              (make-fired
               (make-posn 54 (+ 25 UFO-DELTA-Y))
               (make-tank 47 (- TANK-DELTA-X))
               (make-posn 50 (- (* 2 UFO-DELTA-Y) 100))))
(define (si-move-proper s n)
  (if (aim? s)
      (make-aim
       (make-posn (+ n (posn-x (aim-ufo s))) (+ UFO-DELTA-Y (posn-y (aim-ufo s))))
       (make-tank (modulo (+ (tank-loc (aim-tank s)) (tank-vel (aim-tank s))) (image-width CANVAS)) (tank-vel (aim-tank s))))
      (make-fired
       (make-posn (+ n (posn-x (fired-ufo s))) (+ UFO-DELTA-Y (posn-y (fired-ufo s))))
       (make-tank (modulo (+ (tank-loc (fired-tank s)) (tank-vel (fired-tank s))) (image-width CANVAS)) (tank-vel (fired-tank s)))
       (make-posn (posn-x (fired-missile s))
                  (- (* 2 UFO-DELTA-Y) (posn-y (fired-missile s)))))))

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
