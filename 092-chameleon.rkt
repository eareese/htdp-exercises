#lang htdp/bsl
(require 2htdp/image)
(require 2htdp/universe)

;; Design the cham program, which has the chameleon continuously walking across
;; the screen, from left to right. When it reaches the right end of the screen,
;; it disappears and immediately reappears on the left. Like the cat, the
;; chameleon gets hungry from all the walking and, as time passes by, this
;; hunger expresses itself as unhappiness.

;; For managing the chameleon’s happiness gauge, you may reuse the happiness
;; gauge from the virtual cat. To make the chameleon happy, you feed it (down
;; arrow, two points only); petting isn’t allowed. Of course, like all
;; chameleons, ours can change color, too: "r" turns it red, "b" blue, and "g"
;; green. Add the chameleon world program to the virtual cat game and reuse
;; functions from the latter when possible.

;; Start with a data definition, VCham, for representing chameleons.


;; a VCham is a chameleon with a Number x that locates it in its continuous
;; horizontal walk across the canvas; a String that represents its color, and a
;; Number to represent the happiness level of the chameleon.
;; interpretation since the chameleon should continuously walk across the screen
;; from left to right, it  has a number to represent the x place on the CANVAS.
;; so, x is constrained by the width of CANVAS.
;; the chameleon's color is one of:
;; - "r" for red
;; - "g" for green
;; - "b" for blue
;; it also has a happiness level, represented by a number, (0,100]
;; happiness level is affected by the passage of time, where it decreases by some
;; constant value on each clock tick but can be restored by keyboard interaction.

;; interpretation (make-cham 13 "b" 99) makes a chameleon that is close to the
;; left edge of the canvas, is shaded blue, and has happiness level 99
(define-struct cham [x color happy])

(define CHAM (bitmap "images/chameleon.png"))
(define CANVAS (rectangle
                (* 9 (image-width CHAM))
                (* 2 (image-height CHAM))
                "outline" "black"))
(define CHAM-Y (* 0.6667 (image-height CANVAS)))

(define GUAGE-FRAME (rectangle 42 100 "outline" "black"))

; render
; VCham -> Image
; interpretation take a VCham and draw it in the x position with appropriate color,
; also render the happiness guage with the appropriate chameleon's happy number.
(check-expect (render (make-cham 13 "green" 57))
              (place-images
               (list (draw-cham "green") (fill-guage 57))
               (list (make-posn 13 CHAM-Y)
                     (make-posn (/ (image-width GUAGE-FRAME) 2)
                                (/ (image-height GUAGE-FRAME) 2)))
              CANVAS))
(define (render vc)
  (place-images
   (list (draw-cham (cham-color vc)) (fill-guage (cham-happy vc)))
   (list (make-posn (cham-x vc) CHAM-Y)
         (make-posn (/ (image-width GUAGE-FRAME) 2)
                    (/ (image-height GUAGE-FRAME) 2)))
   CANVAS))

; Number -> Image
; draw the guage part only, "filled" to appropriate happy level
(check-expect (fill-guage 13)
              (overlay/align
               "middle" "bottom"
               GUAGE-FRAME
               (rectangle (image-width GUAGE-FRAME) 13 "solid" "blue")))
(define (fill-guage h)
  (overlay/align "middle" "bottom" GUAGE-FRAME
           (rectangle (image-width GUAGE-FRAME) h "solid" "blue")))

;; draw-cham
;; String -> Image
;; draw the chameleon with its background color, given the color string.
(check-expect (draw-cham "blue")
              (overlay
               CHAM
               (rectangle (image-width CHAM)
                          (image-height CHAM) "solid" "blue")))
(define (draw-cham color)
  (overlay
   CHAM (rectangle (image-width CHAM) (image-height CHAM) "solid" color)))



; tock
; VCham -> VCham
; take a VCham world state and return another that represents the state after a
; clock tick. in this case, the chameleon moves some pixels from left to right,
; wrapping around to the left side whenever it goes off the edge to the right.
; also, the happiness level decreases on each clock tick.
(define DELTA-X 3)
(define DELTA-H -0.1)
(check-expect (tock (make-cham 13 "green" 99))
              (make-cham
               (modulo (+ DELTA-X 13) (image-width CANVAS))
               "green"
               (+ DELTA-H 99)))
;; what if it is close to the edge? (down by the riverrrrr?)
(check-expect (tock (make-cham (image-width CANVAS)
                               "green"
                               42))
              (make-cham
               (modulo (+ DELTA-X (image-width CANVAS)) (image-width CANVAS))
               "green"
               (+ DELTA-H 42)))
(define (tock vc)
  (make-cham
   (modulo (+ DELTA-X (cham-x vc)) (image-width CANVAS))
   (cham-color vc)
   (+ DELTA-H (cham-happy vc))))


; hyper
; VCham KeyEvent -> VCham
; this interprets VCham with a certain KeyEvent, specifically:
;; - "r" changes its color to red
;; - "b" changes its color to blue
;; - "g" changes its color to green
; also feeding... TODO
(check-expect (hyper (make-cham 13 "red" 99) "g")
              (make-cham 13 "green" 99))
(check-expect (hyper (make-cham 13 "blue" 99) "b")
              (make-cham 13 "blue" 99))
(check-expect (hyper (make-cham 13 "blue" 99) "a")
              (make-cham 13 "blue" 99))
(check-expect (hyper (make-cham 13 "blue" 42) "down")
              (make-cham 13 "blue" (+ 2 42)))
(define (hyper vc ke)
  (make-cham (cham-x vc)
             (cond [(string=? ke "r") "red"]
                   [(string=? ke "b") "blue"]
                   [(string=? ke "g") "green"]
                   [else (cham-color vc)])
             (+ (cham-happy vc) (if (string=? ke "down") 2 0))))



; main
;; the initial state of VCham worlds is provided by a Number for x. Color is
;; always green and happiness is always 100 to start.
(define (main x)
  (big-bang (make-cham x "green" 100)
            [to-draw render]
            [on-tick tock]
            [on-key hyper]))

(main 13)



