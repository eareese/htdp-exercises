;;---------------------------------------------------------------------------------------------------
#lang htdp/bsl
(require 2htdp/image)

; A FSM is one of:
;   – '()
;   – (cons Transition FSM)

(define-struct transition [current next])
; A Transition is a structure:
;   (make-transition FSM-State FSM-State)

; FSM-State is a Color.

; interpretation A FSM represents the transitions that a
; finite state machine can take from one state to another
; in reaction to key strokes


;; Exercise 226. Design state=?, an equality predicate for states.

; FSM-State FSM-State -> Boolean
; produces true if the two FSM-States are the same color
(check-expect (state=? "blue" "blue") #t)
(check-expect (state=? "blue" "Blue") #t)
(check-expect (state=? "BLUE" "Blue") #t)
(check-expect (state=? "blue" "green") #f)
(define (state=? s1 s2)
  (and (image-color? s1) (image-color? s2)
       (string-ci=? s1 s2)))
