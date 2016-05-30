; a R3 is a representation of the distance of an object from the
; origin in a three-dimensional space.
(define-struct r3 [x y z])
; R3 is (make-r3 Number Number Number)
; - x is the distance to origin on the x axis
; - y is the distance to origin on the y axis
; - z is the distance to origin on the z axis
(define ex1 (make-r3 1 2 13))
(define ex2 (make-r3 -1 0 3))

; R3 -> Number
; determines the distance of p to the origin
(define (r3-distance-to-0 p)
  (... (r3-x p) ... (r3-y p) ... (r3-z p) ...))


(define-struct movie [title director year])
(define (movie-entry m)
  (... (movie-title m) ... (movie-director m) ... (movie-year m)))

(define-struct person [name hair eyes phone])

(define-struct pet [name number])

(define-struct CD [artist title price])

(define-struct sweater [material size color])
