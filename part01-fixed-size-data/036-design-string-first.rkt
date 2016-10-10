#lang htdp/bsl

; Exercise 36. Design the function string-first, which extracts the first
; character from a non-empty string. Don’t worry about empty strings.

; 1. how to represent information as data
; the input is some non-empty string, and the output is another string. a character is a string with length 1.

; 2. signature, purpose statement, function header
; signature
; String -> String

; purpose statement
; the function computes the first character (substring of length 1) from a
; non-empty string.

; header
; (define (string-first str) "a")

; 3. functional examples
; String -> String
; computes a non-empty string's first substring of length 1
; given: "asdf", expect: "a"
; given: "hello world", expect: "h"
; (define (string-first str) "a")

; 4. take inventory
; String -> String
; computes a non-empty string's first substring of length 1
; given: "asdf", expect: "a"
; given: "hello world", expect: "h"
(define (string-first str)
  (substring str 0 1))

(string-first "hello world")


