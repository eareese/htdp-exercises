#lang htdp/bsl
;;---------------------------------------------------------------------------------------------------
(require 2htdp/image)
(require 2htdp/universe)

(define HEIGHT 20)
(define WIDTH 200)
(define FONT-SIZE 16)
(define FONT-COLOR "black")

(define MT (empty-scene WIDTH HEIGHT))
(define CURSOR (rectangle 1 HEIGHT "solid" "green"))

(define-struct editor [pre post])
; An Editor is a structure:
;   (make-editor Lo1S Lo1S)
; An Lo1S is one of:
; – '()
; – (cons 1String Lo1S)


;; Exercise 177. Design the function create-editor. The function consumes two strings and produces an
;; Editor. The first string is the text to the left of the cursor and the second string is the text
;; to the right of the cursor. The rest of the section relies on this function.

; String String -> Editor
; consumes two strings and produces an Editor. the first string represents text to the left of the
; cursor, second string represents text to the right of the cursor
(define (create-editor s1 s2)
  (make-editor
   (reverse (explode s1))
   (explode s2)))

; Editor -> Image
; renders an editor as an image of the two texts separated by the cursor
(define (editor-render e) MT)

; Editor KeyEvent -> Editor
; deals with a key event, given some editor
(check-expect (editor-kh (create-editor "" "") "e")
              (create-editor "e" ""))
(check-expect (editor-kh (create-editor "cd" "fgh") "e")
              (create-editor "cde" "fgh"))
(define (editor-kh ed k)
  ed)
  ;; (cond
  ;;   [(key=? k "left") ...]
  ;;   [(key=? k "left") ...]
  ;;   [(key=? k "left") ...]
  ;;   [(key=? k "left") ...]
  ;;   [(key=? k "left") ...]
  ;;   [(= (string-length k) 1) ...]
  ;;   [else ...]))

; main : String -> Editor
; launches the editor given some initial string
;; (define (main s)
;;   (big-bang (create-editor s "")
;;             [on-key editor-kh]
;;             [to-draw editor-render]))

;; (main "hello")
