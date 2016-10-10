#lang htdp/bsl

;; Exercise 132. Use DrRacket to run contains-flatt? in this example:

;; (cons "Fagan"
;;       (cons "Findler"
;;             (cons "Fisler"
;;                   (cons "Flanagan"
;;                         (cons "Flatt"
;;                               (cons "Felleisen"
;;                                     (cons "Friedman" '())))))))

;; What answer do you expect?

; List-of-names -> Boolean
; determines whether "Flatt" occurs on alon
(check-expect
 (contains-flatt? (cons "X" (cons "Y"  (cons "Z" '()))))
 #false)
(check-expect
 (contains-flatt? (cons "A" (cons "Flatt" (cons "C" '()))))
 #true)
(define (contains-flatt? alon)
  (cond
    [(empty? alon) #false]
    [(cons? alon)
     (or (string=? (first alon) "Flatt")
         (contains-flatt? (rest alon)))]))

(contains-flatt?
 (cons "Fagan"
       (cons "Findler"
             (cons "Fisler"
                   (cons "Flanagan"
                         (cons "Flatt"
                               (cons "Felleisen"
                                     (cons "Friedman" '()))))))))
;; #t !
