#lang htdp/bsl
;;---------------------------------------------------------------------------------------------------
;; Exercise 175. Design a BSL program that simulates the Unix command wc. The purpose of the command
;; is to count the number of 1Strings, words, and lines in a given file. That is, the command
;; consumes the name of a file and produces a value that consists of three numbers.

(require 2htdp/batch-io)


(define-struct counts [ln wd ch])
; A Counts [result] is a structure:
;; (make-counts Number Number Number)
; interpretation (make-counts l w c) represents the line, word, and 1String counts l, w, and c

(define test-file (cons
                   (cons "hello" (cons "world" '()))
                   (cons
                    (cons "the" (cons "end." '()))
                    '())))

; wc
; File -> Counts
; consumes a file identified by name and produces a Counts of lines, words, and characters
(define (wc f)
  (count (read-words/line f)))

; count
; LLW -> Counts
; consumes file contents and produces a Counts with line, word, char count totals
(check-expect (count test-file) (make-counts 2 4 (+ 10 7)))
(define (count llw)
  (make-counts
   (lines llw)
   (words llw)
   (chars llw)
   ))

; lines
; LLW -> Number
; consumes a LLW and produces the number of lines in it
(check-expect (lines test-file) 2)
(check-expect (lines '()) 0)
(define (lines llw)
  (length llw))

; words
; LLW -> Number
(check-expect (words test-file) 4)
(check-expect (words '()) 0)
(define (words llw)
  (cond
    [(empty? llw) 0]
    [else (+ (words-in-line (first llw)) (words (rest llw)))]))

; words-in-line
; List-of-words -> Number
; consumes a line and produces the number of words in it
(check-expect (words-in-line (cons "hello" (cons "world" '()))) 2)
(check-expect (words-in-line '()) 0)
(define (words-in-line low)
  (length low))

; chars
; LLW -> Number
; returns the total char count for a List of list of words
(check-expect (chars test-file) 17)
(define (chars llw)
  (cond
    [(empty? llw) 0]
    [else (+ (chars-in-line (first llw)) (chars (rest llw)))]))

; chars-in-word
; String -> Number
; counts the number of characters in a word
(check-expect (chars-in-word "hello") 5)
(check-expect (chars-in-word "hell") 4)
(check-expect (chars-in-word "") 0)
(define (chars-in-word w)
  (length (explode w)))

; chars-in-line
; List-of-words -> Number
; counts the total number of characters in all the words of a line
(check-expect (chars-in-line (cons "hell" (cons "world" '()))) 9)
(check-expect (chars-in-line '()) 0)
(define (chars-in-line low)
  (cond
    [(empty? low) 0]
    [else (+ (chars-in-word (first low)) (chars-in-line (rest low)))]))

