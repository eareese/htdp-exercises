;; Exercise 144. Will sum and how-many work for NEList-of-temperatures even though they are designed for inputs from List-of-temperatures? If you think they don’t work, provide counter-examples. If you think they would, explain why.

; A NEList-of-temperatures is one of:
; – (cons CTemperature '())
; – (cons CTemperature NEList-of-temperatures)
; interpretation non-empty lists of Celsius temperatures

; NEList-of-temperatures -> Number
; computes the average temperature
(check-expect (average (cons 1 (cons 2 (cons 3 '()))))
              2)
(define (average ne-l)
  (/ (sum ne-l)
     (how-many ne-l)))

; even though sum and how-many both rely on checking for an empty list as a stop condition,
; I think they would still work for NEList-of-temperatures, because eventually the recursive
; functions just return the "default-by-the-time-you've-gotten-here" value for an empty list,
; and the empty list is still in there as part of the list definition, even though the empty
; list is not valid on its own. Anyway, no way to be sure but to test 'em.

; oh also, the "default empty-list return value" should not affect the result of the sum, since
; in that case it's just returning 0.
; but, I think there might be problems with how-many, because then the empty list will get
; counted as a list element, causing the result of how-many to be off by one. I think.
