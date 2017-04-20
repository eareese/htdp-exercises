;;---------------------------------------------------------------------------------------------------
#lang htdp/bsl
(require 2htdp/image)
(require 2htdp/universe)

;; Exercise 109. Design a world program that recognizes a pattern in a sequence of KeyEvents.
;; Initially the program shows a 100 by 100 white rectangle. Once your program has encountered the
;; first desired letter, it displays a yellow rectangle of the same size. After encountering the
;; final letter, the color of the rectangle turns green. If any “bad” key event occurs, the program
;; displays a red rectangle.

(define WIDTH 100)
(define HEIGHT 100)

; ExpectsToSee is one of:
; - AA
; - BB
; - DD
; - ER
(define AA "start, expect an 'a'")
(define BB "expect 'b', 'c', or 'd'")
(define DD "finished")
(define ER "error, illegal key")


; render
; ExpectsToSee -> Image
; produces the display image for the given ETS world state.
(check-expect (render ER) (empty-scene WIDTH HEIGHT "red"))
(check-expect (render DD) (empty-scene WIDTH HEIGHT "green"))
(check-expect (render BB) (empty-scene WIDTH HEIGHT "yellow"))
(check-expect (render AA) (empty-scene WIDTH HEIGHT "white"))
(define (render ws)
  (empty-scene WIDTH HEIGHT
               (cond
                 [(string=? BB ws) "yellow"]
                 [(string=? DD ws) "green"]
                 [(string=? ER ws) "red"]
                 [else "white"]
                 )))

; key-handler
; ExpectsToSee KeyEvent -> ExpectsToSee
; produces the next ETS world state, depending on whether a key event occurred and whether a
; "desired" key was pressed. According to the data definition, desired keys are in (a, b, c, d)
(check-expect (key-handler AA "a") BB)
(check-expect (key-handler AA "p") ER)
(check-expect (key-handler BB "b") BB)
(check-expect (key-handler BB "c") BB)
(check-expect (key-handler BB "x") ER)
(check-expect (key-handler BB "d") DD)
(define (key-handler ws ke)
  (cond
    [(and (string=? AA ws) (string=? "a" ke)) BB]
    [(and (string=? BB ws) (string=? "b" ke)) BB]
    [(and (string=? BB ws) (string=? "c" ke)) BB]
    [(and (string=? BB ws) (string=? "d" ke)) DD]
    [(string=? DD ws) DD]
    [else ER]))

; main
(define (main ws)
         (big-bang ws
           [on-key key-handler]
           [to-draw render]))


(main AA)
