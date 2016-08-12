;; Exercise 126. Identify the values among the following expressions, assuming the definitions area contains these structure type definitions:

(define-struct point [x y z])
(define-struct none  [])

(make-point 1 2 3)
; Yes, this is a value. it's a structure value.


(make-point (make-point 1 2 3) 4 5)
; This is another structure value.

(make-point (+ 1 2) 3 4)
; This evaluates to (make-point 3 3 4), a structure value.

(make-none)
; this is a constructor function, whereas a value should be one of: number, boolean, string, image, or structure value.

(make-point (point-x (make-point 1 2 3)) 4 5)
; this will be another structure value:
; (make-point 1 4 5)

;; Explain why the expressions are values or not.
