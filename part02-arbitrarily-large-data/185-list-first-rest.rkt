#lang htdp/bsl+
;;---------------------------------------------------------------------------------------------------

;; Exercise 185. You know about first and rest from BSL, but BSL+ comes with even more selectors than that. Determine the values of the following expressions:

;; (first (list 1 2 3))
;; (rest (list 1 2 3))
;; (second (list 1 2 3))

;; Find out from the documentation whether third and fourth exist.
;;---------------------------------------------------------------------------------------------------

;; (first (list 1 2 3))
; 1

;; (rest (list 1 2 3))
; '(2 3)

;; (second (list 1 2 3))
; 2


;; Yes, third and fourth procedures exist. So do fifth, sixth, seventh, ..., tenth. There's also the
;; handy `nth` which allows you to specify n and a sequence, to get the nth item from it.
