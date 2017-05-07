;;---------------------------------------------------------------------------------------------------
#lang htdp/isl

;; Here is one more parametric data definition:
;; ; A [Maybe X] is one of:
;; ; – #false
;; ; – X
;; Interpret these data definitions: [Maybe String], [Maybe [List-of String]], and [List-of [Maybe String]].

;; [Maybe String] -> either #f or the string
;; [Maybe [List-of String]] -> either #f or a list of strings
;; [List-of [Maybe String]] -> a list composed of either strings or #f


;; What does the following function signature mean:
;; ; String [List-of String] -> [Maybe [List-of String]]
;; ; returns the remainder of los starting with s
;; ; #false otherwise
;; (check-expect (occurs "a" (list "b" "a" "d" "e"))
;;               (list "d" "e"))
;; (check-expect (occurs "a" (list "b" "c" "d")) #f)
;; (define (occurs s los)
;;   los)
;; Work through the remaining steps of the design recipe.

; String [List-of String] -> [Maybe [List-of String]]
; returns the remainder of los starting with s
; #false otherwise
; INTERP give back the rest of the list when the passed String is found in the List-of String,
; otherwise return #f when the String is not found in the List-of.
(check-expect (occurs "a" (list "b" "a" "d" "e"))
              (list "d" "e"))
(check-expect (occurs "a" (list "b" "c" "d")) #f)
(define (occurs s los)
  (cond
    [(empty? los) #f]
    [(string=? s (first los)) (rest los)]
    [else (occurs s (rest los))]))
