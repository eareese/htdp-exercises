#lang htdp/bsl+
;;---------------------------------------------------------------------------------------------------

; List-of-strings -> Boolean
(define (all-words-from-rat? w)
  (and (member? "rat" w) (member? "art" w) (member? "tar" w)))

; String -> List-of-strings
; find all words that the letters of some given word spell
;; (check-member-of (alternative-words "cat")
;;                  (list "act" "cat")
;;                  (list "cat" "act"))
;; (check-satisfied (alternative-words "rat") all-words-from-rat?)
(define (alternative-words s)
  (in-dictionary (words->strings (arrangements (string->word s)))))

; List-of-words -> List-of-strings
; turn all Words in low into Strings
(define (words->strings low)
  '())

; List-of-strings -> List-of-strings
; pick out all those Strings that occur in the dictionary
(define (in-dictionary los)
  '())

; Word -> List-of-words
; find all re-arrangements of word
(define (arrangements word)
  (list word))

;; Exercise 209. The above leaves us with two additional “wishes:” a function that consumes a String
;; and produces its corresponding Word and a function for the opposite direction. Here are the
;; wish-list entries:

;; string->word
;; word->string

;; Look up the data definition for Word in the next section and complete the definitions of
;; string->word and word->string. Hint You may wish to look in the list of functions that BSL
;; provides.

; A Word is one of:
; - '()
; - (cons 1String Word)
; interpretation a String as a list of 1Strings (letters)
(define test-word (cons "m" (cons "e" '())))

; A List-of-words is one of:
; - '()
; (cons Word List-of-words)
; interpretation a list composed of Words

; String -> Word
; convert s to the chosen word representation
(check-expect (string->word "me") test-word)
(check-expect (string->word "") '())
(define (string->word s)
  (explode s))

; Word -> String
; convert w to String representation
(check-expect (word->string test-word) "me")
(check-expect (word->string '()) "")
(define (word->string w)
  (implode w))
