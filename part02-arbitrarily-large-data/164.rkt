#lang htdp/bsl

;; Exercise 164. Design the function convert-euro, which converts a list of US$ amounts into a list of € amounts. Look up the current exchange rate on the web.
;;
;; Generalize convert-euro to the function convert-euro*, which consumes an exchange rate and a list of US$ amounts and converts the latter into a list of € amounts.

; Mid December 2016: $1 USD = 0.94 EUR
(define RATE 0.94)

; List-of-amounts Number -> List-of-amounts
; consumes a list of USD amounts and exchange rate, returns a list of amounts in EUR
(check-expect (convert-euro* (cons 1 '()) RATE) (cons (* 1 RATE) '()))
(define (convert-euro* loa xr)
  (cond
    [(empty? loa) '()]
    [else (cons (* xr (first loa)) (convert-euro* (rest loa) xr))]))
