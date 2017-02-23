#lang htdp/bsl+
;;---------------------------------------------------------------------------------------------------

;; Exercise 203. Design select-album-date. The function consumes the title of an album, a date, and
;; an LTracks. It extracts from the latter the list of tracks that belong to the given album and
;; have been played after the given date. Hint You must design a function that consumes two Dates
;; and determines whether the first occurs before the second.

(require 2htdp/itunes)
(define ITUNES-LOCATION "itunes.xml")

; LTracks
(define itunes-tracks (read-itunes-as-tracks ITUNES-LOCATION))

(define track9
  (create-track
   "Blue Kentucky Girl"
   "Emmylou Harris"
   "Blue Kentucky Girl"
   200045
   9
   (create-date 2016 10 23 17 28 22)
   17
   (create-date 2016 12 30 15 59 41)))
(define track8
  (create-track
   "Everytime You Leave"
   "Emmylou Harris"
   "Blue Kentucky Girl"
   180349
   8
   (create-date 2016 10 23 17 28 22)
   1
   (create-date 2016 12 28 17 50 31)))
(define track2
  (create-track
   "Beneath Still Waters"
   "Emmylou Harris"
   "Blue Kentucky Girl"
   222484
   2
   (create-date 2016 10 23 17 28 22)
   1
   (create-date 2017 1 8 14 22 11)))
(define track3
  (create-track
   "Rough and Rocky"
   "Emmylou Harris"
   "Blue Kentucky Girl"
   234109
   3
   (create-date 2016 10 23 17 28 22)
   1
   (create-date 2016 11 10 9 28 13)))
(define track7
  (create-track
   "They'll Never Take His Love from Me"
   "Emmylou Harris"
   "Blue Kentucky Girl"
   158615
   7
   (create-date 2016 10 23 17 28 22)
   1
   (create-date 2016 12 9 18 26 6)))
(define track10
  (create-track
   "Even Cowgirls Get the Blues"
   "Emmylou Harris"
   "Blue Kentucky Girl"
   237008
   10
   (create-date 2016 10 23 17 28 22)
   1
   (create-date 2016 12 9 19 5 23)))
(define BKG (list track9 track8 track2 track3 track7 track10))
(define TITLE "Blue Kentucky Girl")
(define DATE (create-date 2017 1 1 2 0 0))

; String Date LTracks -> LTracks
; produces a List-of-tracks where the track album title matches the given String and the track's last
; played date is after the Date given.
(check-expect (select-album-date TITLE DATE itunes-tracks)
              (list track2))
(check-expect (select-album-date TITLE DATE '()) '())
(define (select-album-date album played tracks)
  (cond
    [(empty? tracks) '()]
    [else (if (and (string=? album (track-album (first tracks)))
                   (before? played (track-played (first tracks))))
              (cons (first tracks) (select-album-date album played (rest tracks)))
              (select-album-date album played (rest tracks)))]))

; Date Date -> Boolean
; produces #true if the first date occurs before the second date
(check-expect (before? (create-date 2016 12 31 23 59 59) (create-date 2017 1 1 0 0 0)) #t)
(check-expect (before? (create-date 2017 1 1 0 0 0) (create-date 2016 12 31 23 59 59)) #f)
(check-expect (before? (create-date 2017 1 1 0 0 0) (create-date 2017 1 1 0 0 1)) #t)
(check-expect (before? (create-date 2017 1 1 0 0 0) (create-date 2017 1 1 0 0 0)) #f) ;; identical
(check-expect (before? (create-date 2017 2 1 0 0 0) (create-date 2017 1 1 23 59 59)) #f)
(define (before? d1 d2)
  (cond
    [(< (date-year d1) (date-year d2)) #t]
    [(> (date-year d1) (date-year d2)) #f]
    [(< (date-month d1) (date-month d2)) #t]
    [(> (date-month d1) (date-month d2)) #f]
    [(< (date-day d1) (date-day d2)) #t]
    [(> (date-day d1) (date-day d1)) #f]
    [(< (date-hour d1) (date-hour d2)) #t]
    [(> (date-hour d1) (date-hour d1)) #f]
    [(< (date-minute d1) (date-minute d2)) #t]
    [(> (date-minute d1) (date-minute d1)) #f]
    [(< (date-second d1) (date-second d2)) #t]
    [else #f]))
