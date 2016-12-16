;;---------------------------------------------------------------------------------------------------
#lang htdp/bsl
(require 2htdp/batch-io)

;; Exercise 172. Design the function collapse, which converts a list of lines into a string. The
;; strings should be separated by blank spaces (" "). The lines should be separated with a newline
;; ("\n").

;; Challenge When you are finished, use the program like this:

;; (write-file "ttt.dat"
;;             (collapse (read-words/line "ttt.txt")))

;; To make sure the two files "ttt.dat" and "ttt.txt" are identical, remove all extraneous white
;; spaces in your version of the T.T.T. poem.

; LLS -> String
; consumes a list of lines (each line is a list of strings) and produces a string with the contents
(define (collapse lls)
  (cond
    [(empty? lls) ""]
    [else (string-append (process (first lls)) "\n" (collapse (rest lls)))]))

; Los -> String
; consumes a line (list of words) and produces a single string with words separated by " "
(check-expect (process (cons "Hello" (cons "world" '()))) "Hello world")
(check-expect (process '()) "")
(define (process los)
  (cond
    [(empty? los) ""]
    [else (string-append (first los)
                         (if (= 1 (length los)) "" " ") ; no space at end
                         (process (rest los)))]))


;; (write-file "ttt.dat"
;;             (collapse (read-words/line "ttt.txt")))
