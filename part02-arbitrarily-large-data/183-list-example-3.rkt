#lang htdp/bsl+
;;---------------------------------------------------------------------------------------------------

;; Exercise 183. On some occasions lists are formed with cons and list.

;; (cons "a" (list 0 #false))
;; (list (cons 1 (cons 13 '())))
;; (cons (list 1 (list 13 '())) '())
;; (list '() '() (cons 1 '()))
;; (cons "a" (cons (list 1) (list #false '())))

;; Reformulate each of the following expressions using only cons or only list. Use check-expect to
;; check your answers.
;;---------------------------------------------------------------------------------------------------

;; (cons "a" (list 0 #false))
(check-expect (list "a" 0 #false)
              (cons "a" (list 0 #false)))

;; (list (cons 1 (cons 13 '())))
(check-expect (list (list 1 13))
              (list (cons 1 (cons 13 '()))))

;; (cons (list 1 (list 13 '())) '())
(check-expect (list (list 1 (list 13 '())))
              (cons (list 1 (list 13 '())) '()))

;; (list '() '() (cons 1 '()))
(check-expect (list '() '() (list 1))
              (list '() '() (cons 1 '())))

;; (cons "a" (cons (list 1) (list #false '())))
(check-expect (list "a" (list 1)  #false '())
              (cons "a" (cons (list 1) (list #false '()))))
