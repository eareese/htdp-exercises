#lang htdp/bsl

(define (string-last str)
  (substring str
             ; start index
             (- (string-length str) 1)))

(check-expect (string-last "hello") "o")
(check-expect (string-last "z") "z")
