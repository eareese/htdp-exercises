;;---------------------------------------------------------------------------------------------------
#lang htdp/bsl+

;; String List-of-Strings -> Boolean
;; produces #t when s is found in l
(check-expect (contains? "basic" '("cat" "basic")) #t)
(check-expect (contains? "basic" '("cat")) #f)
(check-expect (contains? "cat" '("cat" "basic")) #t)
(check-expect (contains? "cat" '()) #f)
(define (contains? s l)
  (cond
    [(empty? l) #f]
    [(string=? s (first l)) #t]
    [else (contains? s (rest l))]))

;; Exercise 235. Use the contains? function to define functions that search for "atom", "basic", and
;; "zoo", respectively.

;; List of strings -> Boolean
;; Does l contain "atom"?
(check-expect (contains-atom? '("cat" "atom" "dog")) #t)
(check-expect (contains-atom? '("cat" "dog")) #f)
(check-expect (contains-atom? '()) #f)
(define (contains-atom? l)
  (contains? "atom" l))

;; List of strings -> Boolean
;; Does l contain "zoo"?
(check-expect (contains-zoo? '()) #f)
(check-expect (contains-zoo? '("animal" "plant" "zoo")) #t)
(check-expect (contains-zoo? '("zoop" "zoon" "zool")) #f)
(define (contains-zoo? l)
  (contains? "zoo" l))

;; List of strings -> Boolean
;; Does l contains "basic"?
(check-expect (contains-basic? '("one" "two" "basic" "four")) #t)
(check-expect (contains-basic? '("one" "two" "four")) #f)
(check-expect (contains-basic? '()) #f)
(define (contains-basic? l)
  (contains? "basic" l))
