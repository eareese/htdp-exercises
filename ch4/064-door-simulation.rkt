#lang htdp/bsl
(require 2htdp/image)
(require 2htdp/universe)

;; Sample Problem: Design a world program that simulates the working of a door
;; with an automatic door closer. If this kind of door is locked, you can unlock
;; it with a key. An unlocked door is closed but someone pushing at the door
;; opens it. Once the person has passed through the door and lets go, the
;; automatic door takes over and closes the door again. When a door is closed,
;; it can be locked again.

; a DoorState is one of:
; - "locked"
; - "closed"
; - "open"


; door-actions
; DoorState KeyEvent -> DoorState
; simulates the actions on the door via three kinds of key events
(check-expect (door-actions "locked" "u") "closed")
(check-expect (door-actions "locked" "a") "locked")
(check-expect (door-actions "closed" "l") "locked")
(check-expect (door-actions "closed" " ") "open")
(check-expect (door-actions "closed" "u") "closed")
(check-expect (door-actions "open" "u") "open")
(check-expect (door-actions "open" " ") "open")
(check-expect (door-actions "open" "x") "open")
(define (door-actions state-of-door event-key)
  (cond
    [(and (string=? "locked" state-of-door)
          (string=? "u" event-key)) "closed"]
    [(and (string=? "closed" state-of-door)
          (string=? "l" event-key)) "locked"]
    [(and (string=? "closed" state-of-door)
          (string=? " " event-key)) "open"]
    [else state-of-door]))

; door-closer
; DoorState -> DoorState
; closes an open door over the period of one tick
(check-expect (door-closer "locked") "locked")
(check-expect (door-closer "closed") "closed")
(check-expect (door-closer "open") "closed")
(define (door-closer state-of-door)
  (cond
    [(string=? "locked" state-of-door) "locked"]
    [(string=? "closed" state-of-door) "closed"]
    [(string=? "open" state-of-door) "closed"]))

; door-render
; DoorState -> Image
; translates the current door state into a text display
(check-expect (door-render "closed") (text "closed" 40 "blue"))
(define (door-render s) (text s 40 "blue"))


; DoorState -> DoorState
; simulates a door that closes automatically
(define (door-simulation initial-state)
  (big-bang initial-state
            [on-tick door-closer 3]
            [on-key door-actions]
            [to-draw door-render]))

(door-simulation "closed")
