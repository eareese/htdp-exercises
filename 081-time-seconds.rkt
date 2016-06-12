#lang htdp/bsl

(define-struct time [hours minutes seconds])

; Time -> Number
; interpretation the number of seconds that have passed since
; midnight at a given Time
(check-expect (time->seconds (make-time 12 30 2)) 45002)
(define (time->seconds t)
  (+
   (* 60 60 (time-hours t))
   (* 60 (time-minutes t))
   (time-seconds t)))
