#lang htdp/bsl+
;;---------------------------------------------------------------------------------------------------

;; Exercise 190. Design the prefixes function, which consumes a list of 1Strings and produces the
;; list of all prefixes. A list p is a prefix of l if p and l are the same up through all items in p.
;; For example, (list "a" "b" "c") is a prefix of itself and (list "a" "b" "c" "d").

; List-of-1Strings -> List-of-prefixes
; produces the list of all prefixes, given a list of 1Strings
(check-expect (prefixes (list "a" "b" "c"))
              (list (list "a" "b" "c")
                    (list "a" "b")
                    (list "a")))
(check-expect (prefixes (list "a"))
              (list (list "a")))
(check-expect (prefixes '()) '())
(define (prefixes l)
  (cond
    [(empty? l) '()]
    [else (cons l (prefixes (reverse (rest (reverse l)))))]))


;; Design the function suffixes, which consumes a list of 1Strings and produces all suffixes. A list
;; s is a suffix of l if p and l are the same from the end, up through all items in s. For example,
;; (list "b" "c" "d") is a suffix of itself and (list "a" "b" "c" "d").

; List-of-1Strings -> List-of-suffixes
; produces the list of all suffixes, given a list of 1Strings
(check-expect (suffixes (list "a" "b" "c"))
              (list (list "a" "b" "c")
                    (list "b" "c")
                    (list "c")))
(check-expect (suffixes (list "a")) (list (list "a")))
(check-expect (suffixes '()) '())
(define (suffixes l)
  (cond
    [(empty? l) '()]
    [else (cons l (suffixes (rest l)))]))
