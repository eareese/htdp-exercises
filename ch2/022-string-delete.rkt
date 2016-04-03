#lang htdp/bsl

; assume 0 <= i < string length
(define (string-delete str i)
  (string-append (substring str 0 i)
                 (substring str (+ i 1))))

; can string-delete deal with empty strings?
; well, it seems impossible to meet the assumption for both:
;  A)  0 <= i
;  B)  i < string length
;
; if B) is true and the string length is 0, then i must be less than 0, which
; violates A).

(check-expect (string-delete "hello" 0) "ello")
(check-expect (string-delete "hello" 2) "helo")
(check-expect (string-delete "hello" 4) "hell")
