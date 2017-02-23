#lang htdp/bsl+
;;---------------------------------------------------------------------------------------------------

;; Exercise 181. Use list to construct the equivalent of these lists:

;;   (cons "a" (cons "b" (cons "c" (cons "d" '()))))
;;   (cons (cons 1 (cons 2 '())) '())
;;   (cons "a" (cons (cons 1 '()) (cons #false '())))
;;   (cons (cons "a" (cons 2 '())) (cons "hello" '()))

;; Also try your hands at this one:

;;   (cons (cons 1 (cons 2 '()))
;;     (cons (cons 2 '())
;;       '()))

;; Start by determining how many items each list and each nested list contains. Use check-expect to
;; express your answers; this ensures that your abbreviations are really the same as the long-hand.

;;   (cons "a" (cons "b" (cons "c" (cons "d" '()))))
(check-expect (cons "a" (cons "b" (cons "c" (cons "d" '()))))
              (list "a" "b" "c" "d"))

;;   (cons (cons 1 (cons 2 '())) '())
(check-expect (cons (cons 1 (cons 2 '())) '())
              (list (list 1 2)))

;;   (cons "a" (cons (cons 1 '()) (cons #false '())))
(check-expect (cons "a" (cons (cons 1 '()) (cons #false '())))
              (list "a" (list 1) #f))

;;   (cons (cons "a" (cons 2 '())) (cons "hello" '()))
(check-expect (cons (cons "a" (cons 2 '())) (cons "hello" '()))
              (list (list "a" 2) "hello"))

;;   (cons (cons 1 (cons 2 '()))
;;     (cons (cons 2 '())
;;       '()))
(check-expect (cons (cons 1 (cons 2 '())) (cons (cons 2 '()) '()))
              (list (list 1 2) (list 2)))
