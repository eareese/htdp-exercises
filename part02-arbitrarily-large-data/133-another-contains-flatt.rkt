#lang htdp/bsl

;; Exercise 133. Here is another way of formulating the second cond clause in contains-flatt?:

;; ... (cond
;;       [(string=? (first alon) "Flatt") #true]
;;       [else (contains-flatt? (rest alon))]) ...

;; Explain why this expression produces the same answers as the or expression in the version of figure 46. Which version is better? Explain.

; List-of-names -> Boolean
; determines whether "Flatt" occurs on alon
(check-expect
 (contains-flatt? (cons "X" (cons "Y"  (cons "Z" '()))))
 #false)
(check-expect
 (contains-flatt? (cons "A" (cons "Flatt" (cons "C" '()))))
 #true)
(define (contains-flatt? alon)
  (cond
    [(empty? alon) #false]
    [(cons? alon)
     (cond
       [(string=? (first alon) "Flatt") #true]
       [else (contains-flatt? (rest alon))])]))
     ;; (or (string=? (first alon) "Flatt")
     ;;     (contains-flatt? (rest alon)))]))

; The commented version loses, because it's better to not wait for all the recursive calls to return for the second `or` clause.

(contains-flatt?
 (cons "Fagan"
       (cons "Findler"
             (cons "Fisler"
                   (cons "Flanagan"
                         (cons "Flatt"
                               (cons "Felleisen"
                                     (cons "Friedman" '()))))))))
