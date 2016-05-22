(define (reward s)
  (cond [(<= 0 s 10) "bronze"]
        [(and (< 10 s) (<= s 20)) "silver"]
        [else "gold"]))
