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

(define WORLD (empty-scene WIDTH HEIGHT "white"))

; A WorldState is a String and must be one of:
; - "init"      displays white when the world begins and no input has yet been received.
; - "progress"  displays yellow when a  desired letter has been received.
; - "complete"  displays green after encountering the final letter.
; - "error"     displays red if a bad or invalid key input is received.

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
; WorldState -> Image
; produces the display image for the given ws.
(check-expect (render "error") (empty-scene WIDTH HEIGHT "red"))
(check-expect (render "complete") (empty-scene WIDTH HEIGHT "green"))
(check-expect (render "progress") (empty-scene WIDTH HEIGHT "yellow"))
(check-expect (render "init") (empty-scene WIDTH HEIGHT "white"))
(define (render ws) (empty-scene WIDTH HEIGHT
                                 (cond
                                   [(string=? "progress" ws) "yellow"]
                                   [(string=? "complete" ws) "green"]
                                   [(string=? "error" ws) "red"]
                                   [else "white"]
                                   )))

; key-handler
; WorldState KeyEvent -> WorldState
; produces the next ws, depending on whether a key event occurred and whether a "desired" key was
; pressed. (see the data definition for ExpectsToSee)
(check-expect (key-handler "init" "a") "progress")
(check-expect (key-handler "init" "p") "error")
(check-expect (key-handler "progress" "b") "progress")
(check-expect (key-handler "progress" "c") "progress")
(check-expect (key-handler "progress" "x") "error")
(check-expect (key-handler "progress" "d") "complete")
(define (key-handler ws ke)
  (cond
    [(and (string=? "init" ws) (string=? "a" ke)) "progress"]
    [(and (string=? "progress" ws) (string=? "b" ke)) "progress"]
    [(and (string=? "progress" ws) (string=? "c" ke)) "progress"]
    [(and (string=? "progress" ws) (string=? "d" ke)) "complete"]
    [(string=? "complete" ws) "complete"] ; "complete" is a final state
    [else "error"])) ; "error" is the other final state

; final-state?
; WorldState -> Boolean
; produces true if the ws is in "complete" or "error" state.
(check-expect (final-state? "init") #f)
(check-expect (final-state? "progress") #f)
(check-expect (final-state? "complete") #t)
(check-expect (final-state? "error") #t)
(define (final-state? ws) (or (string=? "complete" ws) (string=? "error" ws)))

; main
(define (main ws)
         (big-bang ws
           [on-key key-handler]
           [stop-when final-state?]
           [to-draw render]))

