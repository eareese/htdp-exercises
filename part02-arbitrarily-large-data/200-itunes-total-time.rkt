#lang htdp/bsl+
;;---------------------------------------------------------------------------------------------------

;; Exercise 200. Design the function total-time, which consumes an element of LTracks and produces
;; the total amount of play time. Once the program is done, compute the total play time of your
;; iTunes collection.

(require 2htdp/itunes)

(define ITUNES-LOCATION "itunes.xml")

; LTracks
;; (define itunes-tracks (read-itunes-as-tracks ITUNES-LOCATION))


;; TEST HELPERS
(define TEST-TRACK1
  (create-track "Nearly Midnight, Honolulu"
                "Neko Case"
                "The Worse Things Get, The Harder I Fight, The Harder I Fight, The More I Love You"
                157204
                6
                (create-date 2016 10 8 17 59 0)
                7
                (create-date 2016 11 6 21 50 58)))
(define TEST-TRACK2
  (create-track "Blue Kentucky Girl"
                "Emmylou Harris"
                "Blue Kentucky Girl"
                200045
                9
                (create-date 2016 10 23 17 28 22)
                17
                (create-date 2016 12 30 15 59 41)))
(define TEST-LTRACK (list TEST-TRACK1 TEST-TRACK2))
; LTracks -> Number
; consumes a List-of-tracks and produces the total amount of play time in ms
(check-expect (total-time TEST-LTRACK) (+ (track-time TEST-TRACK1) (track-time TEST-TRACK2)))
(check-expect (total-time (list TEST-TRACK2)) (track-time TEST-TRACK2))
(check-expect (total-time '()) 0)
(define (total-time tracks)
  (cond
    [(empty? tracks) 0]
    [else (+ (track-time (first tracks)) (total-time (rest tracks)))]))


;; TOTAL
;; (total-time itunes-tracks)

; 399722535
; That's about 4.6 days' worth.
