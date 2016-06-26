#lang htdp/bsl
(require 2htdp/image)
(require 2htdp/universe)

;; Exercise 90
; ex 89, but this time, if happiness reaches 0, it's gg. cat stops moving.

(define-struct cat [x hap])
; Cat = (make-cat Number Number)
; ex: (make-cat 10 1)
; interpretation (make-cat x n) describes a Cat that is at x-position 'x' and
; has happiness level 'n'.

; VCat
; The world state VCat is represented by a Cat with a Number for x-position and
; a Number for "happiness score"
; interpretation The world state of a cat, represented by Cat values to denote
; the cat's position along x-axis and its happiness level. Both position and
; happiness level change on every clock tick.



(define cat1 (bitmap "images/cat1.png"))
(define cat2 (bitmap "images/cat2.png"))

(define CAT-Y 250)
(define HAP-DECAY 0.4)

(define WORLD-WIDTH (* 10 (image-width cat1)))
(define WORLD-HEIGHT (* 3 (image-height cat1)))

(define BACKGROUND
  (rectangle WORLD-WIDTH WORLD-HEIGHT "outline" "black"))

(define HAPG-WIDTH 50)
(define HAPG-HEIGHT 100)
(define HAPG-MAX 100)


; VCat -> Image
; places the cat in the world, using cat-x as the x position.
; also renders the happiness guage, using the value of cat-hap
; TODO: examples
(define (render vc)
  (place-image
   ; animation: alternate cat1/cat2 images
   (cond [(odd? (cat-x vc)) cat1] [else cat2])
   (modulo (* 3 (cat-x vc)) WORLD-WIDTH)
   CAT-Y
   (draw-guage-on-bg (cat-hap vc))))

; TODO: examples
; VCat -> Image
; draw the guage part only
(define (draw-guage-on-bg h)
  (place-image/align
   (rectangle HAPG-WIDTH h "solid" "blue")
   (- WORLD-WIDTH (/ HAPG-WIDTH 2)) HAPG-HEIGHT
   "middle" "bottom"
   BACKGROUND))



; VCat -> VCat
; on each clock tick, cat-x should be incremented by 1, and cat-hap
; should fall by HAP-DECAY, but with a minimum possible value of 0.
; UNLESS! if happiness should fall to 0, the cat will stop moving, i.e.
; maintain the same cat-x value.
; TODO: examples
(define (tock vc)
  (cond [(<= (cat-hap vc) 0)
         (make-cat (cat-x vc) 0)]
        [else
         (make-cat (+ (cat-x vc) 1) (min (- (cat-hap vc) HAP-DECAY) HAPG-MAX))]))


; event handler
; VCat ke -> VCat
; down arrow keyp
; hap inc by 1/5
; up arrow
; hap up by 1/3
(define (hyper vc ke)
  (cond
    [(string=? "down" ke)
     (make-cat (cat-x vc) (min HAPG-HEIGHT (* 1.2 (cat-hap vc))))]
    [(string=? "up" ke)
     (make-cat (cat-x vc) (min HAPG-HEIGHT (* 1.3333 (cat-hap vc))))]
    [else vc]))


; VCat -> VCat
; launches the program, given a Number value for x, and assuming that
; happiness level starts at max.
(define (main x)
  (big-bang (make-cat x 100)
            [on-tick tock]
            [to-draw render]
            [on-key hyper]))


(main 13)
