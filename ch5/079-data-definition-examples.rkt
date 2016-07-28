; Create examples for the following data definitions:

;; A Color is one of:
;; - "white"
;; - "yellow"
;; - "orange"
;; - "green"
;; - "red"
;; - "blue"
;; - "black"
; ex: "purple"

;; H (a "happiness scale value") is a number in [0,100]
;; i.e., a number between 0 and 100
; ex: 3, or 0, or 78, or 100

(define-struct person [fstname lstname male?])
; Person is (make-person String String Boolean)
; ex:
; (define MS (make-person "Martha" "Stewart" #f))

; idk, is it a good idea to use a field name that looks like the
; name of a predicate?? it hints to you that the value involved is
; gonna be Boolean, for sure. but from a design standpoint, it
; might not be a necessary tactic? surely not in this case :/


(define-struct dog [owner name age happiness])
; Dog is (make-dog Person String PositiveInteger H)
; ex:
; (define pooch (make-dog MS "Doily" 3 50))
; interpretation:
; a dog has an owner which is a Person,
; a name which is represented with a String,
; an age which is a positive integer
; and a "happiness scale value"


; Weapon is one of:
; - #false
; - Posn
; interpretation #false means the missile hasn't been fired yet;
; an instance of Posn means the missile is in flight
; ex: #f
; ex: (make-posn 20 10)
