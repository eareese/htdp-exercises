#lang htdp/bsl
;;---------------------------------------------------------------------------------------------------
;; Exercise 176. Mathematics teachers may have introduced you to matrix calculations by now. In
;; principle, matrix just means rectangle of numbers. Here is one possible data representation for
;; matrices:
;;
;;     ; A Matrix is one of:
;;     ;  – (cons Row '())
;;     ;  – (cons Row Matrix)
;;     ; constraint all rows in matrix are of the same length
;;
;;     ; An Row is one of:
;;     ;  – '()
;;     ;  – (cons Number Row)
;;
;; Note the constraints on matrices. Study the data definition and translate the two-by-two matrix

; Matrix -> Matrix
; transpose the given matrix along the diagonal

(define r1 (cons 111 (cons 222 (cons 333 '()))))
(define r2 (cons 444 (cons 555 (cons 666 '()))))
(define r3 (cons 777 (cons 888 (cons 999 '()))))
(define mat2 (cons r1 (cons r2 (cons r3 '()))))
(define tr1 (cons 111 (cons 444 (cons 777 '()))))
(define tr2 (cons 222 (cons 555 (cons 888 '()))))
(define tr3 (cons 333 (cons 666 (cons 999 '()))))
(define tam2 (cons tr1 (cons tr2 (cons tr3 '()))))
(check-expect (transpose mat2) tam2)

(define wor1 (cons 11 (cons 21 '())))
(define wor2 (cons 12 (cons 22 '())))
(define tam1 (cons wor1 (cons wor2 '())))
(check-expect (transpose mat1) tam1)
(define (transpose lln)
  (cond
    [(empty? (first lln)) '()]
    [else (cons (first* lln) (transpose (rest* lln)))]))

(define row1 (cons 11 (cons 12 '())))
(define row2 (cons 21 (cons 22 '())))
(define mat1 (cons row1 (cons row2 '())))

;; 11 12
;; 21 22  mat1
;; vvvvv

;; 11 21  tam1
;; 12 22


;; The definition assumes two auxiliary functions:

;; first*, which consumes a matrix and produces the first column as a list of numbers;

;; rest*, which consumes a matrix and removes the first column. The result is a matrix.

;; Even though you lack definitions for these functions, you should be able to understand how transpose works. You should also understand that you cannot design this function with the design recipes you have seen so far. Explain why.

;; Design the two “wish list” functions. Then complete the design of the transpose with some test cases.


; first*
; Matrix -> List-of-numbers
; consumes a matrix, produces the first column as a list of numbers
(check-expect (first* mat1) (cons 11 (cons 21 '())))
(check-expect (first* '()) '())
(define (first* m)
  (cond
    [(empty? m) '()]
    [else (cons (first (first m)) (first* (rest m)))]))


; rest*
; Matrix -> Matrix
; consumes a matrix and removes its first column
;; (check-expect (rest* tam1 Vj))
(define rr1 (cons 12 '()))
(define rr2 (cons 22 '()))
(define restm (cons rr1 (cons rr2 '())))
(check-expect (rest* mat1) restm)
(check-expect (rest* '()) '())
(define (rest* m)
  (cond
    [(empty? m) '()]
    [else (cons (rest (first m)) (rest* (rest m)))]))
