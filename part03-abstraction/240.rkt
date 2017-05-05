;;---------------------------------------------------------------------------------------------------
#lang htdp/isl

;; Exercise 240. Here are two strange but similar data definitions:
;; ; A LStr is one of:
;; ; – String
;; ; – (make-layer LStr)

;; ; A LNum is one of:
;; ; – Number
;; ; – (make-layer LNum)
;; Both data definitions rely on this structure type definition:
;; (define-struct layer [stuff])

;; Both define nested forms of data: one is about numbers and the other about strings. Make examples
;; for both. Abstract over the two. Then instantiate the abstract definition to get back the
;; originals.

; LStr
(define some-lstr "hello")
(define another-lstr (make-layer "wow"))
(define yet-another-lstr (make-layer some-lstr))

; LNum
(define some-lnum 99)
(define another-lnum (make-layer 101))
(define yet-another-lstr (make-layer some-lnum))

;; A LItm is one of:
;; - ITEM
;; - (make-layer LItm)

(define some-item "99")
(define another-item (make-layer "wow"))
(define yet-another-item (make-layer some-item))

