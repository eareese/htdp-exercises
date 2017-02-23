#lang htdp/bsl+
;;---------------------------------------------------------------------------------------------------

;; Exercise 184. Determine the values of the following expressions:

;; (list (string=? "a" "b") #false)
;; (list (+ 10 20) (* 10 20) (/ 10 20))
;; (list "dana" "jane" "mary" "laura")

;; Use check-expect to express your answers.

;; (list (string=? "a" "b") #false)
(check-expect (list #f #f)
              (list (string=? "a" "b") #false))

;; (list (+ 10 20) (* 10 20) (/ 10 20))
(check-expect (list 30 200 0.5)
              (list (+ 10 20) (* 10 20) (/ 10 20)))

;; (list "dana" "jane" "mary" "laura")
(check-expect '("dana" "jane" "mary" "laura")
              (list "dana" "jane" "mary" "laura"))
