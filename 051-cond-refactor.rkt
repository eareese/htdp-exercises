#lang htdp/bsl

(define (create-rocket-scene.v5 h)
  (place-image ROCKET
               50
               (cond
                 [(<= h ROCKET-CENTER-TO-BOTTOM) h]
                 [else ROCKET-CENTER-TO-BOTTOM])
               MTSCN)
  (cond
     (place-image ROCKET 50 h SCENE)]
     (place-image ROCKET 50 ROCKET-CENTER-TO-BOTTOM)]))
