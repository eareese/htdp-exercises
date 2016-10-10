#lang htdp/bsl

; Exercise 39. Design the function string-rest, which produces a string like
; the given one with the first character removed.

; I guess, like the other examples, we are assuming non-empty input strings
; and/or if the input is a 1-character string, return an empty string

; 1. how to represent info as data?
; input is a string, and we expect to get back the same string except with
; the first character removed.
; "hello world" -> "ello world"

; 2. signature, purpose statement, function header
; String -> String
; compute the "rest" string, which is the original string without its first
; character
; (define (string-rest str) "oop")

; 3. functional examples
; String -> String
; compute the "rest" string, which is the original string without its first
; character
; given: "hello world", expect: "ello world"
; given: "asdf", expect: "sdf"
; given: "a", expect: ""
; (define (string-rest str) "oop")

; 4. take inventory
; (define (string-rest str)
;   (... str ...))

; 5. code
(define (string-rest str)
  (substring str 1))

; 6. test
(string-rest "hello")
(string-rest "b")

(check-expect (string-rest "wtf") "tf")
