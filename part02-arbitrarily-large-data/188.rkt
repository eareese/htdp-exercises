#lang htdp/bsl+
;;---------------------------------------------------------------------------------------------------

;; Exercise 188. Design a program that sorts lists of emails by date:

;; (define-struct email [from date message])
;; ; A Email Message is a structure:
;; ;   (make-email String Number String)
;; ; interpretation (make-email f d m) represents text m
;; ; sent by f, d seconds after the beginning of time

;; Also develop a program that sorts lists of email messages by name. To compare two strings
;; alphabetically, use the string<? primitive.

(define-struct email [from date message])
; A Email Message is a structure:
;   (make-email String Number String)
; interpretation (make-email f d m) represents text m
; sent by f, d seconds after the beginning of time
(define sample (list (make-email "Alice" 300 "hello")
                     (make-email "Alice" 100 "hi")
                     (make-email "Alice" 200 "umm")))

; List-of-emails -> Boolean
; returns true if the list is sorted by most recent (biggest) date
(check-expect (email-date-sorted? (list (make-email "Alice" 300 "hello")
                                        (make-email "Bob" 200 "hi")
                                        (make-email "Chandra" 100 "hey"))) #t)
(check-expect (email-date-sorted? sample) #f)
(check-expect (email-date-sorted? '()) #t)
(define (email-date-sorted? loe)
  (cond
    [(>= 1 (length loe)) #t]
    [else (and (>= (email-date (first loe)) (email-date (second loe))) (email-date-sorted? (rest loe)))]))

; List-of-emails -> List-of-emails
; returns the list of emails sorted by date
(check-satisfied (sort-by-date sample) email-date-sorted?)
(check-expect (sort-by-date '()) '())
(define (sort-by-date loe)
  (cond
    [(empty? loe) '()]
    [(cons? loe) (insert (first loe) (sort-by-date (rest loe)))]))

; Email List-of-emails -> List-of-emails
; inserts the email into the sorted list
(check-expect (insert (make-email "Alice" 200 "hey")
                      (list (make-email "Alice" 300 "howdy") (make-email "Alice" 100 "hello")))
              (list (make-email "Alice" 300 "howdy") (make-email "Alice" 200 "hey") (make-email "Alice" 100 "hello")))
(check-expect (insert (make-email "Alice" 200 "hey") '()) (list (make-email "Alice" 200 "hey")))
(define (insert em loe)
  (cond
    [(empty? loe) (cons em '())]
    [else (if (>= (email-date em) (email-date (first loe)))
              (cons em loe)
              (cons (first loe) (insert em (rest loe))))]))
