#lang htdp/bsl+
;;---------------------------------------------------------------------------------------------------

;; Exercise 206. Design the function find-association. It consumes three arguments: a String called
;; key; an LAssoc; and an element of Any called default. It produces the first Association whose
;; first item is equal to key or default if there is no such Association.

(define test-assoc (list "wow" #f))
(define test-la (list test-assoc))
; String LAssoc Any -> Association or Any
; consumes a key (String), LAssoc, and an Any element called default. Produces the first Association
; whose first item is equal to key or default if there is no such Association.
(check-expect (find-association "wow" test-la -1) test-assoc)
(check-expect (find-association "nope" test-la -1) -1)
(check-expect (find-association "wow" '() -1) -1)
(define (find-association key la default)
  (cond
    [(empty? la) default]
    [(string=? key (first (first la))) (first la)]
    [else (find-association key (rest la) default)]))
