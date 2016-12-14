#lang htdp/bsl

;; Exercise 168. Design the function translate. It consumes and produces lists of Posns. For each (make-posn x y) in the former, the latter contains (make-posn x (+ y 1)).—We borrow the word “translate” from geometry, where the movement of a point by a constant distance along a straight line is called a translation.


; Lop
;; A List of positions is one of:
;; - '()
;; - (cons Posn Lop)
;; interpretation a list of (x, y) coordinate positions

; Lop -> Lop
; consumes a Lop and produces a new Lop with (x, y+1)
; for every (x, y) in the original list
(check-expect (translate '()) '())
(check-expect (translate (cons (make-posn 0 0) '())) (cons (make-posn 0 1) '()))
(check-expect (translate (cons (make-posn 0 0)
                               (cons (make-posn 7 7) '())))
              (cons (make-posn 0 1) (cons (make-posn 7 8) '())))
(define (translate alop)
  (cond
    [(empty? alop) '()]
    [(cons? alop) (cons (make-posn (posn-x (first alop)) (+ 1 (posn-y (first alop))))
                        (translate (rest alop)))]))
