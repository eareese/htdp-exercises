#lang htdp/bsl

;; Exercise 162. No employee could possibly work more than 100 hours per week. To protect the company against fraud, the function should check that no item of the input list of wage* exceeds 100. If one of them does, the function should immediately signal an error. How do we have to change the function in figure 60 if we want to perform this basic reality check?


;; We should add the test as part of the else condition. instead of "else <just return a list made by cons-ing (wage first) with the wage* of the rest of the list>", there will be a new condition that checks whether the first list item is an hours value over 100. if it exceeds 100, throw an error; otherwise, return the list made by the recursive call.
;; Kinda like...
;; (define (wage* whrs)
;;   (cond
;;     [(empty? whrs) '()]
;;     [else (if (> (first whrs) 100)
;;               (THROW ERROR) ; if first whrs > 100, throw error. else:
;;               (cons (wage (first whrs)) (wage* (rest whrs))))]))



; wage per hour = $14
(define WPH 14)

; Number -> Number
; computes the wage for h hours of work
(define (wage h)
  (* WPH h))

; List-of-numbers -> List-of-numbers
; computes the weekly wages for the weekly hours
(check-expect (wage* '()) '())
(check-expect (wage* (cons 28 '())) (cons (* 28 WPH) '()))
(check-expect (wage* (cons 4 (cons 2 '()))) (cons (* 4 WPH) (cons (* 2 WPH) '())))
(define (wage* whrs)
  (cond
    [(empty? whrs) '()]
    [else (cons (wage (first whrs)) (wage* (rest whrs)))]))
