#lang htdp/bsl
(require 2htdp/image)

#| instructions for exercise 11:
create an expression that converts whatever in represents to a number. For a
string, it determines how long the string is; for an image, it uses the area;
for a number, it decrements the number, unless it is already 0 or negative;
for #true it uses 10 and for #false 20.
|#

(define in "hello")
(define cat (bitmap "images/cat.png"))

(define (whatever->number whatever)
  ; check for number type
  (if (number? whatever)
      ; if number, do stuff
      (if (<= whatever 0)
          ; do nothing for 0 or negative number
          whatever
          ; otherwise, decrement the number
          (- whatever 1))
      ; else, check for image
      (if (image? whatever)
          ; if image,
          99
          ; else, check another type
          (if (string? whatever)
              ; return string length
              (string-length whatever)
              ; check if true
              (if (and #t whatever)
                  10
                  ; assume it can only be false now
                  ; aka give up
                  20)))))

(check-satisfied (whatever->number "hello") number?)
(check-expect (whatever->number "hello") 5)

(check-satisfied (whatever->number 99) number?)
(check-expect (whatever->number -99) -99)
(check-expect (whatever->number 0) 0)
(check-expect (whatever->number 99) 98)

(check-satisfied (whatever->number cat) number?)
; test cat's dimensions

(check-expect (whatever->number #t) 10)
(check-expect (whatever->number #f) 20)
