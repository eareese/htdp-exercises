#lang htdp/bsl

(define (string-first str)
  (substring str 0 1))

(check-expect (string-first "hello") "h")
