;; Exercise 123. The use of if may have surprised you in another way because this intermezzo does not mention this form elsewhere. In short, the intermezzo appears to explain and with a form that has no explanation either. At this point, we are relying on your intuitive understanding of if as a short-hand for cond. Write down a rule that shows how to reformulate

;; (if exp-test exp-then exp-else)

;; as a cond expression.

; rule? idk that. but I would rewrite to this cond expression:
;; (cond
;;   [(exp-test) exp-then]
;;   [else exp-else])
