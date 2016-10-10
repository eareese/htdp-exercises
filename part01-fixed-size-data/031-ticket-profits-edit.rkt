#lang htdp/bsl

; change cost: no base cost, but $1.5 per attendee
(define BASE-ATTENDANCE 120)
(define BASE-PRICE 5.0)
(define ATT-CHANGE 15)
(define PRICE-CHANGE 0.1)
(define BASE-COST 0)
(define COST-PER-ATT 1.5)

; number of attendees depends on ticket price
(define (attendees ticket-price)
  (- BASE-ATTENDANCE
     (* (- ticket-price BASE-PRICE)
        (/ ATT-CHANGE PRICE-CHANGE))))

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

(exact->inexact (profit 3.0))
(exact->inexact (profit 4.0))
(exact->inexact (profit 5.0))

#| another version |#
(define (profit2 price)
  (- (* (+ 120
           (* (/ 15 0.1)
              (- 5.0 price)))
        price)
     (+ 0
        (* 1.5
           (+ 120
              (* (/ 15 0.1)
                 (- 5.0 price)))))))

"--version 2--"
(exact->inexact (profit2 3.0))
(exact->inexact (profit2 4.0))
(exact->inexact (profit2 5.0))
