#lang htdp/bsl+
;;---------------------------------------------------------------------------------------------------
(require 2htdp/itunes)
(define ITUNES-LOCATION "itunes.xml")

; the 2htdp/itunes library documentation, part 2:

; An LLists is one of:
; – '()
; – (cons LAssoc LLists)

; An LAssoc is one of:
; – '()
; – (cons Association LAssoc)
;
; An Association is a list of two items:
;   (cons String (cons BSDN '()))

; A BSDN is one of:
; – Boolean
; – Number
; – String
; – Date

; String -> LLists
; creates a list of lists representation for all tracks in
; file-name, which must be an XML export from iTunes
;; (define (read-itunes-as-lists file-name)
;;   ...)


;; Exercise 205. Develop examples of LAssoc and LLists, that is, the list representation of tracks
;; and lists of such tracks.


; Association examples
(define myassoc (list "string" #f))
(define another-assoc (list "just a string" 999))

; LAssoc examples
(define lassoc1 '())
(define lassoc2 (list myassoc another-assoc))
(define another-lassoc (list another-assoc))

; LList examples
(define llist0 '())
(define llist1 (list lassoc2))
(define llist2 (list (list (list "string" #t)) lassoc2))

(read-itunes-as-lists ITUNES-LOCATION)
