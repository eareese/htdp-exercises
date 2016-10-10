#lang htdp/bsl
(require 2htdp/image)
(require 2htdp/universe)

;; Exercise 94. Draw some sketches of what the [UFO and tank] game scenery looks
;; like at various stages. Use the sketches to determine the constant and the
;; variable pieces of the game. For the former, develop physical constants that
;; describe the dimensions of the world (canvas), its objects, and the graphical
;; constants used to render these objects. Then develop graphical constants for
;; the tank, the UFO, the missile, and some background scenery. Finally, create
;; your initial scene from the constants for the tank, the UFO, and the
;; background.

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

(define TANK (rectangle 30 15 "solid" "blue"))
(define TANK-Y (- (image-height CANVAS) (* 3/5 (image-height TANK))))

(define MISSILE (triangle 12 "solid" "tan"))

(define UFO
  (overlay (circle 4 "solid" "green")
           (rectangle 20 2 "solid" "green")))

;; INITIAL SCENE
(place-images
 (list UFO TANK)
 (list (make-posn (* 1/2 (image-width CANVAS)) (image-height UFO))
       (make-posn (* 1/2 (image-width CANVAS)) TANK-Y))
 CANVAS)
