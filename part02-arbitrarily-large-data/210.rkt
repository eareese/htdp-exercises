#lang htdp/bsl+
;;---------------------------------------------------------------------------------------------------

; A Word is one of:
; - '()
; - (cons 1String Word)
; interpretation a String as a list of 1Strings (letters)
(define test-word (cons "m" (cons "e" '())))

; A List-of-words is one of:
; - '()
; (cons Word List-of-words)
; interpretation a list composed of Words
(define test-low (cons test-word '()))

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

;; Exercise 210. Complete the design of the words->strings function specified in figure 74. Hint Use
;; your solution to exercise 209.

; List-of-words -> List-of-strings
; turn all Words in low into Strings
(check-expect (words->strings test-low) (list "me"))
(check-expect (words->strings '()) '())
(define (words->strings low)
  (cond
    [(empty? low) '()]
    [else (cons (word->string (first low)) (words->strings (rest low)))]))

; List-of-strings -> List-of-strings
; pick out all those Strings that occur in the dictionary
(define (in-dictionary los)
  '())

; Word -> List-of-words
; find all re-arrangements of word
(define (arrangements word)
  (list word))
