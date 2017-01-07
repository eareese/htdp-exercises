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

; Image Polygon -> Image
; adds an image of p to MT
(define (render-polygon img p)
  (render-line (connect-dots img p) (first p) (last p)))

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
     (render-line (connect-dots img (rest p))
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

;; Exercise 192. Argue why it is acceptable to use last on Polygons. Also argue why you may adapt the
;; template for connect-dots to last:

;; (define (last p)
;;   (cond
;;     [(empty? (rest p)) (... (first p) ...)]
;;     [else (... (first p) ... (last (rest p)) ...)]))

;; Finally, develop examples for last, turn them into tests, and ensure that the definition of last
;; in figure 69 works on your examples.

; It is a requirement of Polygons that they have a minimum of three Posns, so it's acceptable to use last on them since there should always be an item to extract. The template for connect-dots is applicable to last because both of them handle Polygons that are NELoPs

; Polygon -> Posn
; extracts the last item from p
(check-expect (last square-p) (make-posn 10 20))
(check-expect (last (list (make-posn 10 20)
                          (make-posn 20 20)
                          (make-posn 20 40)))
              (make-posn 20 40))
(define (last p)
  (cond
    [(empty? (rest (rest (rest p)))) (third p)]
    [else (last (rest p))]))
