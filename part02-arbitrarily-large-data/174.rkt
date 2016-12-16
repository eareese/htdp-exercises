#lang htdp/bsl
;;---------------------------------------------------------------------------------------------------
;; Exercise 174. Design a program that encodes text files numerically. Each letter in a word should
;; be encoded as a numeric three-letter string with a value between 0 and 256. Figure 65 shows our
;; encoding function for single letters. Before you start, explain these functions.
;;
;; Hints (1) Use read-words/line to preserve the organization of the file into lines and words.
;; (2) Read up on explode again.
(require 2htdp/batch-io)

; File -> File
; consumes a file identified by its name, produces a file with each letter encoded as a
; numeric three-letter string with value between 0 and 256
(define (encode-file f)
  (write-file (string-append "encoded-" f)
              (encode (read-words/line f))))

; LLW -> String
; consumes a List-of-list-of-words (list of lines), produces the encoded string
(check-expect (encode (cons
                       (cons "z" (cons "zzz" '()))
                       '())
                      )
              "122 122122122\n")
(check-expect (encode (cons (cons "zzz" '()) '())) "122122122\n")
(check-expect (encode '()) "")
(define (encode llw)
  (cond
    [(empty? llw) ""]
    [else (string-append (encode-line (first llw))
                         "\n"
                         (encode (rest llw)))]))

; Line -> String
; consumes a List-of-words (one line) and produces the encoded string for all words
(check-expect (encode-line (cons "zz" '())) "122122")
(check-expect (encode-line '()) "")
(define (encode-line low)
  (cond
    [(empty? low) ""]
    [else (string-append
           (encode-letters (explode (first low)))
           (if (= 1 (length low)) "" " ") ;preserve spaces between words, except at EOL
           (encode-line (rest low)))]))

; List-of-1Strings -> String
; consumes a list of letters, produces the encoded string
(check-expect (encode-letters (cons "z" '())) "122")
(check-expect (encode-letters '()) "")
(define (encode-letters lo1s)
  (cond
    [(empty? lo1s) ""]
    [else (string-append (encode-letter (first lo1s)) (encode-letters (rest lo1s)))]))

; 1String -> String
; converts the given 1String to a 3-letter numeric String
(check-expect (encode-letter "z") (code1 "z"))
(check-expect (encode-letter "\t")
              (string-append "00" (code1 "\t")))
(check-expect (encode-letter "a") (string-append "0" (code1 "a")))
(define (encode-letter s)
  (cond
    [(>= (string->int s) 100) (code1 s)]
    [(< (string->int s) 10) (string-append "00" (code1 s))]
    [(< (string->int s) 100) (string-append "0" (code1 s))]))
;; this function calls the code1 function to encode letters, padding the resulting string
;; with zeros if it is less than 3 characters.

; 1String -> String
; convert the given 1String into a String
(check-expect (code1 "z") "122")
(define (code1 c) (number->string (string->int c)))
;; this function converts a single character to its numeric code
