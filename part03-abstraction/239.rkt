;;---------------------------------------------------------------------------------------------------
#lang htdp/isl

;; Exercise 239. A list of two items is another frequently used form of data in ISL programming.
;; Here is data definition with two parameters:

;; A [List X Y] is a structure:
;;   (cons X (cons Y '()))

;; Instantiate this definition to describe the following classes of data:
;;   - pairs of Numbers,
;;   - pairs of Numbers and 1Strings, and
;;   - pairs of Strings and Booleans.

;; A [List N1 N2] is a structure:
;;  (cons Number (cons Number '()))
(cons 0 (cons 12 '()))

;; A [List Number 1String] is a structure:
;;   (cons Number (cons 1String '()))
(cons 11 (cons "b" '()))

;; A [List String Boolean] is a structure:
;;   (cons String (cons Boolean '()))
(cons "amaze" (cons #t '()))

;; Also make one concrete example for each of these three data definitions.
