;; Exercise 128. Copy the following tests into DrRacket’s definitions area:

(check-expect 3 4)
; Actual value 3 differs from 4, the expected value.

(check-member-of "green" "red" "yellow" "grey")
; Actual value "green" differs from all given members in  "red" "yellow" "grey".


(check-within (make-posn #i1.0 #i1.1)
              (make-posn #i0.9 #i1.2)
              0.01)
; Actual value (make-posn #i1.0 #i1.1) is not within 1/100 of expected value (make-posn #i0.9 #i1.2).

(check-range #i0.9 #i0.6 #i0.8)
; Actual value #i0.9 is not between #i0.6 and #i0.8, inclusive.

(check-error (/ 1 1))
; check-error expected an error, but instead received the value 1.

(check-random (make-posn (random 3) (random 9))
              (make-posn (random 9) (random 3)))
; Actual value (make-posn 0 6) differs from (make-posn 1 2), the expected value.

(check-satisfied 4 odd?)
; Actual value 4 does not satisfy odd?.


;; Validate that all of them fail and explain why.

;; btw, test results in DrRacket are looking slick nowadays
