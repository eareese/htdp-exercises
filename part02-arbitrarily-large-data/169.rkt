#lang htdp/bsl

;; Exercise 169. Design the function legal. Like translate from exercise 168 the function consumes and produces a list of Posns. The result contains all those Posns whose x-coordinates are between 0 and 100 and whose y-coordinates are between 0 and 200.


(define XMIN 1)
(define XMAX 99)
(define YMIN 1)
(define YMAX 199)

; Lop
;; A List of positions is one of:
;; - '()
;; - (cons Posn Lop)
;; interpretation a list of (x, y) coordinate positions

; Lop -> Lop
; consumes a Lop and produces a new Lop containing all
; of the Posns with 0 < x < 100 and 0 < y < 200
(check-expect (legal '()) '())
(check-expect (legal (cons (make-posn 100 50) '())) '())
(check-expect (legal (cons (make-posn 50 200) '())) '())
(check-expect (legal (cons (make-posn 0 50) '())) '())
(check-expect (legal (cons (make-posn 50 0) '())) '())
(check-expect (legal (cons (make-posn 50 50) '())) (cons (make-posn 50 50) '()))
(check-expect (legal (cons (make-posn 1 50) '())) (cons (make-posn 1 50) '()))
(check-expect (legal (cons (make-posn 50 1) '())) (cons (make-posn 50 1) '()))
(check-expect (legal (cons (make-posn 99 50) '())) (cons (make-posn 99 50) '()))
(check-expect (legal (cons (make-posn 50 199) '())) (cons (make-posn 50 199) '()))
(check-expect (legal (cons (make-posn 50 50) (cons (make-posn 300 50) '())))
              (cons (make-posn 50 50) '()))
(define (legal alop)
  (cond
    [(empty? alop) '()]
    [(and (cons? alop) (legal? (first alop))) (cons (first alop) (legal (rest alop)))]
    [(cons? alop) (legal (rest alop))]))

  ; Posn -> Boolean
  ; consumes a Posn and produces true if the coordinates are
  ; within the "legal" range, as defined by the problem.
  ; if either x or y is not within range, returns false
  (check-expect (legal? (make-posn XMIN YMIN)) #t)
  (check-expect (legal? (make-posn XMAX YMAX)) #t)
  (check-expect (legal? (make-posn (+ 1 XMAX) (+ 1 YMAX))) #f)
  (check-expect (legal? (make-posn (- 1 XMIN) YMIN)) #f)
  (define (legal? p)
    (and (>= (posn-x p) XMIN)
         (<= (posn-x p) XMAX)
         (>= (posn-y p) YMIN)
         (<= (posn-y p) YMAX)))
