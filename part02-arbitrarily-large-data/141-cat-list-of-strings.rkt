#lang htdp/bsl

;; Exercise 141. If you are asked to design the function cat, which consumes a list of strings and appends them all into one long string, you are guaranteed to end up with this partial definition: 

; List-of-string -> String
; concatenate all strings in l into one long string
;; (check-expect (cat '()) "")
;; (check-expect (cat (cons "a" (cons "b" '()))) "ab")
;; (check-expect
;;  (cat (cons "ab" (cons "cd" (cons "ef" '()))))
;;  "abcdef")
;; (define (cat l)
;;   (cond
;;     [(empty? l) ""]
;;     [else (... (first l) ... (cat (rest l)) ...)]))


;; FIGURE 53:
;; l          	(first l)   	(rest l)  	(cat (rest l))	(cat l)
;----------------------------------------------------------------
;(cons "a"       "a"      (cons "b" '())   "b"             "ab"
; (cons "b"
;  '()))
;
;(cons "ab"      "ab"     (cons "cd"       "cdef"        "abcdef"
; (cons "cd"               (cons "ef"
;  (cons "ef"               '()))
;   '())))

;; Fill in the table in figure 53. Guess a function that can create the desired result from the values computed by the sub-expressions.

; List-of-string -> String
; concatenate all strings in l into one long string
(check-expect (cat '()) "")
(check-expect (cat (cons "a" (cons "b" '()))) "ab")
(check-expect
 (cat (cons "ab" (cons "cd" (cons "ef" '()))))
 "abcdef")
(define (cat l)
  (cond
    [(empty? l) ""]
    [else (string-append (first l) (cat (rest l)))]))

;; Use DrRacket’s stepper to evaluate (cat (cons "a" '())).
;; (cat (cons "a" '()))
