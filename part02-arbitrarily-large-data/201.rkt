#lang htdp/bsl+
;;---------------------------------------------------------------------------------------------------

;; Exercise 201. Design select-all-album-titles. The function consumes an LTracks and produces the
;; list of album titles as a List-of-strings.

;; Also design the function create-set. It consumes a List-of-strings and constructs one that
;; contains every String from the given list exactly once. Hint If String s is at the front of the
;; given list and occurs in the rest of the list, too, create-set does not keep s.

;; Finally design select-album-titles/unique, which consumes an LTracks and produces a list of unique
;; album titles. Use this function to determine all album titles in your iTunes collection and also
;; find out how many distinct albums it contains.

(require 2htdp/itunes)

(define ITUNES-LOCATION "itunes.xml")

; LTracks
(define itunes-tracks (read-itunes-as-tracks ITUNES-LOCATION))

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
(define TEST-TRACK3
  (create-track "Everytime You Leave"
                "Emmylou Harris"
                "Blue Kentucky Girl"
                180349
                8
                (create-date 2016 10 23 17 28 22)
                1
                (create-date 2016 12 28 17 50 31)))
(define TEST-LTRACK (list TEST-TRACK1 TEST-TRACK2 TEST-TRACK3))

; LTracks -> List-of-strings
; consumes a List-of-tracks and produces the list of album titles
(check-expect (length (select-all-album-titles TEST-LTRACK))
              (length TEST-LTRACK))
(check-expect (member? (track-album TEST-TRACK1) (select-all-album-titles TEST-LTRACK)) #t)
(check-expect (member? (track-album TEST-TRACK2) (select-all-album-titles TEST-LTRACK)) #t)
(check-expect (member? (track-album TEST-TRACK3) (select-all-album-titles TEST-LTRACK)) #t)
(check-expect (select-all-album-titles '()) '())
(define (select-all-album-titles tracks)
  (cond
    [(empty? tracks) '()]
    [else (cons (track-album (first tracks)) (select-all-album-titles (rest tracks)))]))

; List-of-strings -> List-of-strings
; produces a new List-of-strings that contains every String from the given list exactly once
(check-expect (create-set (list "a" "a" "a")) (list "a"))
(check-expect (length (create-set (list "a" "a" "a"))) 1)
(check-expect (create-set (list "a")) (list "a"))
(check-expect (length (create-set (list "a"))) 1)
(check-expect (create-set '()) '())
(define (create-set los)
  (cond
    [(empty? los) '()]
    [else (if (member? (first los) (rest los))
              (create-set (rest los))
              (cons (first los) (create-set (rest los))))]))


; LTracks -> List-of-unique-album-titles
; consumes an LTracks and produces a list of unique album titles
(check-expect (length (select-album-titles/unique TEST-LTRACK)) 2)
(check-expect (member? (track-album TEST-TRACK1) (select-album-titles/unique TEST-LTRACK)) #t)
(check-expect (member? (track-album TEST-TRACK2) (select-album-titles/unique TEST-LTRACK)) #t)
(check-expect (member? (track-album TEST-TRACK3) (select-album-titles/unique TEST-LTRACK)) #t)
(check-expect (select-album-titles/unique '()) '())
(define (select-album-titles/unique tracks)
  (create-set (select-all-album-titles tracks)))


; all album titles in my collection
(define ALL-ALBUM-TITLES (select-all-album-titles itunes-tracks))
; how many total album titles (non-unique)
(length ALL-ALBUM-TITLES)
; 1476

; unique titles in my collection
(define UNIQUE-ALBUM-TITLES (select-album-titles/unique itunes-tracks))
; how many unique album titles?
(length UNIQUE-ALBUM-TITLES)
; 227
