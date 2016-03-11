;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex07-picture_boat) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

; exercise 7. use picture primitives to draw a simple boat

(define ocean (rectangle 200 85 "solid" "blue"))

; Resourceful Raft
(define boat (rectangle 100 20 "solid" "brown"))

(place-image (overlay/offset boat 0 41 ocean)
             100 158
             (empty-scene 200 200))




