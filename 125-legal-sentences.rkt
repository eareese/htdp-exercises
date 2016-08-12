;; Exercise 125. Discriminate the legal from the illegal sentences:

;; (define-struct oops [])
; This is legal, apparently there can be zero or more names inside the brackets.


;; (define-struct child [parents dob date])
; This is legal. There is an opening paren, the keyword define-struct, a name `child`, then a list of names `parents`, `dob`, and `date` inside the square brackets, followed by the closing paren.

;; (define-struct (child person) [dob date])
; illegal?? The name should not look like `(child person)`, when it should look like a name or variable -- one name only, and no parentheses.

;; Explain why the sentences are legal or illegal.
