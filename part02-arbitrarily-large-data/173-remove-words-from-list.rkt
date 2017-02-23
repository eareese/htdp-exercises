#lang htdp/bsl
(require 2htdp/batch-io)
;;---------------------------------------------------------------------------------------------------
;; Exercise 173. Design a program that removes all articles from a text file. The program consumes
;; the name n of a file, reads the file, removes the articles, and writes the result out to a file
;; whose name is the result of concatenating "no-articles-" with n. For this exercise, an article is
;; one of the following three words: "a", "an", and "the".
;;
;; Use read-words/line so that the transformation retains the organization of the original text into
;; lines and words. When the program is designed, run it on the Piet Hein poem.

(define ARTICLES (cons "a" (cons "an" (cons "the" '()))))


; File -> File
; consumes a file identified by name, produces a new file with all articles removed from text
(define (articles-b-gone n)
  (write-file (string-append "no-articles-" n)
              (collapse (read-words/line n))))

; LLS -> String
; consumes a list of lines (each line is a list of strings) and produces a string with the contents
(define (collapse lls)
  (cond
    [(empty? lls) ""]
    [else (string-append (process (first lls)) "\n" (collapse (rest lls)))]))

; Los -> String
; consumes a list of words, produces a string with the same words, except any articles
(check-expect (process (cons "Hello" (cons "world" '()))) "Hello world")
(check-expect (process (cons "a"
                             (cons "hello"
                                   (cons "to"
                                         (cons "the"
                                               (cons "world" '()))))))
              "hello to world")
(check-expect (process '()) "")
(define (process los)
  (cond
    [(empty? los) ""]
    [else (string-append
           (if (member? (first los) ARTICLES) "" (first los))
           (if (or (= 1 (length los)) (member? (first los) ARTICLES))
               "" ; do not include space if last word or article.
               " ")
           (process (rest los)))]))


;; (articles-b-gone "ttt.txt")
