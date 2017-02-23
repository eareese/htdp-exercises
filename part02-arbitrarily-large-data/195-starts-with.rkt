#lang htdp/bsl+
;;---------------------------------------------------------------------------------------------------
(require 2htdp/batch-io)

(define DICTIONARY-LOCATION "/usr/share/dict/words")

; a Dictionary is a List-of-strings
(define DICTIONARY-AS-LIST (read-lines DICTIONARY-LOCATION))


; a Letter is one of the following 1Strings:
; - "a"
; - ...
; - "z"
; or, equivalently, a member? of this list:
(define LETTERS
  (explode "abcdefghijklmnopqrstuvwxyz"))

;; Exercise 195. Design the function starts-with#, which consumes a Letter and Dictionary and then
;; counts how many words in the given Dictionary start with the given Letter. Once you know that your
;; function works, determine how many words start with "e" in your computer’s dictionary and how many
;; with "z".

; Letter Dictionary -> Number
; produces the count of how many words in the given dictionary begin with the given letter
(check-expect (starts-with# "a" (list "asphalt" "hello" "aye")) 2)
(check-expect (starts-with# "g" (list "good" "great" "okay" "green")) 3)
(check-expect (starts-with# "a" '()) 0)
(define (starts-with# letter dict)
  (cond
    [(empty? dict) 0]
    [else (+
           (if (string=? (first (explode (first dict))) letter) 1 0)
           (starts-with# letter (rest dict)))]))

(starts-with# "e" DICTIONARY-AS-LIST)
;; 7818

(starts-with# "z" DICTIONARY-AS-LIST)
; 719
