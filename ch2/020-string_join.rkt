#lang htdp/bsl

(define (string-join str1 str2)
  (string-append str1 "_" str2))

(check-expect (string-join "hello" "world") "hello_world")
