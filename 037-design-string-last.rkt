#lang htdp/bsl

; Exercise 37. Design the function string-last, which extracts the last
; character from a non-empty string.

; 1.
; how to represent information as data?
; input is a non-empty string, output is the last character of that string.

; 2.
; signature
; String -> String

; purpose statement
; computes a substring of length 1 from the end of a given string.

; header
; (define (string-last str) "a")

; 3. illustrate with functional examples
; String -> String
; computes a substring of length 1 from the end of a given string.
; given: "asdf", expect: "f"
; given: "hello world", expect: "d"
; (define (string-last str) "a")

; 4. take inventory
; (define (string-last str)
;   (substring str ...))

; 5. code
(define (string-last str)
  (substring str (- (string-length str) 1)))

; 6. test
(string-last "asdf")

(check-expect (string-last "really me") "e")
