#lang htdp/bsl

;; Exercise 166. The wage*.v2 function consumes a list of work records and produces a list of numbers. Of course, functions may also produce lists of structures.
;;
;; Develop a data representation for pay checks. Assume that a pay check contains two distinctive pieces of information: the employee’s name and an amount. Then design the function wage*.v3. It consumes a list of work records and computes a list of pay checks from it, one per record.
;;
;; In reality, a pay check also contains an employee number. Develop a data representation for employee information and change the data definition for work records so that it uses employee information and not just a string for the employee’s name. Also change your data representation of pay checks so that it contains an employee’s name and number, too. Finally, design wage*.v4, a function that maps lists of revised work records to lists of revised pay checks.
;;
;; Note on Iterative Refinement This exercise demonstrates the iterative refinement of a task. Instead of using data representations that include all relevant information, we started from simplistic representation of pay checks and gradually made the representation realistic. For this simple program, refinement is overkill; later we will encounter situations where iterative refinement is not just an option but a necessity.


(define-struct worker [number name])
;; A Worker is a structure:
;; (make-worker Number String)
;; interpretation (make-worker i n) represents a worker with
;; employee number i and name n

(define-struct work [worker rate hours])
;; A (piece of) Work is a structure:
;;   (make-work Worker Number Number)
;; interpretation (make-work n r h) combines the worker
;; with the pay rate r and the number of hours h.

;; Low (short for list of works) is one of:
;; - '()
;; - (cons Work Low)
;; interpretation an instance of Low represents the
;; hours worked for a number of employees.

(define-struct paycheck [worker amount])
; A paycheck is a structure:
;   (make-paycheck Worker Number)
; interpretation (make-paycheck name amt) combines the worker's info
; with the weekly wages amount.

; Low -> List-of-numbers
; consumes list of weekly work records
; produces list of pay amounts per record
(check-expect (wage*.v3 '()) '())
(check-expect
 (wage*.v3 (cons (make-work "Me" 999 4) '()))
 (cons (* 999 4) '()))
(define (wage*.v3 lowr)
  (cond
    [(empty? lowr) '()]
    [(cons? lowr) (cons (* (work-rate (first lowr)) (work-hours (first lowr)))
                        (wage*.v3 (rest lowr)))]))


; Low -> List-of-paychecks
; consumes list of weekly work records
; produces list of paychecks by computing weekly wages per record
(check-expect (wage*.v4 '()) '())
(define ALICE (make-worker 1 "Alice"))
(define BOB (make-worker 2 "Bob"))
(check-expect (wage*.v4 (cons (make-work ALICE 100.0 10) '()))
              (cons (make-paycheck ALICE (* 100.0 10)) '()))
(check-expect (wage*.v4 (cons (make-work BOB 10.0 40) (cons (make-work ALICE 100.0 10) '())))
              (cons (make-paycheck BOB (* 10.0 40)) (cons (make-paycheck ALICE (* 100.0 10)) '())))
(define (wage*.v4 lowr)
  (cond
    [(empty? lowr) '()]
    [(cons? lowr) (cons
                   (make-paycheck (work-worker (first lowr))
                                  (* (work-rate (first lowr)) (work-hours (first lowr))))
                   (wage*.v4 (rest lowr)))]))
