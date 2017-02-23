#lang htdp/bsl+
;;---------------------------------------------------------------------------------------------------
(require 2htdp/image)

; A Polygon is one of:
; - (list Posn Posn Posn)
; - (list Posn Polygon)

(define triangle-p (list (make-posn 20 10)
                         (make-posn 10 10)
                         (make-posn 30 10)))
(define square-p (list (make-posn 10 10)
                       (make-posn 20 10)
                       (make-posn 20 20)
                       (make-posn 10 20)))
(define MT
  (empty-scene 50 50))

; a NELoP is one of:
; - (cons Posn '())
; - (cons Posn NELoP)

;; Exercise 191. Adapt the second example for the render-poly function to connect-dots.

; Image NELoP -> Image
; connects the dots in p by rendering lines in img
(check-expect (connect-dots MT triangle-p)
              (scene+line
               (scene+line MT 20 10 10 10 "blue")
               10 10 30 10 "blue"))
(check-expect (connect-dots MT square-p)
              (scene+line
               (scene+line
                (scene+line MT 10 10 20 10 "blue")
                20 10 20 20 "blue")
               20 20 10 20 "blue"))
(define (connect-dots img p)
  (cond
    [(empty? (rest p)) img]
    [else
     (render-line
      (connect-dots img (rest p))
      (first p)
      (second p))]))

; Image Posn Posn -> Image
; draw a line from Posn p to Posn q on Image img
(check-expect (render-line MT (make-posn 10 10) (make-posn 30 30))
              (scene+line MT 10 10 30 30 "blue"))
(define (render-line img p q)
  (scene+line
   img
   (posn-x p) (posn-y p)
   (posn-x q) (posn-y q)
   "blue"))
