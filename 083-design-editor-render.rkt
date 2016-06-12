#lang htdp/bsl
(require 2htdp/image)

; Design the function render, which consumes an Editor and produces an image.
;; The purpose of the function is to render the text within an empty scene of 200 x 20 pixels. For the cursor, use a 1 x 20 red rectangle and for the strings, black text of size 16.


(define-struct editor [pre post])
; Editor = (make-editor String String)
; interpretation (make-editor s t) means the text in the editor is
; (string-append s t) with the cursor displayed between s and t

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

(render (make-editor "he" ""))
(render (make-editor "hello" "world"))
(render (make-editor "hello " "world"))
