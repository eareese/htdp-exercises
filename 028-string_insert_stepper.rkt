#lang htdp/bsl

#| use the stepper |#
(define (string-insert s i)
  (string-append (substring s 0 i) "_" (substring s i)))
(string-insert "helloworld" 6)
