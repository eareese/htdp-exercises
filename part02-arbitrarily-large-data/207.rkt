#lang htdp/bsl+
;;---------------------------------------------------------------------------------------------------
(require 2htdp/itunes)
(define ITUNES-LOCATION "itunes.xml")

; LLists
(define library (read-itunes-as-lists ITUNES-LOCATION))

(define test-llist (list (list
                          (list "Album" "TNT")
                          (list "Artist" "Tortoise")
                          (list "Name" "Four-Day Interval")
                          (list "Total Time" 285440))
                         (list
                          (list "Album" "TNT")
                          (list "Artist" "Tortoise")
                          (list "Name" "The Equator")
                          (list "Total Time" 222928))
                         ))

;; Exercise 207. Design total-time/list, which consumes an LLists and produces the total amount of
;; play time. Hint Solve exercise 206 first.

;; Once you have completed the design, compute the total play time of your iTunes collection.
;; Compare this result with the time that the total-time function from exercise 200 computes. Why is
;; there a difference?

; An LLists is one of:
; – '()
; – (cons LAssoc LLists)

; An LAssoc is one of:
; – '()
; – (cons Association LAssoc)
;
; An Association is a list of two items:
;   (cons String (cons BSDN '()))

; A BSDN is one of:
; – Boolean
; – Number
; – String
; – Date

; LLists -> Number
; consumes an LLists and produces the total amount of play time
(check-expect (total-time/list test-llist) (+ 285440 222928))
(check-expect (total-time/list '()) 0)
(define (total-time/list llist)
  (cond
    [(empty? llist) 0]
    [else (+
           (second (assoc "Total Time" (first llist)))
           (total-time/list (rest llist)))]))

(total-time/list library)

; 2773511206
; a bit over 32 days (because this list includes podcasts and other non-"Track" media?)
