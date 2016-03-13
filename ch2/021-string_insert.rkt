#lang htdp/bsl

; assume 0 <= i <= string length
(define (string-insert str i)
  ; return "_" alone if passed an empty string
  (string-append
   (substring str 0 i)
   "_"
   (substring str i)))

(check-expect (string-insert "hello" 0) "_hello")
(check-expect (string-insert "hello" 5) "hello_")
(check-expect (string-insert "hello" 3) "hel_lo")
(check-expect (string-insert "" 0) "_")

; copes with empty strings if assumption is met
