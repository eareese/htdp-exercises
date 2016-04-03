#lang htdp/bsl

(define BASE-ATTENDANCE 120)
(define BASE-PRICE 5.0)
(define ATT-CHANGE 15)
(define PRICE-CHANGE 0.1)
(define BASE-COST 180)
(define COST-PER-ATT 0.04)

(define PRICE-SENSITIVITY (/ ATT-CHANGE PRICE-CHANGE))

; number of attendees depends on ticket price
(define (attendees ticket-price)
  (- BASE-ATTENDANCE
     (* (- ticket-price BASE-PRICE)
        PRICE-SENSITIVITY)))

; revenue is ticket price times number of attendees
(define (revenue ticket-price)
  (* ticket-price (attendees ticket-price)))

; fixed cost ($180) + variable (depends on number of attendees)
(define (cost ticket-price)
  (+ BASE-COST (* COST-PER-ATT (attendees ticket-price))))

; PROFIT
(define (profit ticket-price)
  (- (revenue ticket-price)
     (cost ticket-price)))

(exact->inexact (profit 1.0))
(exact->inexact (profit 2.0))
(exact->inexact (profit 3.0))
(exact->inexact (profit 4.0))
(exact->inexact (profit 5.0))
"---"

(exact->inexact (profit 2.8))
(exact->inexact (profit 2.9))
(exact->inexact (profit 3.0))
