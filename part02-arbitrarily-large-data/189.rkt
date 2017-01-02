#lang htdp/bsl+
;;---------------------------------------------------------------------------------------------------

;; Exercise 189. Here is the function search:

;; ; Number List-of-numbers -> Boolean
;; (define (search n alon)
;;   (cond
;;     [(empty? alon) #false]
;;     [else (or (= (first alon) n)
;;               (search n (rest alon)))]))

;; It determines whether some number occurs in a list of numbers. The function may have to traverse
;; the entire list to find out that the number of interest isn’t contained in the list.

;; Develop the function search-sorted, which determines whether a number occurs in a sorted list of
;; numbers. The function must take advantage of the fact that the list is sorted.

; Number List-of-numbers -> Boolean
; returns true if n occurs in the sorted list
(check-expect (search-sorted 1 (list 3 4 5)) #f)
(check-expect (search-sorted 7 (list 1 2 3 4)) #f)
(check-expect (search-sorted 3 (list 1 2 3 4)) #t)
(check-expect (search-sorted 3 '()) #f)
(define (search-sorted n slon)
  (cond
    [(or (empty? slon) (> (first slon) n)) #f]
    [(= n (first slon)) #t]
    [else (search-sorted n (rest slon))]))
