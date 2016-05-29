; a Word is one of the following:
; - a word that consists of three characters
; - #f
; interpretation a word is spelled with three letters from "a" to "z",
; or #f if the given string does not meet the criteria for a word.
; Word is (make-word String)
(define-struct word [w])
; ex:
(make-word "wow")   ; => "wow"
(make-word "sauce") ; => #f
