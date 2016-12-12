#lang htdp/bsl
(require 2htdp/image)

;; Exercise 153. The goal of this exercise is to visualizes the result of a
;; 1968-style European student riot. Here is the rough idea. A small group of
;; students meets to make paint-filled balloons, enters some lecture hall and
;; randomly throws the balloons at the attendees. Your world program displays
;; how the balloons color the seats in the lecture hall.
;;
;; Use the two functions from exercise 152 to create a rectangle of 8 by 18
;; squares, each of which has size 10 by 10. Place it in an empty-scene of the
;; same size. This image is your lecture hall.
;;
;; Design add-balloons. The function consumes a list of Posn whose coordinates
;; fit into the dimensions of the lecture hall. It produces an image of the
;; lecture hall with red dots added as specified by the Posns.
;;
;; Figure 56 shows the output of our solution when given some list of Posns. The
;; leftmost is the clean lecture hall, the second one is after two balloons have
;; hit, and the last one is a highly unlikely distribution of 10 hits. Where is
;; the 10th?


;; - create empty scene using column and row functions
(define SQSIZE 10)
(define SQW 8)
(define SQH 18)
(define BAL (circle 3 "solid" "red"))

(define SQ (rectangle SQSIZE SQSIZE "outline" "black"))

; N Image -> Image
; takes a natural number n and an image img, produces a column
(check-expect (column 3 SQ) (above SQ SQ SQ))
(define (column n img)
  (cond
    [(<= n 1) img]
    [else (above img (column (sub1 n) img))]))

; N Image -> Image
; takes a natural number n and an image img, produces a row
(check-expect (row 3 SQ) (beside SQ SQ SQ))
(define (row n img)
  (cond
    [(<= n 1) img]
    [else (beside img (row (sub1 n) img))]))

(define SCENE (overlay (column SQH (row SQW SQ))
                       (empty-scene (* SQW SQSIZE) (* SQH SQSIZE))))

;; - design add-balloons
; List-of-Posns -> Image
; consumes a list of Posn (with coordinates inside the dimensions of the scene)
; and produces an image of the "lecture hall" with red dots added as specified
; by the Posns.
(check-expect (add-balloons (cons (make-posn 50 50) '()))
              (place-image BAL 50 50 SCENE))
(check-expect (add-balloons (cons (make-posn 35 35)
                                  (cons (make-posn 50 50) '())))
              (place-image BAL 50 50
                          (place-image BAL 35 35 SCENE)))
(check-expect (add-balloons '()) SCENE)
(define (add-balloons alop)
  (cond
    [(empty? alop) SCENE]
    [else (place-image BAL
                      (posn-x (first alop))
                      (posn-y (first alop))
                      (add-balloons (rest alop)))]))

; - where is the 10th balloon [in Figure 56]?
;; It's all the way in the top left corner, as if placed with a call like:
;; (add-balloons (cons (make-posn 0 0) '()))
