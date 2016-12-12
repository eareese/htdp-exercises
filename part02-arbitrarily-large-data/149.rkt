#lang htdp/bsl
(require 2htdp/image)

;; Exercise 149. Does copier function properly when you apply it to a natural
;; number and a Boolean or an image? Or do you have to design another function?
;; Read Similarities Everywhere for an answer.

;; An alternative definition of copier might use else:

;; (define (copier.v2 n s)
;;   (cond
;;     [(zero? n) '()]
;;     [else (cons s (copier.v2 (sub1 n) s))]))

;; How do copier and copier.v2 behave when you apply them to 0.1 and "x"?
;; Explain. Use DrRacket’s stepper to confirm your explanation.


(define CIR (circle 20 "solid" "blue"))

; N String -> List-of-things ???
; creates a list of n copies of s
; Check whether copier works on images, Booleans
(check-expect (copier 2 CIR)
              (cons CIR (cons CIR '())))
(check-expect (copier 2 #f)
              (cons #f (cons #f '())))
(check-expect (copier 0 "hello") '())
(check-expect (copier 2 "hello")
              (cons "hello" (cons "hello" '())))
(define (copier n s)
  (cond
    [(zero? n) '()]
    [(positive? n) (cons s (copier (sub1 n) s))]))


;; All tests passed! Our function does not care what type of data to copy,
;; it will return a list of Booleans or images.
