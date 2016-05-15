#lang htdp/bsl

; Exercise 40. Design the function string-remove-last, which produces a string
; like the given one with the last character removed.

; 1. how to represent info as data
; strings gonna string. (assume non-empty strings)

; 2. signature, purpose statement, function header
; String -> String
; take a non-empty string and compute the result of removing the last character
; from the original string.
; (define (string-remove-last str) "spiri")

; 3. functional examples
; String -> String
; take a non-empty string and compute the result of removing the last character
; from the original string.
; given: "spring", expect: "sprin"
; given: "hello world", expect: "hello worl"
; (define (string-remove-last str) "spiri")

; 4. take inventory
; (define (string-remove-last str)
;   (... str ...))

; 5. code
(define (string-remove-last str)
  (substring str 0 (- (string-length str) 1)))

; 6. test
(string-remove-last "hello")
(string-remove-last "z")

(check-expect (string-remove-last "jelly") "jell")
