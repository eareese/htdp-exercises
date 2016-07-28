#lang htdp/bsl

;; Design the function compare-word. The function consumes two (representations of) three-letter words. It produces a word that indicates where the given ones agree and disagree. The function retains the content of the structure fields if the two agree; otherwise it places #false in the field of the resulting word. Hint The exercises mentions two tasks: the comparison of words and the comparison of “letters.”

; ohh this clarifies the definition from before. oops

; Letter is one of:
; - # false
; - String of length 1
; interpretation #false means mismatch on the letter when compared
; to another letter in the same position of another word.
; ex: #f
; ex: "u"

; Word is a String that contains exactly three Letters
; ex: (define WCAT (make-word "c" "a" "t"))
; ex: (define RES (make-word #f #f #f))
(define-struct word [fst mid lst])

; Word Word -> Word
; produces a word that indicates where the given ones agree and disagree. If the
; letters agree, the letter is kept. otherwise it is #f in that field.
(check-expect (compare-word
               (make-word "c" "a" "t")
               (make-word "c" "a" "t"))
              (make-word "c" "a" "t"))
(check-expect (compare-word
               (make-word "c" "a" "t")
               (make-word "c" "a" "r"))
              (make-word "c" "a" #f))
; sure makes sense
(check-expect (compare-word
               (make-word #f #f #f)
               (make-word #f #f #f))
              (make-word #f #f #f))
(define (compare-word w1 w2)
  (make-word
   (cond [(eq? (word-fst w1) (word-fst w2)) (word-fst w1)] [else #f])
   (cond [(eq? (word-mid w1) (word-mid w2)) (word-mid w1)] [else #f])
   (cond [(eq? (word-lst w1) (word-lst w2)) (word-lst w1)] [else #f])))
