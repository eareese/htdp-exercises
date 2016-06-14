; Exercise 85
; Editor -- run
#lang htdp/bsl
(require 2htdp/image)
(require 2htdp/universe)

; first data definition
(define-struct editor [pre post])
; Editor = (make-editor String String)
; interpretation (make-editor s t) means the text in the editor is
; (string-append s t) with the cursor displayed between s and t

; render
; Editor -> Image
(define (render ed)
  (overlay/align/offset
   HORIZ-ALIGN VERT-ALIGN
   (draw-text ed)
   X-ADJUST Y-ADJUST
   SCENE))

; Editor -> Image
; draw the text with cursor
(define (draw-text ed)
  (beside/align
   "bottom"
   (text (editor-pre ed) 16 "black")
   (rectangle 1 20 "solid" "red")
   (text (editor-post ed) 16 "black")))


(define SCENE (rectangle 200 20 "outline" "black"))
(define HORIZ-ALIGN "left")
(define VERT-ALIGN "middle")
(define X-ADJUST -3)
(define Y-ADJUST -1)

; edit
; Editor KeyEvent -> Editor
(check-expect (edit (make-editor "hell" "o") "o") (make-editor "hello" "o"))
(check-expect (edit (make-editor "hell" "") "o") (make-editor "hello" ""))
(check-expect (edit (make-editor "" "ello") "j") (make-editor "j" "ello"))
(check-expect (edit (make-editor "" "orld") "\b") (make-editor "" "orld"))
(check-expect (edit (make-editor "hello " "world") "\t") (make-editor "hello " "world"))
(check-expect (edit (make-editor "hello " "world") "\r") (make-editor "hello " "world"))
(check-expect (edit (make-editor "hello" "world") "left") (make-editor "hell" "oworld"))
(check-expect (edit (make-editor "hello" "world") "right") (make-editor "hellow" "orld"))
(define (edit ed ke)
  (cond
    [(string=? ke "left") (cursor-left ed)]
    [(string=? ke "right") (cursor-right ed)]
    [(string=? ke "\b") (bksp ed)]
    [(string=? ke "\r") ed]
    [(string=? ke "\t") ed]
    [(and (string? ke)
          (= 1 (string-length ke))
          (> (image-width SCENE) (image-width (draw-text (insert-char ed ke)))))
     (insert-char ed ke)]
    [else ed]))

; bksp
; Editor -> Editor
; simulate bksp by deleting the char end of pre.
(check-expect (bksp (make-editor "hello" "world"))
              (make-editor "hell" "world"))
(check-expect (bksp (make-editor "" "world")) (make-editor "" "world"))
(define (bksp ed)
  (make-editor
   (chop-last (editor-pre ed))
   (editor-post ed)))

; insert-char
; Editor Char -> Editor
; put the character at the cursor (append to pre)
(check-expect (insert-char (make-editor "hell" "o") "o") (make-editor "hello" "o"))
(check-expect (insert-char (make-editor "hell" "") "a") (make-editor "hella" ""))
(define (insert-char ed ch)
  (make-editor (string-append (editor-pre ed) ch) (editor-post ed)))


; cursor-left
; Editor -> Editor
; simulate moving the cursor left by swapping the last char from pre to post
(check-expect
 (cursor-left (make-editor "hello" "world"))
 (make-editor "hell" "oworld"))
(define (cursor-left ed)
  (make-editor
   ; pre
   (chop-last (editor-pre ed))
   ; post
   (string-append
    (get-last (editor-pre ed)) (editor-post ed))))

; cursor-right
; Editor -> Editor
; move the cursor right by moving the first char of post to the end of pre
(check-expect
 (cursor-right (make-editor "hello" "world"))
 (make-editor "hellow" "orld"))
(define (cursor-right ed)
  (make-editor
   ; pre
   (string-append (editor-pre ed) (get-first (editor-post ed)))
   ; post
   (chop-first (editor-post ed))))


;; SPECIAL SUBSTRING FUNCTIONS

;get-first
; String -> 1-String
(check-expect (get-first "hello") "h")
(check-expect (get-first "") "")
(define (get-first str)
  (if (> (string-length str) 1) (substring str 0 1) str))

; chop-first
(check-expect (chop-first "") "")
(check-expect (chop-first "hello") "ello")
(check-expect (chop-first "a") "")
(define (chop-first str)
  (if (> (string-length str) 0) (substring str 1) str))

; get-last
; String -> String
(check-expect (get-last "hello") "o")
(check-expect (get-last "z") "z")
(check-expect (get-last "") "")
(define (get-last str)
  (if (> (string-length str) 1) (substring str (- (string-length str) 1)) str))

; chop-last
; String -> String
(check-expect (chop-last "jelly") "jell")
(check-expect (chop-last "") "")
(define (chop-last str)
  (if (> (string-length str) 1)
      (substring str 0 (- (string-length str) 1))
      str))

; run
; String -> Editor
; interpretation consumes string and renders new editor with the string as pre
; expect (run "hello ") -> render an editor with "hello " is shown with cursor after
(define (run str)
  (big-bang (make-editor str "")
            [to-draw render]
            [on-key edit]))

(run "hell")
