#lang htdp/bsl+
;;---------------------------------------------------------------------------------------------------

;; Exercise 202. Design select-album. The function consumes the title of an album and an LTracks. It
;; extracts from the latter the list of tracks that belong to the given album.

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


; String LTracks -> LTracks
; consumes an album title and an LTracks, produces the LTracks which belong to the given album
(check-expect (length (select-album TITLE itunes-tracks))
              (length BKG))
(check-expect (member? track8 (select-album TITLE itunes-tracks)) #t)
(check-expect (member? track3 (select-album TITLE itunes-tracks)) #t)
(check-expect (member? track7 (select-album TITLE itunes-tracks)) #t)
(check-expect (member? track10 (select-album TITLE itunes-tracks)) #t)
(check-expect (member? track9 (select-album TITLE itunes-tracks)) #t)
(check-expect (member? track2 (select-album TITLE itunes-tracks)) #t)
(check-expect (select-album "thereisnoalbumwiththistitleinmycollection" itunes-tracks) '())
(check-expect (select-album "Blue Kentucky Girl" '()) '())
(define (select-album str tracks)
  (cond
    [(empty? tracks) '()]
    [else (if (string=? str (track-album (first tracks)))
              (cons (first tracks) (select-album str (rest tracks)))
              (select-album str (rest tracks)))]))
