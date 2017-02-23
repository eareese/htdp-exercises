#lang htdp/bsl+
;;---------------------------------------------------------------------------------------------------

;; Exercise 208. Design boolean-attributes. The function consumes an LLists and produces the Strings
;; that are associated with a Boolean attribute. Hint Use create-set from exercise 201.

;; Once you are done, determine how many Boolean-valued attributes your iTunes library employs for
;; its tracks. Do they make sense?

(define example1 (list (list (list "a" #t)
                             (list "b" 7))
                       (list (list "a" #f)
                             (list "b" 12))))
(check-expect (member? "a" (boolean-attributes example1)) #t)
(check-expect (length (boolean-attributes example1)) 1)
(check-expect (boolean-attributes example1)
              (list "a"))
(check-expect (boolean-attributes '()) '())
; LLists -> List-of-strings
; consumes an LLists, produces a list of the Strings associated with a Boolean attribute
(define (boolean-attributes llist)
  (cond
    [(empty? llist) '()]
    [else (create-set
           (append (lassoc-bool-attrs (first llist)) (boolean-attributes (rest llist))))]))

; LAssoc -> List-of-strings
; consumes a LAssoc and produces the list of attribute names which have Boolean values
(check-expect (lassoc-bool-attrs (list (list "a" #t) (list "z" 14))) (list "a"))
(check-expect (lassoc-bool-attrs '()) '())
(define (lassoc-bool-attrs lassoc)
  (cond
    [(empty? lassoc) '()]
    [(boolean? (second (first lassoc)))
     (cons (first (first lassoc)) (lassoc-bool-attrs (rest lassoc)))]
    [else (lassoc-bool-attrs (rest lassoc))]))



; List-of-strings -> List-of-strings
; produces a new List-of-strings that contains every String from the given list exactly once
(check-expect (create-set (list "a" "a" "a")) (list "a"))
(check-expect (length (create-set (list "a" "a" "a"))) 1)
(check-expect (create-set (list "a")) (list "a"))
(check-expect (length (create-set (list "a"))) 1)
(check-expect (create-set '()) '())
(define (create-set los)
  (cond
    [(empty? los) '()]
    [else (if (member? (first los) (rest los))
              (create-set (rest los))
              (cons (first los) (create-set (rest los))))]))
