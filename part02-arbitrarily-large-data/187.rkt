#lang htdp/bsl+
;;---------------------------------------------------------------------------------------------------

;; Exercise 187. Design a program that sorts lists of game players by score:

;; (define-struct gp [name score])
;; ; A GamePlayer is a structure:
;; ;    (make-gp String Number)
;; ; interpretation (make-gp p s) represents player p who
;; ; scored a maximum of s points

;; Hint Formulate a function that compares two elements of GamePlayer.

(define-struct gp [name score])

; List-of-game-players -> List-of-game-players
; returns the list, sorted by score
(check-expect (sort-by-score (list (make-gp "A" 1) (make-gp "B" 3) (make-gp "C" 0)))
                             (list (make-gp "B" 3) (make-gp "A" 1) (make-gp "C" 0)))
(check-expect (sort-by-score (list (make-gp "Z" 10))) (list (make-gp "Z" 10)))
(check-expect (sort-by-score '()) '())
(define (sort-by-score players)
  (cond
    [(empty? players) '()]
    [(cons? players) (insert (first players) (sort-by-score (rest players)))]))

; GamePlayer List-of-game-players -> List-of-game-players
; inserts the player into the sorted list of game players
(check-expect (insert (make-gp "b" 2) (list (make-gp "c" 3) (make-gp "a" 1)))
              (list (make-gp "c" 3) (make-gp "b" 2) (make-gp "a" 1)))
(check-expect (insert (make-gp "a" 1) '()) (list (make-gp "a" 1)))
(define (insert p alop)
  (cond
    [(empty? alop) (cons p '())]
    [else (if
           (>= (gp-score p) (gp-score (first alop)))
           (cons p alop)
           (cons (first alop) (insert p (rest alop))))]))


; GamePlayer GamePlayer -> GamePlayer
; compares two players and returns the one with the highest score
;; (check-expect (compare (make-gp "l" 0) (make-gp "w" 5)) (make-gp "w" 5))
;; (check-expect (compare (make-gp "w" 1) (make-gp "l" 0)) (make-gp "w" 1))
;; ;; TODO what if it is a tie? expect the first player for now
;; (check-expect (compare (make-gp "t1" 2) (make-gp "t2" 2)) (make-gp "t1" 2))
;; (define (compare p1 p2)
;;   (if (< (gp-score p1) (gp-score p2)) p2 p1))
