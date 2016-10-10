#lang htdp/bsl
(require 2htdp/image)

;; Exercise 142. Design ill-sized?. The function consumes a list of images loi and a positive number n. It produces the first image on loi that is not an n by n square; if it cannot find such an image, it produces #false.

;; Hint Use

;; ; ImageOrFalse is one of:
;; ; – Image
;; ; – #false

;; for the result part of the signature.

; A List-of-images is one of:
; - '()
; - (cons Image List-of-images)

; ImageOrFalse is one of:
; – Image
; – #false

; List-of-images PositiveNumber -> ImageOrFalse
; consumes a List-of-images loi and a positive number n, then it
; produces the first image on loi that is NOT an n x n square.
; If such an image is not found, it produces #false.
(define SQ25 (rectangle 25 25 "solid" "blue"))
(define SQ9 (rectangle 9 9 "solid" "blue"))
(define R5 (rectangle 5 25 "solid" "blue"))
(check-expect (ill-sized?
               (cons SQ25 (cons SQ9 (cons R5 '())))
               25)
              SQ9)
(check-expect (ill-sized?
               (cons R5 (cons SQ9 '())) 9) R5)
(check-expect (ill-sized?
               (cons SQ9 '()) 9) #f)
(define (ill-sized? loi n)
  (cond [(empty? loi) #f]
        [(cons? loi)
         (if (and
              (not (eq? (image-width (first loi)) n))
              (not (eq? (image-height (first loi)) n)))
             (first loi)
             (ill-sized? (rest loi) n))]))
