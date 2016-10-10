#lang htdp/bsl

(define-struct phone [area number])
; (make-phone 101 "776-1099")


(define-struct phone# [area switch num])
; intervals? dunno about phone number rules, but assuming each is a
; number from 0 to 999 or 9999
; - area [0, 999]
; - switch [0, 999]
; - num [0, 9999]
; (make-phone 101 776 1099)
