#lang htdp/bsl+
;;---------------------------------------------------------------------------------------------------
;; Exercise 199. While the important data definitions are already provided, the first step of the
;; design recipe is still incomplete. Make up examples of Dates, Tracks, and LTracks. These examples
;; come in handy for the following exercises as inputs.

; Dates
(define-struct date [year month day hour minute second])
; a Date is a structure:
;   (make-date N N N N N N)
; interpretation An instance records six pieces of information: the date's year, month (between 1 and
; 12 inclusive), day (between 1 and 31), hour (between 0 and 23), minute (between 0 and 59), and 
; second (also between 0 and 59).
(define TEST-DATE1
  (create-date 2001 2 1 8 59 59))
(define TEST-DATE2
  (create-date 2017 1 9 5 57 01))


; Tracks
(define-struct track
  [name artist album time track# added play# played])
; A Track is a structure:
;   (make-track String String String N N Date N Date)
; interpretation An instance records in order: the track's title, its producing artist, to which
; album it belongs, its playing time in milliseconds, its position with the album, the date it was
; added, how often it has been played, and the date when it was last played
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


; LTracks
; An LTrack is one of:
; - '()
; - (cons Track LTrack)
; interpretation List of Tracks
(define TEST-LTRACK (list TEST-TRACK1 TEST-TRACK2))
