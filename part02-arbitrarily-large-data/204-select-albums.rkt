#lang htdp/bsl+
;;---------------------------------------------------------------------------------------------------

(require 2htdp/itunes)
(define ITUNES-LOCATION "itunes.xml")
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
(define bkg-title "Blue Kentucky Girl")
(define list-bkg (list track9 track8 track2 track3 track7 track10))
(define track-gh
  (create-track
   "Blue Kentucky Girl"
   "Emmylou Harris"
   "Greatest Hits"
   200045
   1
   (create-date 2016 10 23 17 28 22)
   1
   (create-date 2016 12 30 15 59 41)))
(define list2 (list track-gh track9 track8 track2 track3 track7 track10))


;; Exercise 204. Design select-albums. The function consumes an element of LTracks. It produce a list
;; of LTracks, one per album. Each album is uniquely identified by its title and shows up in the
;; result only once. Hints (1) You want to use some of the solutions of the preceding exercises.
;; (2) The function that groups consumes two lists: the list of album titles and the list of tracks;
;; it considers the latter as atomic until it is handed over to an auxiliary function.
;; See exercise 196.

; LLT
; List of list of tracks. It is one of:
; - '()
; - (cons LTrack LLT)

; LTracks -> List-of-LTracks
; produces a List-of-list-of-tracks, one LTrack per unique album title
(check-expect (length (select-albums list-bkg)) 1)
(check-expect (length (select-albums list2)) 2)
;; TODO more tests on result contents
(check-expect (select-albums '()) '())
(define (select-albums tracks)
  (cond
    [(empty? tracks) '()]
    [else (magic (select-album-titles/unique tracks) tracks)]))

; List-of-titles LTracks -> LLT
; consumes a list of Strings representing album titles, and a LTracks. produces the per-album LLT
(check-expect (length (magic (list bkg-title "Greatest Hits") list2)) 2)
(check-expect (length (magic (list bkg-title) list2)) 1)
(check-expect (magic '() list-bkg) '())
(define (magic titles tracks)
  (cond
    [(empty? titles) '()]
    [else (cons
           (select-album (first titles) tracks)
           (magic (rest titles) tracks))]))

; String LTracks -> LTracks
; consumes an album title and an LTracks, produces the LTracks which belong to the given album
(check-expect (length (select-album bkg-title itunes-tracks))
              (length list-bkg))
(check-expect (member? track8 (select-album bkg-title itunes-tracks)) #t)
(check-expect (member? track3 (select-album bkg-title itunes-tracks)) #t)
(check-expect (member? track7 (select-album bkg-title itunes-tracks)) #t)
(check-expect (member? track10 (select-album bkg-title itunes-tracks)) #t)
(check-expect (member? track9 (select-album bkg-title itunes-tracks)) #t)
(check-expect (member? track2 (select-album bkg-title itunes-tracks)) #t)
(check-expect (select-album "thereisnoalbumwiththistitleinmycollection" itunes-tracks) '())
(check-expect (select-album bkg-title '()) '())
(define (select-album str tracks)
  (cond
    [(empty? tracks) '()]
    [else (if (string=? str (track-album (first tracks)))
              (cons (first tracks) (select-album str (rest tracks)))
              (select-album str (rest tracks)))]))

; LTracks -> List-of-unique-album-titles
; consumes an LTracks and produces a list of unique album titles
(check-expect (length (select-album-titles/unique TEST-LTRACK)) 2)
(check-expect (member? (track-album TEST-TRACK1) (select-album-titles/unique TEST-LTRACK)) #t)
(check-expect (member? (track-album TEST-TRACK2) (select-album-titles/unique TEST-LTRACK)) #t)
(check-expect (member? (track-album TEST-TRACK3) (select-album-titles/unique TEST-LTRACK)) #t)
(check-expect (select-album-titles/unique '()) '())
(define (select-album-titles/unique tracks)
  (create-set (select-all-album-titles tracks)))

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
