#lang htdp/bsl

(define (bool-imply sunny friday)
  (if (or (and #t friday) (not sunny))
      #t
      #f))

(check-expect (bool-imply #t #t) #t)
(check-expect (bool-imply #t #f) #f)
(check-expect (bool-imply #f #t) #t)
(check-expect (bool-imply #f #f) #t)
