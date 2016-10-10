#lang htdp/bsl

;; 1
(+ (* (/ 12 8) 2/3)
   (- 20 (sqrt 4)))

;; 2
(cond
  [(= 0 0) #false]
  [(> 0 1) (string=? "a" "a")]
  [else (= (/ 1 0) 9)])

;; 3
(cond
  [(= 2 0) #false]
  [(> 2 1) (string=? "a" "a")]
  [else (= (/ 1 2) 9)])
