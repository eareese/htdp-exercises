;;---------------------------------------------------------------------------------------------------
#lang htdp/isl

;; Exercise 241. Compare the definitions for NEList-of-temperatures and NEList-of-Booleans. Then
;; formulate an abstract data definition NEList-of.

; A NEList-of-temperatures is one of:
; – (cons CTemperature '())
; – (cons CTemperature NEList-of-temperatures)
; interpretation non-empty lists of Celsius temperatures

; A NEList-of-Booleans is one of:
; - (cons #true '())
; - (cons #false '())
; - (cons #true NEList-of-Booleans)
; - (cons #false NEList-of-Booleans)
; interpretation non-empty lists of Boolean values

; A NEList-of is one of:
; - (cons ITEM '())
; - (cons ITEM NEList-of)
; interpretation non-empty list of some items
