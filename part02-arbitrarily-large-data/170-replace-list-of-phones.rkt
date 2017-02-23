#lang htdp/bsl

;; Exercise 170. Here is one way to represent a phone number:
;;
;; (define-struct phone [area switch four])
;; ; A Phone is a structure:
;; ;   (make-phone Three Three Four)
;; ; A Three is a Number between 100 and 999.
;; ; A Four is a Number between 1000 and 9999.
;;
;; Design the function replace. It consumes a list of Phones and produces one. It replaces all occurrence of area code 713 with 281.

(define-struct phone [area switch four])
;; ; A Phone is a structure:
;; ;   (make-phone Three Three Four)
;; ; A Three is a Number between 100 and 999.
;; ; A Four is a Number between 1000 and 9999.

; Lop
;; A List of Phones is one of:
;; - '()
;; - (cons Phone Lop)
;; interpretation a list of phone numbers


; Lop -> Lop
; consumes a list of phones. produces another list of phones,
; where every area code 713 is replaced by 281
(check-expect (replace '()) '())
(check-expect (replace (cons (make-phone 859 236 9999) '()))
              (cons (make-phone 859 236 9999) '()))
(check-expect (replace (cons (make-phone 713 867 5309) '()))
              (cons (make-phone 281 867 5309) '()))
(define (replace lop)
  (cond
    [(empty? lop) '()]
    [(cons? lop) (cons (make-phone
                        (if (= 713 (phone-area (first lop))) 281 (phone-area (first lop)))
                        (phone-switch (first lop))
                        (phone-four (first lop)))
                       (replace (rest lop)))]))
