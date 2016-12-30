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
  (cond
    [(key=? k "left") (editor-lft ed)]
    [(key=? k "right") (editor-rgt ed)]
    [(key=? k "\b") (editor-del ed)]
    [(key=? k "\r") ed]
    [(key=? k "\t") ed]
    [(= (string-length k) 1) (editor-ins ed k)]
    [else ed]))

; Editor 1String -> Editor
; insert the 1String k between pre and post
(check-expect (editor-ins (make-editor '() '()) "e")
              (make-editor (cons "e" '()) '()))
(check-expect (editor-ins (make-editor
                           (cons "d" '())
                           (cons "f" (cons "g" '()))) "e")
              (make-editor (cons "e" (cons "d" '()))
                           (cons "f" (cons "g" '()))))
(define (editor-ins ed k)
  (make-editor (cons k (editor-pre ed))
               (editor-post ed)))


;; Exercise 179. Design the functions

; Editor -> Editor
; moves the cursor position one 1String left,
; if possible
(check-expect (editor-lft (make-editor (cons "h" '()) '()))
              (make-editor '() (cons "h" '())))
(check-expect (editor-lft (make-editor (cons "h" '()) (cons "e" (cons "y" '()))))
              (make-editor '() (cons "h" (cons "e" (cons "y" '())))))
(check-expect (editor-lft (make-editor (cons "a" (cons "h" '())) '()))
              (make-editor (cons "h" '()) (cons "a" '())))
(check-expect (editor-lft (make-editor '() (cons "w" '())))
              (make-editor '() (cons "w" '())))
(define (editor-lft ed)
  (cond
    [(<= 1 (length (editor-pre ed)))
     (make-editor (rest (editor-pre ed))
                  (cons (first (editor-pre ed)) (editor-post ed)))]
    [else ed]))

; Editor -> Editor
; moves the cursor position one 1String right, if possible
(check-expect (editor-rgt (make-editor (cons "h" '()) (cons "e" (cons "y" '()))))
              (make-editor (cons "e" (cons "h" '())) (cons "y" '())))
(check-expect (editor-rgt (make-editor '() (cons "x" '()))) (make-editor (cons "x" '()) '()))
(check-expect (editor-rgt (make-editor (cons "x" '()) '())) (make-editor (cons "x" '()) '()))
(check-expect (editor-rgt (make-editor '() '())) (make-editor '() '()))
(define (editor-rgt ed)
  (cond
    [(<= 1 (length (editor-post ed)))
     (make-editor (cons (first (editor-post ed)) (editor-pre ed))
                  (rest (editor-post ed)))]
    [else ed]))

; Editor -> Editor
; deletes a 1String to the left of the cursor
; if possible
;; (check-expect (editor-del (make-editor ... ...)) (make-editor ... ...))
(check-expect (editor-del (make-editor (cons "h" '()) (cons "e" (cons "y" '()))))
              (make-editor '() (cons "e" (cons "y" '()))))
(check-expect (editor-del (make-editor (cons "a" (cons "a" (cons "h" '()))) '()))
              (make-editor (cons "a" (cons "h" '())) '()))
(check-expect (editor-del (make-editor '() (cons "w" '())))
              (make-editor '() (cons "w" '())))
(define (editor-del ed)
  (cond
    [(<= 1 (length (editor-pre ed)))
     (make-editor (rest (editor-pre ed))
                  (editor-post ed))]
    [else ed]))

;; Again, it is critical that you work through a good range of examples.


; main : String -> Editor
; launches the editor given some initial string
;; (define (main s)
;;   (big-bang (create-editor s "")
;;             [on-key editor-kh]
;;             [to-draw editor-render]))

;; (main "hello")
