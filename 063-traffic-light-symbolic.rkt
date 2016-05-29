#lang htdp/bsl

(define RED 0)
(define GREEN 1)
(define YELLOW 2)

; a S-TrafficLight shows one of three colors:
; - RED
; - GREEN
; - YELLOW
; "if the names are chosen properly, such a data definition does not need an
; interpretation statement."

; S-TrafficLight -> S-TrafficLight
; determines the next state of the traffic light, given cs
(define (tl-next-symbolic cs)
  (cond
    [(equal? cs RED) GREEN]
    [(equal? cs GREEN) YELLOW]
    [(equal? cs YELLOW) RED]))

; well, equal? can compare two of any values,
; so a version like this will still work even if the definitions are changed:
;; (define RED "red")
;; (define GREEN "green")
;; (define YELLOW "yellow")
;;
;; ; a S-TrafficLight shows one of three colors:
;; ; - RED
;; ...
