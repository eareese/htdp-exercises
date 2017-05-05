;;---------------------------------------------------------------------------------------------------
#lang htdp/isl

;; Figure 85: Finding the inf and sup in a list of numbers
; Nelon -> Number
; determines the smallest
; number on l
;; (define (inf l)
;;   (cond
;;     [(empty? (rest l))
;;      (first l)]
;;     [else
;;      (if (< (first l)
;;             (inf (rest l)))
;;          (first l)
;;          (inf (rest l)))]))

; Nelon -> Number
; determines the largest
; number on l
;; (define (sup l)
;;   (cond
;;     [(empty? (rest l))
;;      (first l)]
;;     [else
;;      (if (> (first l)
;;             (sup (rest l)))
;;          (first l)
;;          (sup (rest l)))]))

;; Exercise 238. Abstract the two functions in figure 85 into a single function: Both consume
;; non-empty lists of numbers (Nelon) and produce a single number. The left one produces the
;; smallest number in the list, the right one the largest.

;; Function Non-empty-list-of-numbers -> Number
;; Extracts one element from l, according to the comparison function R.
;; (check-expect (select-one > '(4 2 8 6)) 8)
;; (check-expect (select-one < '(9 1 8)) 1)
;; (check-expect (select-one > '(-1)) -1)
;; (define (select-one R l)
;;   (cond
;;     [(empty? (rest l)) (first l)]
;;     [else (if (R (first l) (select-one R (rest l)))
;;               (first l)
;;               (select-one R (rest l)))]))

;; Define inf-1 and sup-1 in terms of the abstract function. Test them with these two lists:
(define LIST1 (list 25 24 23 22 21 20 19 18 17 16 15 14 13 12 11 10 9 8 7 6 5 4 3 2 1))
(define LIST2 (list 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25))

;; Nonempty-list-of-numbers -> Number
;; produces the smallest number on l
;; (check-expect (inf-1 LIST1) 1) ; worst case, very slow. Bad!
;; (check-expect (inf-1 LIST2) 1)
;; (define (inf-1 l)
;;   (select-one < l))

;; Nonempty-list-of-numbers -> Number
;; produces the largest number on l
;; (check-expect (sup-1 LIST1) 25)
;; (check-expect (sup-1 LIST2) 25) ; worst case
;; (define (sup-1 l)
;;   (select-one > l))

;; Why are these functions slow on some of the long lists?
;; The best case for these functions is when the smallest or largest item is the first list item.
;; Such a case only needs to recursively check the other list items to confirm that the first is the
;; smallest one or largest one. So, the worst case is the opposite, where the "best" item is found at
;; the end of the list. Since we look at one list item at a time and compare it to the items in the
;; rest of the list, and select-one is called recursively every time the comparison happens, and then
;; if the comparison fails, do it all again for the rest of the list until the last item is
;; reached... that's a lot of recursion in the worst case, and I'm thinking even average case grows
;; expensive quickly.


;; Modify the original functions with the use of max, which picks the larger of two numbers, and min,
;; which picks the smaller one. Then abstract again, define inf-2 and sup-2, and test them with the
;; same inputs again. Why are these versions so much faster?

;; Non-empty-list-of-numbers -> Number
;; Extracts the largest element from l, using max
(check-expect (sup LIST1) 25)
(check-expect (sup LIST2) 25)
(define (sup l)
  (cond
    [(empty? (rest l)) (first l)]
    [else (max (first l) (sup (rest l)))]))

;; Non-empty-list-of-numbers -> Number
;; Extracts the smallest element from l, using min
(check-expect (inf LIST1) 1)
(check-expect (inf LIST2) 1)
(define (inf l)
  (cond
    [(empty? (rest l)) (first l)]
    [else (min (first l) (inf (rest l)))]))

;; Non-empty-list-of-numbers Function -> Number
;; Extracts one item from l, based on the function R
(check-expect (select-one min LIST2) 1)
(define (select-one R l)
  (cond
    [(empty? (rest l)) (first l)]
    [else (R (first l) (select-one R (rest l)))]))

;; Non-empty-list-of-numbers -> Number
;; Select the smallest item from l, using select-one
(check-expect (inf-2 LIST1) 1)
(check-expect (inf-2 LIST2) 1)
(define (inf-2 l)
  (select-one min l))

;; Non-empty-list-of-numbers -> Number
;; Select the largest item from l, using select-one
(check-expect (sup-2 LIST1) 25)
(check-expect (sup-2 LIST2) 25)
(define (sup-2 l)
  (select-one max l))

;; These functions are faster because, instead of checking each item against all others recursively
;; and then going through another recursive call when the comparison fails, we are letting max or min
;; decide between either the first item or [whatever comes back from a recursive call to the
;; function], which means the recursion doesn't get out of control even in the worst cases.

;; For another answer to these questions, see Local Definitions.
