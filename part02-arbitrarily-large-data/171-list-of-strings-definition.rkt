#lang htdp/bsl
(require 2htdp/batch-io)

;; Exercise 171. You know what the data definition for List-of-strings looks like. Spell it out. Make sure that you can represent Piet Hein’s poem as an instance of the definition where each line is a represented as a string and another one where each word is a string. Use read-lines and read-words to confirm your representation choices.
;;
;; Next develop the data definition for List-of-list-of-strings. Again, represent Piet Hein’s poem as an instance of the definition where each line is a represented as a list of strings, one per word, and the entire poem is a list of such line representations. You may use read-words/line to confirm your choice.

; Los (short for List of strings) is one of:
; - '()
; - (cons String Los)

;; A file represented by a list of lines is a Los:
;; (cons "TTT"
;;       (cons ""
;;             (cons "Put up in a place"
;;                   (cons "where it's easy to see"
;;                         (cons "the cryptic admonishment"
;;                               (cons ...
;;                                     '()))))))
(read-lines "ttt.txt")

;; A file represented by a list of its words is also a Los:
;; (cons "TTT"
;;       (cons "Put"
;;             (cons "up"
;;                   (cons ...
;;                         '()))))
(read-words "ttt.txt")

; Lls (short for List of list of strings) is one of:
; - '()
; - (cons Los Lls)
; where Los is a List of strings.

; each line is a list.
; each line's list is a list of words
;; (cons (cons "TTT" '())
;;       (cons '()
;;             (cons (cons "Put"
;;                         (cons "up"
;;                               (cons ... '())))
;;                   (cons (cons "where"
;;                               (cons ... '()))
;;                         (cons ...
;;                               '())))))

(read-words/line "ttt.txt")
