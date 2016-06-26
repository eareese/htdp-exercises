#lang htdp/bsl

; constants
(define LOW-RATE 0.05)
(define LUXURY-RATE 0.08)

; The state of Tax Land has created a three-stage sales tax to cope with its budget
; deficit. Inexpensive items, those costing less than $1,000, are not taxed. Luxury
; items, with a price of more than $10,000, are taxed at the rate of eight percent
; (8.00%). Everything in between comes with a five percent (5%) mark up.

; Design a function for a cash register that given the price of an item,
; computes the sales tax.

; a Price falls into one of three intervals:
; - 0 through 1000;
; - 1000 through 10000;
; - 10000 and above.
; interpretation the price of an item

; Price -> Number
; computes the amount of tax charged for price p
(check-expect (sales-tax 0.0) 0.0)
(check-expect (sales-tax 537) 0)
(check-expect (sales-tax 1000) (* LOW-RATE 1000))
(check-expect (sales-tax 1282.0) (* LOW-RATE 1282.0))
(check-expect (sales-tax 10000) (* LUXURY-RATE 10000))
(check-expect (sales-tax 12017) (* LUXURY-RATE 12017))
(define (sales-tax p)
  (cond
    [(and (<= 0 p) (< p 1000)) 0]
    [(and (<= 1000 p) (< p 10000)) (* LOW-RATE p)]
    [(>= p 10000) (* LUXURY-RATE p)]))
