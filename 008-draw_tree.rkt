;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex08-picture_tree) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

; exercise 8. draw a tree

(define trunk (rectangle 15 85 "solid" "brown"))

(define leaves (circle 55 "solid" "green"))

(place-image (overlay/offset leaves 0 41 trunk)
             100 100
             (empty-scene 200 200))




